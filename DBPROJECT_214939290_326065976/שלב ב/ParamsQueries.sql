
---------------------------- QUERIES WITH PARAMETERS ---------------------------

--------------------------------------------------------------------------------------
-- A query that receives a date and an employee number and returns all loans that the
--    employee approved after the given date, with information about them
SELECT 
    L.LserialNumber,
    L.LoDate,
    L.Urgency,
    L.returnDate,
    E.eName AS EmployeeName,
    O.OrDate AS OrderDate,
    O.PaymentMethod,
    C.cName AS ClientName,
    C.cRole AS ClientRole,
    CA.TypeCat AS CatalogType,
    EQ.Validity AS EquipmentValidity,
    EQ.LastUse AS EquipmentLastUse
FROM 
    Loans L
    JOIN Employees E ON L.EID = E.EID
    JOIN Orders O ON L.oserialnumber = O.OserialNumber
    JOIN Clients C ON O.CID = C.CID
    LEFT JOIN Equipment EQ ON O.OserialNumber = EQ.OserialNumber
    LEFT JOIN Catalog CA ON EQ.CatSerialNumber = CA.CatSerialNumber
WHERE 
    L.LoDate > TO_DATE('&date', 'YYYY-MM-DD')
    AND L.EID = &<name="employee" list="select eid from employees" restricted="yes">
ORDER BY 
    L.LoDate DESC;
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
-- Returns information about orders placed by a particular customer between requested dates
SELECT 
    O.OserialNumber,
    O.OrDate,
    O.PaymentMethod,
    C.cName AS ClientName,
    C.cRole AS ClientRole,
    SA.HospitalName,
    SA.hFloor,
    SA.hRoom,
    EQ.EqSerialNumber,
    EQ.Validity,
    EQ.LastUse,
    CA.TypeCat
FROM 
    Orders O
    JOIN Clients C ON O.CID = C.CID
    JOIN ShipmentAddress SA ON O.shipID = SA.shipID
    LEFT JOIN Equipment EQ ON O.OserialNumber = EQ.OserialNumber
    LEFT JOIN Catalog CA ON EQ.CatSerialNumber = CA.CatSerialNumber
WHERE 
    O.CID = &<name="client_id" list="select cid from clients" restricted="yes">
    AND O.OrDate BETWEEN TO_DATE('&start_date', 'YYYY-MM-DD') AND TO_DATE('&end_date', 'YYYY-MM-DD')
ORDER BY 
    O.OrDate;
--------------------------------------------------------------------------------------
    
--------------------------------------------------------------------------------------
-- Returns information on loans made by a client whose role is as requested and the urgency of the loan is as requested
SELECT 
    L.LserialNumber,
    L.LoDate,
    L.Urgency,
    L.returnDate,
    E.eName AS EmployeeName,
    O.OserialNumber,
    O.OrDate,
    O.PaymentMethod,
    C.cName AS ClientName,
    C.cRole AS ClientRole,
    C.cPhoneNumber AS ClientPhoneNumber
FROM 
    Loans L
    JOIN Employees E ON L.EID = E.EID
    JOIN Orders O ON L.oserialnumber = O.OserialNumber
    JOIN Clients C ON O.CID = C.CID
WHERE 
    C.cRole = &<name="client_role" list=" 'doctor', 'assistant', 'nurse' " restricted="yes" default="doctor">
    AND L.Urgency = &<name="urgency" list="1,2,3" restricted="yes" default=1>
ORDER BY 
    L.LoDate;
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
-- Returns the orders that were placed on the received date and also returns the date when the order was approved
SELECT O.OserialNumber, O.OrDate, L.LoDate
FROM Orders O
JOIN Loans L ON O.OserialNumber = L.OserialNumber
WHERE O.OrDate = to_date(&d_from, 'dd/mm/yyyy')
ORDER BY O.OrDate DESC;
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
-- Returns all the orders that were ordered to the place received as a parameter
SELECT O.OserialNumber, O.OrDate, L.LoDate
FROM Orders O
JOIN Loans L ON O.OserialNumber = L.OserialNumber
JOIN ShipmentAddress S ON O.shipID = S.shipID
WHERE S.HospitalName IN(
      &<name= "Hname" list="'hadsa', 'soroka', 'shaarey tzedek'" multiselect="yes" 
      hint = "number val between 1-999"
      required = true>)
      
  AND S.hFloor=
      &<name= "Hfloor"
      hint = "number val between 1-999"
      type = "integer"
      default="select min(hFloor) from ShipmentAddress">
  AND S.hRoom=
      &<name= "Hroom"
       hint = "number val between 1-999"
       type = "integer"
       required = true>
ORDER BY O.OrDate DESC;
--------------------------------------------------------------------------------------
