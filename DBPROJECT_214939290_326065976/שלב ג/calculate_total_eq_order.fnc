
-- The function receives a customer number and it returns the total of all the equipment
-- ordered by the customer and in addition prints the quantity of orders and the quantity of equipment
-- As a bonus, the function checks whether the customer pays only in cash and informs us!


CREATE OR REPLACE FUNCTION calculate_total_eq_order(
    p_CID IN Clients.CID%TYPE
) RETURN NUMBER IS

    total_amount NUMBER := 0;
    order_amount NUMBER := 0;
    total_equipment_count NUMBER := 0;
    all_cash_orders BOOLEAN := TRUE; -- Flag to track if all orders are paid in cash

    -- Define a record to hold order information
    TYPE order_info_rec IS RECORD (
        order_serial_number Orders.OserialNumber%TYPE,
        total_equipment_count NUMBER,
        payment_method Orders.PaymentMethod%TYPE
    );
    
    -- Define a cursor to fetch orders for the client
    CURSOR client_orders_cur IS
        SELECT o.OserialNumber, COUNT(e.EqSerialNumber) AS total_equipment_count, o.PaymentMethod
        FROM Orders o
        LEFT JOIN Equipment e ON o.OserialNumber = e.OserialNumber
        WHERE o.CID = p_CID
        GROUP BY o.OserialNumber, o.PaymentMethod;

    client_order_info order_info_rec;
BEGIN
    -- Open cursor
    OPEN client_orders_cur;
    
    -- Fetch orders and calculate total amount spent
    LOOP
        FETCH client_orders_cur INTO client_order_info;
        EXIT WHEN client_orders_cur%NOTFOUND;
        
        order_amount := order_amount + 1;
        total_equipment_count := total_equipment_count + client_order_info.total_equipment_count;
        
        -- Check if any order is not paid in cash
        IF client_order_info.payment_method != 'cash' THEN
            all_cash_orders := FALSE;
        END IF;
        
        -- Calculate total amount based on the number of equipment items
        total_amount := total_amount + client_order_info.total_equipment_count;

    END LOOP;

    -- Close cursor
    CLOSE client_orders_cur;
    
    -- If no orders found, raise an error
    IF order_amount = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No orders found for the client');
    END IF;
    
    -- Check if all orders are paid in cash
    IF all_cash_orders THEN
        DBMS_OUTPUT.PUT_LINE('******Star client - only cash*******');
    END IF;
    
    -- Print number of orders and total equipment count
    DBMS_OUTPUT.PUT_LINE('Number of Orders: ' || order_amount);
    DBMS_OUTPUT.PUT_LINE('Total Equipment Count: ' || total_equipment_count);
    
    RETURN total_amount;
END;
/
