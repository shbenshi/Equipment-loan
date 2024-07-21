------------views
----------------------------------------------------------------------------------
--                                  View 1
-- The view will combine information from the Orders, Clients, ShipmentAddress,
-- and Employees tables to provide a comprehensive look at order details,
-- including client and shipment information.
----------------------------------------------------------------------------------
CREATE VIEW OrderDetails AS
SELECT
  o.OrDate,
  o.OserialNumber,
  o.PaymentMethod,
  c.cName AS ClientName,
  c.cRole AS ClientRole,
  s.HospitalName,
  s.hRoom,
  e.eName AS EmployeeName,
  e.Salary AS EmployeeSalary
FROM
  Orders o
JOIN
  Clients c ON o.CID = c.CID
JOIN
  ShipmentAddress s ON o.shipID = s.shipID
LEFT JOIN
  Loans l ON o.OserialNumber = l.oserialnumber
LEFT JOIN
  Employees e ON l.EID = e.EID;

select * from OrderDetails

----------------------------------------------------------------------------------
--                                 Query 1.1
-- Get the details of all orders made by doctors, including the total number of
-- orders made by each doctor and the shipment address and payment method,
-- sorted by the number of orders in descending order.
----------------------------------------------------------------------------------

SELECT
  ClientName,
  COUNT(OserialNumber) AS TotalOrders,
  OrDate,
  PaymentMethod,
  HospitalName,
  hRoom
FROM
  OrderDetails
WHERE
  ClientRole = 'doctor'
GROUP BY
  ClientName,
  OrDate,
  PaymentMethod,
  HospitalName,
  hRoom
ORDER BY
  TotalOrders DESC;

----------------------------------------------------------------------------------
--                                 Query 1.2
-- List all orders along with the client and employee details, where the orders
-- were shipped to 'soroka' hospital and the payment method was either
-- 'credit card' or 'cash'. Additionally, include the number of days between the
-- order date and today.
----------------------------------------------------------------------------------

SELECT
  OserialNumber,
  OrDate,
  PaymentMethod,
  ClientName,
  ClientRole,
  EmployeeName,
  EmployeeSalary,
  HospitalName,
  hRoom,
  TRUNC(SYSDATE - OrDate) AS DaysSinceOrder
FROM
  OrderDetails
WHERE
  HospitalName = 'soroka'
  AND (PaymentMethod = 'credit card' OR PaymentMethod = 'cash')
ORDER BY
  DaysSinceOrder DESC;


----------------------------------------------------------------------------------
--                                  View 2
-- The view combines information from the patient, visit, doctor_visit,
--  and clients tables and provide a information about patient visits.
-- The view provides information on patients, the dates of their visits, 
--and information about the doctors associated with those visits.
----------------------------------------------------------------------------------
CREATE VIEW PatientVisit AS
SELECT
    d.cid AS doctor_id,
    d.cname AS doctor_name,
    d.crole AS doctor_role,
    d.cphonenumber AS doctor_phone,
    d.speciallization AS doctor_specialization,
    v.v_id,
    v.date_of_visit,
    p.p_id AS patient_id
FROM 
clients d
JOIN 
doctor_visit dv ON d.cid = dv.cid
JOIN 
visit v ON dv.v_id = v.v_id
LEFT JOIN 
patient p ON v.p_id = p.p_id
WHERE d.crole = 'doctor';


select * from PatientVisit


----------------------------------------------------------------------------------
--                                 Query 2.1
-- List all doctors, specifically focusing on the number of 
-- unique patients they have seen in the past month. It provides insights into the workload
-- and patient interaction for each doctor over the last month.
----------------------------------------------------------------------------------

SELECT
    doctor_id,
    doctor_name,
    doctor_specialization,
    COUNT(patient_id) AS unique_patients
FROM
    PatientVisit
WHERE
    date_of_visit >= TRUNC(SYSDATE, 'MONTH') - INTERVAL '1' MONTH
GROUP BY
    doctor_id,
    doctor_name,
    doctor_specialization
ORDER BY
    unique_patients DESC;


----------------------------------------------------------------------------------
--                                 Query 2.2
-- This query calculates the average number of visits per doctor for each specialization. It  
-- helps in understanding how busy doctors are on average within each specialization
-- it is show to every specialization the avg
----------------------------------------------------------------------------------
SELECT
    doctor_specialization,
    AVG(visit_count) AS avg_visits_per_doctor
FROM (
    SELECT
        doctor_specialization,
        doctor_id,
        COUNT(v_id) AS visit_count
    FROM
        PatientVisit
    GROUP BY
        doctor_specialization,
        doctor_id
)
GROUP BY
    doctor_specialization
ORDER BY
    avg_visits_per_doctor DESC;

