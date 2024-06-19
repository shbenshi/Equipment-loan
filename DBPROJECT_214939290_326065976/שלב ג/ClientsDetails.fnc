CREATE OR REPLACE FUNCTION ClientsDetails(p_CID IN Clients.CID%TYPE)
RETURN NUMBER 
IS  
    v_EmployeeCount NUMBER := 0;
    v_TotalSalary NUMBER := 0;

    -- Cursors
    CURSOR loan_cursor IS
        SELECT
            l.LserialNumber,
            l.returnDate,
            l.EID,
            l.oserialnumber
        FROM Loans l
        JOIN Orders o ON l.oserialnumber = o.OserialNumber
        WHERE o.CID = p_CID;

    CURSOR equipment_cursor IS
        SELECT
            e.EqSerialNumber,
            e.Validity,
            e.LastUse,
            e.CatSerialNumber,
            o.OserialNumber
        FROM Equipment e
        JOIN Orders o ON e.OserialNumber = o.OserialNumber
        WHERE o.CID = p_CID;
BEGIN
    -- Update return date for loans associated with the client
    BEGIN
        FOR loan_rec IN loan_cursor LOOP
            UPDATE Loans
            SET returnDate = SYSDATE
            WHERE LserialNumber = loan_rec.LserialNumber;
        END LOOP;

        IF SQL%NOTFOUND THEN
            DBMS_OUTPUT.PUT_LINE('No loans found for client with ID: ' || p_CID);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error updating loans: ' || SQLERRM);
    END;

    -- Check validity of equipment associated with the client's orders
    BEGIN
        FOR equipment_rec IN equipment_cursor LOOP
            IF equipment_rec.Validity - SYSDATE >= 0 THEN
                DBMS_OUTPUT.PUT_LINE('Equipment Serial Number ' || equipment_rec.EqSerialNumber || 
                                     ' has ' || TRUNC(equipment_rec.Validity - SYSDATE) || 
                                     ' days remaining until it expires.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Equipment Serial Number ' || equipment_rec.EqSerialNumber || 
                                     ' has expired.');
            END IF;
        END LOOP;

        IF SQL%NOTFOUND THEN
            DBMS_OUTPUT.PUT_LINE('No equipment found for client with ID: ' || p_CID);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error checking equipment validity: ' || SQLERRM);
    END;

    -- Count the number of different employees who handled the client's orders
    BEGIN
        SELECT COUNT(DISTINCT l.EID)
        INTO v_EmployeeCount
        FROM Loans l
        JOIN Orders o ON l.oserialnumber = o.OserialNumber
        WHERE o.CID = p_CID;

        IF v_EmployeeCount = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No orders found for client with ID: ' || p_CID);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error counting employees: ' || SQLERRM);
    END;

    -- Calculate total salary of employees who handled the client's orders
    BEGIN
        FOR emp IN (
            SELECT DISTINCT e.EID, e.eName, e.Salary
            FROM Employees e
            JOIN Loans l ON e.EID = l.EID
            JOIN Orders o ON l.oserialnumber = o.OserialNumber
            WHERE o.CID = p_CID
        ) LOOP
            v_TotalSalary := v_TotalSalary + emp.Salary;
            DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp.eName || ' (ID: ' || emp.EID || ') has a salary of ' || emp.Salary);
        END LOOP;

        IF v_TotalSalary = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No employees found for client with ID: ' || p_CID);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error calculating total salary: ' || SQLERRM);
    END;

    -- Output total salary of the employees
    DBMS_OUTPUT.PUT_LINE('Total salary of the employees: ' || v_TotalSalary);

    RETURN v_EmployeeCount; 
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for client with ID: ' || p_CID);
        RETURN 0; -- Return 0 if no data found
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ClientsDetails function: ' || SQLERRM);
        RETURN -1; -- Return -1 for other errors
END;
/
