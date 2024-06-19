CREATE OR REPLACE PROCEDURE UpdateAddress(
    PCid IN NUMBER, -- client id 
    PCname IN VARCHAR2, -- client name 
    PSfloor IN NUMBER, -- floor for update
    PSroom IN NUMBER, -- room for update
    PShospital IN VARCHAR2 -- hospital name for update
) 
IS
    v_product_count NUMBER; -- number of products in order
    v_existing_shipid ShipmentAddress.shipID%TYPE; -- store the existing ship id
    v_max_id NUMBER; -- the max ship id for adding new address

    -- Cursor to fetch orders for the given client ID and name
    CURSOR PeopleList IS 
        select  c.CID AS client_id,
            c.cName AS client_name,
            o.OserialNumber AS order_serial_number,
            o.OrDate AS order_date,
            o.PaymentMethod AS payment_method,
            o.shipID AS order_ship_id,
            s.shipID AS shipment_ship_id,
            s.hFloor AS shipment_floor,
            s.hRoom AS shipment_room,
            s.HospitalName AS shipment_hospital_name
        from clients c, shipmentaddress s, orders o
        where c.cid = o.cid and s.shipid = o.shipid
        and c.cid = PCid and c.cname = PCname;
BEGIN

    -- Enable server output
    DBMS_OUTPUT.ENABLE(1000000);

    FOR order_rec IN PeopleList LOOP
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Checking order ' || order_rec.order_serial_number);

            -- Check if the order has products
            SELECT COUNT(*)
            INTO v_product_count
            FROM Equipment
            WHERE OserialNumber = order_rec.order_serial_number;

            BEGIN
                -- Check if shipment address exists for the order
                SELECT shipID
                INTO v_existing_shipid
                FROM ShipmentAddress
                WHERE shipID = order_rec.order_ship_id;
               
                DBMS_OUTPUT.PUT_LINE('Address with floor ' || PSfloor || ', room ' || PSroom || ', and hospital ' || PShospital || ' already exists. Updating order with existing shipID.');
                
                UPDATE Orders
                SET shipID = v_existing_shipid
                WHERE OserialNumber = order_rec.order_serial_number;
-------------------------------------------------------------------------
                -- If we reach here, shipment address exists
                IF v_product_count = 0 THEN
                    DBMS_OUTPUT.PUT_LINE('No products in order, setting default address values');
                    -- No products in the order, update shipment address to default values
                    UPDATE ShipmentAddress
                    SET hFloor = 0,
                        hRoom = 0
                    WHERE shipID = order_rec.order_ship_id;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Products found, updating address with provided values');
                    -- Products found in the order, update shipment address to provided values
                    UPDATE ShipmentAddress
                    SET hFloor = PSfloor,
                        hRoom = PSroom,
                        HospitalName = PShospital
                    WHERE shipID = order_rec.order_ship_id;
                END IF;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    DBMS_OUTPUT.PUT_LINE('No shipment address found, adding new address');
                    -- Shipment address does not exist, create it
                    SELECT NVL(MAX(shipid), 0) INTO v_max_id FROM ShipmentAddress;
                    INSERT INTO ShipmentAddress(shipid, hFloor, hRoom, HospitalName)
                    VALUES (v_max_id + 1, PSfloor, PSroom, PShospital);

                    -- Link the new shipment address to the order
                    UPDATE Orders
                    SET shipID = v_max_id + 1
                    WHERE OserialNumber = order_rec.order_serial_number;
            END;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No equipment found for order ' || order_rec.order_serial_number);
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        END;
    END LOOP;

    -- Commit the transaction
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Orders updated successfully.');
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE(' ');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No matching shipment address found or no orders for the given client.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error bla bla: ' || SQLERRM);
END;
/
