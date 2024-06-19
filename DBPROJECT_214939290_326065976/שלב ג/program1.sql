
DECLARE
    v_CID Clients.CID%TYPE;
    v_shipID ShipmentAddress.shipID%TYPE;
    v_eqSerialNumber Equipment.EqSerialNumber%TYPE;
    v_paymentMethod Orders.PaymentMethod%TYPE;
    v_oSerialNumber Orders.OserialNumber%TYPE;
    v_orderDetails SYS_REFCURSOR; -- Cursor variable declaration
    v_order_date Orders.OrDate%TYPE;
    v_order_serial Orders.OserialNumber%TYPE;
    v_payment_method Orders.PaymentMethod%TYPE;
    v_client_id Orders.CID%TYPE;
    v_shipment_id Orders.shipID%TYPE;
    v_total_equipment_count NUMBER;
BEGIN
    -- Get user input
    v_CID := &v_CID;

    v_shipID := &v_shipID;
    v_eqSerialNumber := &v_eqSerialNumber;
    v_paymentMethod := '&v_paymentMethod';
    
    -- Call the procedure to add a new order
    add_new_order(
        p_paymentMethod => v_paymentMethod,
        p_CID => v_CID,
        p_shipID => v_shipID,
        p_eqSerialNumber => v_eqSerialNumber,
        p_oSerialNumber => v_oSerialNumber,
        p_orderDetails => v_orderDetails
    );
    
    -- Fetch and display the details of the newly created order
    DBMS_OUTPUT.PUT_LINE('Newly Order Details:');
    LOOP
        FETCH v_orderDetails INTO
            v_order_date,
            v_order_serial,
            v_payment_method,
            v_client_id,
            v_shipment_id;
        EXIT WHEN v_orderDetails%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Order Date: ' || v_order_date);
        DBMS_OUTPUT.PUT_LINE('Order Serial Number: ' || v_order_serial);
        DBMS_OUTPUT.PUT_LINE('Payment Method: ' || v_payment_method);
        DBMS_OUTPUT.PUT_LINE('Client ID: ' || v_client_id);
        DBMS_OUTPUT.PUT_LINE('Shipment ID: ' || v_shipment_id);
    END LOOP;
    CLOSE v_orderDetails;
    
    -- Call the function to calculate total equipment count
    v_total_equipment_count := calculate_total_eq_order(
        p_CID => v_CID
    );

    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

