DECLARE
    v_CID Clients.CID%TYPE;
    v_CName Clients.cName%TYPE;
    v_Floor NUMBER;
    v_Room NUMBER;  
    v_Hospital ShipmentAddress.HospitalName%TYPE;   
    v_EmployeeCount NUMBER;
    v_TotalSalary NUMBER;
BEGIN
 -- enter deatils
  v_cid  := &p_CID;
  v_cname := '&p_CName';
  v_Floor := &p_Floor;
  v_Room := &p_Room;
  v_Hospital :='&p_Hospital';
 
  DBMS_OUTPUT.PUT_LINE('Client ID: ' || v_CID);
  DBMS_OUTPUT.PUT_LINE('Client Name: ' || v_CName);
  DBMS_OUTPUT.PUT_LINE('New Address: Floor ' || v_Floor || ', Room ' || v_Room || ', Hospital Name: ' || v_Hospital);
  DBMS_OUTPUT.PUT_LINE(' ');   
  -- call the procedure
   UpdateAddress(v_CID, v_CName, v_Floor, v_Room, v_Hospital);
    COMMIT;
  -- call the func 
  v_EmployeeCount := ClientsDetails(v_CID);
   -- Output total count of different employees
  DBMS_OUTPUT.PUT_LINE('Number of different employees who handled the orders: ' || v_EmployeeCount);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
