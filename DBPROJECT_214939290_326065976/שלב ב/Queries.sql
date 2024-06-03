

---------------------------- SELECT ---------------------------

------------------------------------------------------------------------------------
-- A selection query that returns the name and salary of the employees who handled more than 4 orders
SELECT ename, salary
FROM employees
WHERE eid IN( SELECT EID
              FROM  Loans l
              GROUP BY eid
              HAVING COUNT(*) > 4)
ORDER BY salary;
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- A selection query that returns the details of employees who handle loans with urgency 1
SELECT eid, ename, salary
FROM employees
WHERE eid IN( SELECT eid 
              FROM loans
              WHERE urgency = 1);
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- Returns all the orders without equipment
SELECT oserialnumber, cname, crole
FROM orders NATURAL JOIN clients
WHERE oserialnumber NOT IN (SELECT oserialnumber 
                            FROM equipment)
ORDER BY oserialnumber;
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- Returns the name of the hospital, room and floor to which the most orders were made
SELECT hospitalname, hfloor, hroom 
FROM shipmentaddress 
WHERE shipid IN (SELECT shipid 
                 FROM orders 
                 GROUP BY shipid 
                 HAVING COUNT(*) = (SELECT MAX(COUNT(*)) 
                                    FROM orders 
                                    GROUP BY shipid) )
ORDER BY hospitalname,hfloor,hroom;
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
-- Returns all the information in the system about the orders made in 2024
SELECT
    O.OserialNumber AS "Order Serial Number",
    O.OrDate AS "Order Date",
    O.PaymentMethod AS "Payment Method",
    C.CID AS "Client ID",
    C.cName AS "Client Name",
    C.cRole AS "Client Role",
    C.cPhoneNumber AS "Client Phone Number",
    SA.HospitalName AS "Hospital Name",
    SA.hFloor AS "Hospital Floor",
    SA.hRoom AS "Hospital Room",
    E.EqSerialNumber AS "Equipment Serial Number",
    E.Validity AS "Equipment Validity",
    E.LastUse AS "Last Equipment Use",
    L.LserialNumber AS "Loan Serial Number",
    L.LoDate AS "Loan Date",
    L.Urgency AS "Loan Urgency",
    L.returnDate AS "Loan Return Date",
    Emp.EID AS "Employee ID",
    Emp.eName AS "Employee Name",
    Emp.Salary AS "Employee Salary",
    Emp.EPhoneNumber AS "Employee Phone Number"
FROM
    Orders O
JOIN
    Clients C ON O.CID = C.CID
JOIN
    ShipmentAddress SA ON O.shipID = SA.shipID
LEFT JOIN
    Equipment E ON O.OserialNumber = E.OserialNumber
LEFT JOIN
    Loans L ON O.OserialNumber = L.Oserialnumber
LEFT JOIN
    Employees Emp ON L.EID = Emp.EID
WHERE
    O.OrDate BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-12-31', 'YYYY-MM-DD')
ORDER BY
    C.cid, O.Oserialnumber, O.OrDate DESC;
--------------------------------------------------------------------------------------


---------------------------- DELETE ---------------------------

--------------------------------------------------------------------------------------
-- 3 deletion queries that receive a date and delete the order that was placed on that date.
--  To delete it, you first need to delete the equipment associated with it and also delete its loan

-- Delete entries from the Equipment table that are related to the order
DELETE FROM Equipment
WHERE OserialNumber IN (
  SELECT OserialNumber
  FROM Orders
  WHERE OrDate = TO_DATE('&date', 'YYYY-MM-DD')
);

-- Delete entries from the Loans table that are related to the order
DELETE FROM Loans
WHERE OserialNumber IN (
  SELECT OserialNumber
  FROM Orders
  WHERE OrDate = TO_DATE('&date', 'YYYY-MM-DD')
);

-- Finally, delete the order itself from the Orders table
DELETE FROM Orders
WHERE OrDate = TO_DATE('&date', 'YYYY-MM-DD');
--------------------------------------------------------------------------------------


---------------------------- UPDATE ---------------------------

--------------------------------------------------------------------------------------
-- Update the salary of employees who have processed more than 4 loans
UPDATE Employees E
SET Salary = Salary + 1000
WHERE EID IN (
    SELECT L.EID
    FROM Loans L
    GROUP BY L.EID
    HAVING COUNT(*) > 4
);
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
-- Update the amount of equipment that in orders to be -1 in catalog 
UPDATE Catalog
SET Amount = Amount - 1
WHERE CatSerialNumber IN ( SELECT E.CatSerialNumber
                           FROM Equipment E
                           JOIN Orders O ON E.OserialNumber = O.OserialNumber
                           JOIN Loans L ON O.OserialNumber = L.OserialNumber );
--------------------------------------------------------------------------------------

