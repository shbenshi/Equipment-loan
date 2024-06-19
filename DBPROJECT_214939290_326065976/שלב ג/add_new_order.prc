-- "This procedure adds a new order to the Orders table and updates the Equipment table if necessary.
-- It checks if the equipment is already associated with an order and updates it if the same client and ship ID exist,
-- otherwise creates a new order."

CREATE OR REPLACE PROCEDURE add_new_order(
  p_paymentMethod IN VARCHAR2,
  p_CID IN NUMBER,
  p_shipID IN NUMBER,
  p_eqSerialNumber IN NUMBER,
  p_oSerialNumber OUT NUMBER,
  p_orderDetails OUT SYS_REFCURSOR
) IS
  equipment_in_use EXCEPTION;
  PRAGMA EXCEPTION_INIT(equipment_in_use, -20001);
  

BEGIN
  --------------------------------------------------------------------
-- Check if the equipment is already associated with another order
  DECLARE
    v_existingOrder NUMBER;
  BEGIN
    SELECT OserialNumber INTO v_existingOrder
    FROM Equipment
    WHERE EqSerialNumber = p_eqSerialNumber
      AND OserialNumber IS NOT NULL;

    IF SQL%FOUND THEN
      RAISE equipment_in_use;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;  -- No existing order, continue with the process
  END;
  --------------------------------------------------------------------

  -- Check if there is an existing order with the same client and shipID and is not aproved yet
  BEGIN
    SELECT OserialNumber INTO p_oSerialNumber
    FROM Orders
    WHERE CID = p_CID
      AND shipID = p_shipID
      AND ROWNUM = 1
      AND NOT EXISTS (SELECT 1 FROM loans WHERE loans.oserialnumber = Orders.OserialNumber); 

    -- Debug print
    DBMS_OUTPUT.PUT_LINE('Existing Order: ' || p_oSerialNumber);

    -- If found, update the equipment and return
    UPDATE Equipment
    SET OserialNumber = p_oSerialNumber
    WHERE EqSerialNumber = p_eqSerialNumber;

    COMMIT;

    -- Open a ref cursor to return the details of the existing order
    OPEN p_orderDetails FOR
      SELECT OrDate, OserialNumber, PaymentMethod, CID, shipID
      FROM Orders
      WHERE OserialNumber = p_oSerialNumber;

    RETURN; -- Exit procedure if existing order is found
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;  -- No existing order with the same client and shipID, continue
  END;

  --------------------------------------------------------------------
  -- Insert a new order and get the new serial number
  SELECT NVL(MAX(OserialNumber), 0) + 1 INTO p_oSerialNumber FROM Orders;

  INSERT INTO Orders (OrDate, OserialNumber, PaymentMethod, CID, shipID)
  VALUES (SYSDATE, p_oSerialNumber, p_paymentMethod, p_CID, p_shipID);

  IF NOT SQL%FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'Order insertion failed.');
  END IF;

  -- Update the Equipment table with the new order serial number
  UPDATE Equipment
  SET OserialNumber = p_oSerialNumber
  WHERE EqSerialNumber = p_eqSerialNumber;

  IF SQL%ROWCOUNT = 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Equipment update failed.');
  END IF;

  COMMIT;

  -- Open a ref cursor to return the details of the newly created order
  OPEN p_orderDetails FOR
    SELECT OrDate, OserialNumber, PaymentMethod, CID, shipID
    FROM Orders
    WHERE OserialNumber = p_oSerialNumber;

EXCEPTION
  WHEN equipment_in_use THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20001, 'The equipment is already associated with another order.');
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/
