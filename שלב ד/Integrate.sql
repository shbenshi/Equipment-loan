--------------------------------------------------------------------------------------------
----------------------------------------integrate-------------------------------------------
--------------------------------------------------------------------------------------------
--add speciallization
alter table clients 
add  speciallization VARCHAR2(30)

select * from clients;
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
-- add dep_id, num_of_beds, availability
alter table shipmentaddress 
add dep_id INTEGER 
add  num_of_beds INTEGER
add availability VARCHAR2(30)

--drop hfloor
ALTER TABLE shipmentaddress DROP column HFLOOR; 

--add foreign key to shipmentadress
alter table shipmentaddress
  add foreign key (DEP_ID)
  references DEPARTMENT (DEP_ID);
  
-- availability - Available\Occupied
alter table shipmentaddress
  add constraint A_CHECK
  check ( availability IN('Available','Occupied'));

select * from shipmentaddress
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
-- copy data from room table to shipmentaddress table
INSERT INTO shipmentaddress (shipid, hroom, hospitalname, availability,dep_id ,num_of_beds)
SELECT 
    ROWNUM + (SELECT NVL(MAX(shipid), 0) FROM shipmentaddress) AS shipid,
    room_number AS hroom,
    'soroka' AS hospitalname,
    availability,
    1 as dep_id,
    num_of_beds
FROM Room;

select * from shipmentaddress
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
--add ship_id
alter table patient 
add ship_id NUMBER(3) 

-- set ship id as a foreign key
alter table patient
  add foreign key (ship_id)
  references shipmentaddress (shipid);

update patient 
set ship_id = (select shipid from shipmentaddress where hroom = room_number);

select * from patient;

--drop room_number and room table 
ALTER TABLE patient DROP column room_number; 
drop table room;
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
-- add cid to doctor_visit
alter table doctor_visit 
add cid NUMBER(3);

-- set cid as a foreign key
alter table doctor_visit
  add foreign key (Cid)
  references clients (cid);

-- set cid and v_id as primary key
ALTER TABLE DOCTOR_VISIT
add  primary key (cid, v_id);

select * from doctor_visit
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
--transfer doctors to clients
INSERT INTO CLIENTS (CID, CNAME, CROLE, CPHONENUMBER, SPECIALLIZATION)
SELECT 
    ROWNUM + (SELECT NVL(MAX(CID), 0) FROM CLIENTS) AS CID,
    D_NAME AS CNAME,
    'doctor' AS CROLE,
    D_PHONE AS CPHONENUMBER,
    SPECIALLIZATION
FROM DOCTOR;

select * from doctor_visit

-- copy d_id to cid 
update doctor_visit
set cid = d_id + 599
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
-- check what are the constraints on d_id in doctor_visit table
SELECT constraint_name
FROM user_cons_columns
WHERE table_name = 'DOCTOR_VISIT'
AND column_name = 'D_ID';

-- delete constraints
 ALTER TABLE DOCTOR_VISIT
DROP CONSTRAINT SYS_C008177;
 ALTER TABLE DOCTOR_VISIT
DROP CONSTRAINT  SYS_C008178;
 ALTER TABLE DOCTOR_VISIT
DROP CONSTRAINT  SYS_C008180;

-- delete d_id
ALTER TABLE DOCTOR_VISIT
DROP COLUMN D_ID;

-- delete doctor
drop table doctor
--------------------------------------------------------------------------------------------






