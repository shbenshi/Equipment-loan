prompt PL/SQL Developer import file
prompt Created on �������� 21 ���� 2024 by SHI32
set feedback off
set define off
prompt Creating CATALOG...
create table CATALOG
(
  catserialnumber NUMBER(3) not null,
  typecat         VARCHAR2(15) not null,
  amount          NUMBER(5) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CATALOG
  add primary key (CATSERIALNUMBER)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CLIENTS...
create table CLIENTS
(
  cid             NUMBER(3) not null,
  cname           VARCHAR2(15) not null,
  crole           VARCHAR2(15),
  cphonenumber    VARCHAR2(10) not null,
  speciallization VARCHAR2(30)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLIENTS
  add primary key (CID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLIENTS
  add check (cRole='doctor' or cRole='nurse' or cRole='assistant');

prompt Creating DEPARTMENT...
create table DEPARTMENT
(
  cuurent_num_of_patient INTEGER not null,
  dep_name               VARCHAR2(30) not null,
  floor                  INTEGER not null,
  dep_id                 INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DEPARTMENT
  add primary key (DEP_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SHIPMENTADDRESS...
create table SHIPMENTADDRESS
(
  hospitalname VARCHAR2(20),
  hroom        NUMBER(3) not null,
  shipid       NUMBER(3) not null,
  dep_id       INTEGER,
  num_of_beds  INTEGER,
  availability VARCHAR2(30)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SHIPMENTADDRESS
  add primary key (SHIPID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SHIPMENTADDRESS
  add foreign key (DEP_ID)
  references DEPARTMENT (DEP_ID);
alter table SHIPMENTADDRESS
  add constraint A_CHECK
  check ( availability IN('Available','Occupied'));
alter table SHIPMENTADDRESS
  add check (hospitalname='soroka' or hospitalname='hadsa' or hospitalname='shaarey tzedek');

prompt Creating PATIENT...
create table PATIENT
(
  p_id                    INTEGER not null,
  status                  VARCHAR2(30) not null,
  address                 VARCHAR2(20) not null,
  date_of_birth           DATE not null,
  p_name                  VARCHAR2(30) not null,
  p_phone                 INTEGER not null,
  date_of_hospitalization DATE not null,
  date_of_release         DATE,
  ship_id                 NUMBER(3)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PATIENT
  add primary key (P_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PATIENT
  add foreign key (SHIP_ID)
  references SHIPMENTADDRESS (SHIPID);

prompt Creating VISIT...
create table VISIT
(
  v_id          INTEGER not null,
  date_of_visit DATE not null,
  p_id          INTEGER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VISIT
  add primary key (V_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VISIT
  add foreign key (P_ID)
  references PATIENT (P_ID);

prompt Creating DOCTOR_VISIT...
create table DOCTOR_VISIT
(
  v_id INTEGER not null,
  cid  NUMBER(3)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DOCTOR_VISIT
  add foreign key (V_ID)
  references VISIT (V_ID);
alter table DOCTOR_VISIT
  add foreign key (CID)
  references CLIENTS (CID);

prompt Creating EMPLOYEES...
create table EMPLOYEES
(
  eid          NUMBER(3) not null,
  ename        VARCHAR2(15) not null,
  salary       NUMBER(7) not null,
  ephonenumber VARCHAR2(10) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EMPLOYEES
  add primary key (EID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating ORDERS...
create table ORDERS
(
  ordate        DATE not null,
  oserialnumber NUMBER(3) not null,
  paymentmethod VARCHAR2(15),
  cid           NUMBER(3) not null,
  shipid        NUMBER(3) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERS
  add primary key (OSERIALNUMBER)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERS
  add foreign key (CID)
  references CLIENTS (CID);
alter table ORDERS
  add foreign key (SHIPID)
  references SHIPMENTADDRESS (SHIPID);
alter table ORDERS
  add check (paymentmethod='bit' or paymentmethod='paybox' or paymentmethod='cash' or paymentmethod='credit card');

prompt Creating EQUIPMENT...
create table EQUIPMENT
(
  eqserialnumber  NUMBER(3) not null,
  validity        DATE not null,
  lastuse         DATE,
  catserialnumber NUMBER(3) not null,
  oserialnumber   NUMBER(3)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPMENT
  add primary key (EQSERIALNUMBER)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPMENT
  add foreign key (CATSERIALNUMBER)
  references CATALOG (CATSERIALNUMBER);
alter table EQUIPMENT
  add foreign key (OSERIALNUMBER)
  references ORDERS (OSERIALNUMBER);

prompt Creating LOANS...
create table LOANS
(
  lserialnumber NUMBER(3) not null,
  lodate        DATE not null,
  urgency       NUMBER(1) default 3,
  returndate    DATE not null,
  eid           NUMBER(3) not null,
  oserialnumber NUMBER(3) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LOANS
  add primary key (LSERIALNUMBER)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LOANS
  add unique (OSERIALNUMBER)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LOANS
  add foreign key (EID)
  references EMPLOYEES (EID);
alter table LOANS
  add foreign key (OSERIALNUMBER)
  references ORDERS (OSERIALNUMBER);
alter table LOANS
  add check (urgency=1 or urgency=2 or urgency=3);

prompt Creating MEDICINIES...
create table MEDICINIES
(
  qualitity_available_in_stock INTEGER default 0 not null,
  m_id                         INTEGER not null,
  n_name                       VARCHAR2(30) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEDICINIES
  add primary key (M_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating MEDICATION_VISIT...
create table MEDICATION_VISIT
(
  v_id INTEGER not null,
  m_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEDICATION_VISIT
  add primary key (V_ID, M_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEDICATION_VISIT
  add foreign key (V_ID)
  references VISIT (V_ID);
alter table MEDICATION_VISIT
  add foreign key (M_ID)
  references MEDICINIES (M_ID);

prompt Disabling triggers for CATALOG...
alter table CATALOG disable all triggers;
prompt Disabling triggers for CLIENTS...
alter table CLIENTS disable all triggers;
prompt Disabling triggers for DEPARTMENT...
alter table DEPARTMENT disable all triggers;
prompt Disabling triggers for SHIPMENTADDRESS...
alter table SHIPMENTADDRESS disable all triggers;
prompt Disabling triggers for PATIENT...
alter table PATIENT disable all triggers;
prompt Disabling triggers for VISIT...
alter table VISIT disable all triggers;
prompt Disabling triggers for DOCTOR_VISIT...
alter table DOCTOR_VISIT disable all triggers;
prompt Disabling triggers for EMPLOYEES...
alter table EMPLOYEES disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for EQUIPMENT...
alter table EQUIPMENT disable all triggers;
prompt Disabling triggers for LOANS...
alter table LOANS disable all triggers;
prompt Disabling triggers for MEDICINIES...
alter table MEDICINIES disable all triggers;
prompt Disabling triggers for MEDICATION_VISIT...
alter table MEDICATION_VISIT disable all triggers;
prompt Disabling foreign key constraints for SHIPMENTADDRESS...
alter table SHIPMENTADDRESS disable constraint SYS_C008190;
prompt Disabling foreign key constraints for PATIENT...
alter table PATIENT disable constraint SYS_C008191;
prompt Disabling foreign key constraints for VISIT...
alter table VISIT disable constraint SYS_C008175;
prompt Disabling foreign key constraints for DOCTOR_VISIT...
alter table DOCTOR_VISIT disable constraint SYS_C008179;
alter table DOCTOR_VISIT disable constraint SYS_C008192;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint SYS_C008128;
alter table ORDERS disable constraint SYS_C008129;
prompt Disabling foreign key constraints for EQUIPMENT...
alter table EQUIPMENT disable constraint SYS_C008135;
alter table EQUIPMENT disable constraint SYS_C008136;
prompt Disabling foreign key constraints for LOANS...
alter table LOANS disable constraint SYS_C008144;
alter table LOANS disable constraint SYS_C008145;
prompt Disabling foreign key constraints for MEDICATION_VISIT...
alter table MEDICATION_VISIT disable constraint SYS_C008188;
alter table MEDICATION_VISIT disable constraint SYS_C008189;
prompt Deleting MEDICATION_VISIT...
delete from MEDICATION_VISIT;
commit;
prompt Deleting MEDICINIES...
delete from MEDICINIES;
commit;
prompt Deleting LOANS...
delete from LOANS;
commit;
prompt Deleting EQUIPMENT...
delete from EQUIPMENT;
commit;
prompt Deleting ORDERS...
delete from ORDERS;
commit;
prompt Deleting EMPLOYEES...
delete from EMPLOYEES;
commit;
prompt Deleting DOCTOR_VISIT...
delete from DOCTOR_VISIT;
commit;
prompt Deleting VISIT...
delete from VISIT;
commit;
prompt Deleting PATIENT...
delete from PATIENT;
commit;
prompt Deleting SHIPMENTADDRESS...
delete from SHIPMENTADDRESS;
commit;
prompt Deleting DEPARTMENT...
delete from DEPARTMENT;
commit;
prompt Deleting CLIENTS...
delete from CLIENTS;
commit;
prompt Deleting CATALOG...
delete from CATALOG;
commit;
prompt Loading CATALOG...
insert into CATALOG (catserialnumber, typecat, amount)
values (1, '1JW8P57CJ55', 809);
insert into CATALOG (catserialnumber, typecat, amount)
values (2, '4AM6DH7FR25', 454);
insert into CATALOG (catserialnumber, typecat, amount)
values (3, '3N72KY0FF55', 149);
insert into CATALOG (catserialnumber, typecat, amount)
values (4, '4QD5YR7QC62', 309);
insert into CATALOG (catserialnumber, typecat, amount)
values (5, '2H57N88TJ96', 669);
insert into CATALOG (catserialnumber, typecat, amount)
values (6, '4YJ6JR6JE13', 412);
insert into CATALOG (catserialnumber, typecat, amount)
values (7, '5ER8RM0UN26', 311);
insert into CATALOG (catserialnumber, typecat, amount)
values (8, '7A20HU1GV45', 578);
insert into CATALOG (catserialnumber, typecat, amount)
values (9, '1XC0AM3VX59', 160);
insert into CATALOG (catserialnumber, typecat, amount)
values (10, '2A80H73MG14', 393);
insert into CATALOG (catserialnumber, typecat, amount)
values (11, '3K41D95KN73', 267);
insert into CATALOG (catserialnumber, typecat, amount)
values (12, '7EP8W91WT08', 40);
insert into CATALOG (catserialnumber, typecat, amount)
values (13, '4NH7CR1JM11', 517);
insert into CATALOG (catserialnumber, typecat, amount)
values (14, '3YP2KF1DD23', 894);
insert into CATALOG (catserialnumber, typecat, amount)
values (15, '7ER0N56GY94', 293);
insert into CATALOG (catserialnumber, typecat, amount)
values (16, '1YR9QM0FD40', 873);
insert into CATALOG (catserialnumber, typecat, amount)
values (17, '1XU6Q30TK62', 674);
insert into CATALOG (catserialnumber, typecat, amount)
values (18, '9DT5QK2DR04', 19);
insert into CATALOG (catserialnumber, typecat, amount)
values (19, '3FV4YD7RR64', 315);
insert into CATALOG (catserialnumber, typecat, amount)
values (20, '4FP3C84AM11', 598);
insert into CATALOG (catserialnumber, typecat, amount)
values (21, '5U00PX0HV99', 716);
insert into CATALOG (catserialnumber, typecat, amount)
values (22, '6VT6JQ1VE91', 614);
insert into CATALOG (catserialnumber, typecat, amount)
values (23, '7YR7VG9TC27', 332);
insert into CATALOG (catserialnumber, typecat, amount)
values (24, '8PP6DC4AA48', 118);
insert into CATALOG (catserialnumber, typecat, amount)
values (25, '4DQ0PD1FH83', 582);
insert into CATALOG (catserialnumber, typecat, amount)
values (26, '7Q12M36JD49', 967);
insert into CATALOG (catserialnumber, typecat, amount)
values (27, '9Q94JX9WK93', 777);
insert into CATALOG (catserialnumber, typecat, amount)
values (28, '2AP0E53MF55', 852);
insert into CATALOG (catserialnumber, typecat, amount)
values (29, '9DF4KA2JT38', 100);
insert into CATALOG (catserialnumber, typecat, amount)
values (30, '3GX0MH7WQ18', 67);
insert into CATALOG (catserialnumber, typecat, amount)
values (31, '1FR4K42EJ73', 531);
insert into CATALOG (catserialnumber, typecat, amount)
values (32, '9YM7D29TT73', 781);
insert into CATALOG (catserialnumber, typecat, amount)
values (33, '7FU2V79CF63', 637);
insert into CATALOG (catserialnumber, typecat, amount)
values (34, '2XY1ND3CT03', 757);
insert into CATALOG (catserialnumber, typecat, amount)
values (35, '6YN2M26NT01', 343);
insert into CATALOG (catserialnumber, typecat, amount)
values (36, '9J60Q40KQ42', 699);
insert into CATALOG (catserialnumber, typecat, amount)
values (37, '1UE0AM4TG28', 997);
insert into CATALOG (catserialnumber, typecat, amount)
values (38, '9H89YE9YD74', 690);
insert into CATALOG (catserialnumber, typecat, amount)
values (39, '5AC8TJ2DT50', 785);
insert into CATALOG (catserialnumber, typecat, amount)
values (40, '8DT9C26VV10', 485);
insert into CATALOG (catserialnumber, typecat, amount)
values (41, '4P79FY1GD85', 882);
insert into CATALOG (catserialnumber, typecat, amount)
values (42, '1KT1TE1CU80', 259);
insert into CATALOG (catserialnumber, typecat, amount)
values (43, '6WE6G37KH82', 119);
insert into CATALOG (catserialnumber, typecat, amount)
values (44, '4A11E92WR80', 451);
insert into CATALOG (catserialnumber, typecat, amount)
values (45, '4JG1ET1PA29', 624);
insert into CATALOG (catserialnumber, typecat, amount)
values (46, '4HH9T56QU30', 532);
insert into CATALOG (catserialnumber, typecat, amount)
values (47, '4E86WQ3PT82', 898);
insert into CATALOG (catserialnumber, typecat, amount)
values (48, '3RF2DE0FU39', 523);
insert into CATALOG (catserialnumber, typecat, amount)
values (49, '1EY7NC4WK80', 559);
insert into CATALOG (catserialnumber, typecat, amount)
values (50, '3V27F12AH53', 148);
insert into CATALOG (catserialnumber, typecat, amount)
values (51, '3U20MM8YT20', 401);
insert into CATALOG (catserialnumber, typecat, amount)
values (52, '6RV9A67HR42', 305);
insert into CATALOG (catserialnumber, typecat, amount)
values (53, '4YK5KW9RE06', 61);
insert into CATALOG (catserialnumber, typecat, amount)
values (54, '9A80W45QX92', 519);
insert into CATALOG (catserialnumber, typecat, amount)
values (55, '5GR5G66VF52', 339);
insert into CATALOG (catserialnumber, typecat, amount)
values (56, '6W34ER8WV10', 405);
insert into CATALOG (catserialnumber, typecat, amount)
values (57, '4AQ7VU4YW54', 284);
insert into CATALOG (catserialnumber, typecat, amount)
values (58, '6GU4TX4XU48', 977);
insert into CATALOG (catserialnumber, typecat, amount)
values (59, '4DT9M88MY42', 294);
insert into CATALOG (catserialnumber, typecat, amount)
values (60, '6CW9UH0DN36', 601);
insert into CATALOG (catserialnumber, typecat, amount)
values (61, '3TV3Y76JY45', 674);
insert into CATALOG (catserialnumber, typecat, amount)
values (62, '8ET3P85PM71', 232);
insert into CATALOG (catserialnumber, typecat, amount)
values (63, '4YX7EF2MA97', 528);
insert into CATALOG (catserialnumber, typecat, amount)
values (64, '3F33XE9UN03', 887);
insert into CATALOG (catserialnumber, typecat, amount)
values (65, '7RV4MQ9DF75', 122);
insert into CATALOG (catserialnumber, typecat, amount)
values (66, '8K71CH0QM43', 357);
insert into CATALOG (catserialnumber, typecat, amount)
values (67, '9PA7EG1PA45', 163);
insert into CATALOG (catserialnumber, typecat, amount)
values (68, '1CR7AP2YV49', 495);
insert into CATALOG (catserialnumber, typecat, amount)
values (69, '5MU6PG7KD55', 951);
insert into CATALOG (catserialnumber, typecat, amount)
values (70, '5A99UH7PQ74', 751);
insert into CATALOG (catserialnumber, typecat, amount)
values (71, '5H67JT2DY99', 588);
insert into CATALOG (catserialnumber, typecat, amount)
values (72, '5R68CQ5AG26', 481);
insert into CATALOG (catserialnumber, typecat, amount)
values (73, '4WH9VX8AQ93', 547);
insert into CATALOG (catserialnumber, typecat, amount)
values (74, '9M51U02XN25', 954);
insert into CATALOG (catserialnumber, typecat, amount)
values (75, '3MK6QF0DH92', 896);
insert into CATALOG (catserialnumber, typecat, amount)
values (76, '7K98VP6NM90', 569);
insert into CATALOG (catserialnumber, typecat, amount)
values (77, '5AM9AG8TX07', 206);
insert into CATALOG (catserialnumber, typecat, amount)
values (78, '3MV3R28RC14', 119);
insert into CATALOG (catserialnumber, typecat, amount)
values (79, '3QX1WW2RV97', 724);
insert into CATALOG (catserialnumber, typecat, amount)
values (80, '5A45JN0RC21', 731);
insert into CATALOG (catserialnumber, typecat, amount)
values (81, '6KH9CU2PR23', 575);
insert into CATALOG (catserialnumber, typecat, amount)
values (82, '2AG1N41RE07', 509);
insert into CATALOG (catserialnumber, typecat, amount)
values (83, '5AE2HE7MY58', 303);
insert into CATALOG (catserialnumber, typecat, amount)
values (84, '4JE5FV9RJ43', 940);
insert into CATALOG (catserialnumber, typecat, amount)
values (85, '2MJ0X02VP84', 365);
insert into CATALOG (catserialnumber, typecat, amount)
values (86, '6RE7EA2KN29', 82);
insert into CATALOG (catserialnumber, typecat, amount)
values (87, '6DY0E32QW52', 231);
insert into CATALOG (catserialnumber, typecat, amount)
values (88, '3KT4H76JE49', 990);
insert into CATALOG (catserialnumber, typecat, amount)
values (89, '1EK0R57HN85', 765);
insert into CATALOG (catserialnumber, typecat, amount)
values (90, '3X98DH5NY43', 636);
insert into CATALOG (catserialnumber, typecat, amount)
values (91, '7EM5Q16CE17', 112);
insert into CATALOG (catserialnumber, typecat, amount)
values (92, '9VR6EN1QQ97', 573);
insert into CATALOG (catserialnumber, typecat, amount)
values (93, '5P78EW6RQ69', 956);
insert into CATALOG (catserialnumber, typecat, amount)
values (94, '2NP5A62KK44', 957);
insert into CATALOG (catserialnumber, typecat, amount)
values (95, '9C91D26GF82', 111);
insert into CATALOG (catserialnumber, typecat, amount)
values (96, '3Y86A87WW34', 171);
insert into CATALOG (catserialnumber, typecat, amount)
values (97, '4VY2CX2UC39', 753);
insert into CATALOG (catserialnumber, typecat, amount)
values (98, '4W73YH9KM07', 54);
insert into CATALOG (catserialnumber, typecat, amount)
values (99, '6XH2N42AQ61', 55);
insert into CATALOG (catserialnumber, typecat, amount)
values (100, '8E74JC1GY00', 673);
commit;
prompt 100 records committed...
insert into CATALOG (catserialnumber, typecat, amount)
values (101, '5Y68RP4UA74', 536);
insert into CATALOG (catserialnumber, typecat, amount)
values (102, '9F24WX0UM02', 801);
insert into CATALOG (catserialnumber, typecat, amount)
values (103, '6CT5AD2CT56', 810);
insert into CATALOG (catserialnumber, typecat, amount)
values (104, '6WG3YG0CD46', 611);
insert into CATALOG (catserialnumber, typecat, amount)
values (105, '5GW6H58DP89', 773);
insert into CATALOG (catserialnumber, typecat, amount)
values (106, '9YW6AR1HU19', 639);
insert into CATALOG (catserialnumber, typecat, amount)
values (107, '5CR6M92JN41', 382);
insert into CATALOG (catserialnumber, typecat, amount)
values (108, '1UN9GR3MY37', 426);
insert into CATALOG (catserialnumber, typecat, amount)
values (109, '8EA5VH3CP90', 680);
insert into CATALOG (catserialnumber, typecat, amount)
values (110, '7K99R07MY57', 245);
insert into CATALOG (catserialnumber, typecat, amount)
values (111, '7DM5MG9RP16', 370);
insert into CATALOG (catserialnumber, typecat, amount)
values (112, '9VW0PR1AT40', 324);
insert into CATALOG (catserialnumber, typecat, amount)
values (113, '6Y82U35GW06', 757);
insert into CATALOG (catserialnumber, typecat, amount)
values (114, '8T55A41VY30', 425);
insert into CATALOG (catserialnumber, typecat, amount)
values (115, '2QT8EF7NG09', 783);
insert into CATALOG (catserialnumber, typecat, amount)
values (116, '8CF6HH1KE58', 950);
insert into CATALOG (catserialnumber, typecat, amount)
values (117, '2CQ4X97YN68', 845);
insert into CATALOG (catserialnumber, typecat, amount)
values (118, '2CM4N87WD87', 922);
insert into CATALOG (catserialnumber, typecat, amount)
values (119, '8NJ6UX3XF94', 655);
insert into CATALOG (catserialnumber, typecat, amount)
values (120, '4F06MW9NN07', 635);
insert into CATALOG (catserialnumber, typecat, amount)
values (121, '5VC2MN2YU34', 953);
insert into CATALOG (catserialnumber, typecat, amount)
values (122, '3J45HP1ER77', 651);
insert into CATALOG (catserialnumber, typecat, amount)
values (123, '5W14PY2DA94', 183);
insert into CATALOG (catserialnumber, typecat, amount)
values (124, '8P80RU3AG61', 163);
insert into CATALOG (catserialnumber, typecat, amount)
values (125, '6FN4F04QG10', 140);
insert into CATALOG (catserialnumber, typecat, amount)
values (126, '1FD7W19VH89', 939);
insert into CATALOG (catserialnumber, typecat, amount)
values (127, '9QG4H81CF24', 653);
insert into CATALOG (catserialnumber, typecat, amount)
values (128, '7E76UP2DF45', 750);
insert into CATALOG (catserialnumber, typecat, amount)
values (129, '7VN0H63NX62', 272);
insert into CATALOG (catserialnumber, typecat, amount)
values (130, '6PD0Y52UU27', 638);
insert into CATALOG (catserialnumber, typecat, amount)
values (131, '9G37AD6HG58', 171);
insert into CATALOG (catserialnumber, typecat, amount)
values (132, '7C84P83GQ23', 580);
insert into CATALOG (catserialnumber, typecat, amount)
values (133, '5KE8TG3AA35', 506);
insert into CATALOG (catserialnumber, typecat, amount)
values (134, '5EU1JQ8KT71', 38);
insert into CATALOG (catserialnumber, typecat, amount)
values (135, '5PJ1V65XW32', 392);
insert into CATALOG (catserialnumber, typecat, amount)
values (136, '7D57V66VF36', 669);
insert into CATALOG (catserialnumber, typecat, amount)
values (137, '8EW5T23VK22', 781);
insert into CATALOG (catserialnumber, typecat, amount)
values (138, '9G85YR3TE75', 684);
insert into CATALOG (catserialnumber, typecat, amount)
values (139, '7UJ4DP8WC66', 234);
insert into CATALOG (catserialnumber, typecat, amount)
values (140, '2T33Y07PN55', 778);
insert into CATALOG (catserialnumber, typecat, amount)
values (141, '5ET9K12TT03', 83);
insert into CATALOG (catserialnumber, typecat, amount)
values (142, '1HA7DJ0YN27', 501);
insert into CATALOG (catserialnumber, typecat, amount)
values (143, '2T30TC6PH13', 104);
insert into CATALOG (catserialnumber, typecat, amount)
values (144, '6WD0TK3XX26', 295);
insert into CATALOG (catserialnumber, typecat, amount)
values (145, '8D17FC8EU07', 348);
insert into CATALOG (catserialnumber, typecat, amount)
values (146, '8PP8GT7DK62', 687);
insert into CATALOG (catserialnumber, typecat, amount)
values (147, '4CG3G31PE73', 608);
insert into CATALOG (catserialnumber, typecat, amount)
values (148, '5U45P29YT03', 827);
insert into CATALOG (catserialnumber, typecat, amount)
values (149, '6VH4FP8DM16', 789);
insert into CATALOG (catserialnumber, typecat, amount)
values (150, '1MM9CJ2TR68', 426);
insert into CATALOG (catserialnumber, typecat, amount)
values (151, '8UE2U39XH08', 105);
insert into CATALOG (catserialnumber, typecat, amount)
values (152, '4TP9XC3PW76', 3);
insert into CATALOG (catserialnumber, typecat, amount)
values (153, '5A35VA9TH23', 199);
insert into CATALOG (catserialnumber, typecat, amount)
values (154, '5AQ7JN5CK20', 54);
insert into CATALOG (catserialnumber, typecat, amount)
values (155, '8RN1K20DT50', 329);
insert into CATALOG (catserialnumber, typecat, amount)
values (156, '2RE9TQ7RM35', 831);
insert into CATALOG (catserialnumber, typecat, amount)
values (157, '5CR0H85VC58', 664);
insert into CATALOG (catserialnumber, typecat, amount)
values (158, '2ME7NM9XG24', 220);
insert into CATALOG (catserialnumber, typecat, amount)
values (159, '7HN3A52AJ20', 101);
insert into CATALOG (catserialnumber, typecat, amount)
values (160, '2G63CW8KU13', 817);
insert into CATALOG (catserialnumber, typecat, amount)
values (161, '1CU8VC8WX11', 11);
insert into CATALOG (catserialnumber, typecat, amount)
values (162, '3C86T07MC32', 276);
insert into CATALOG (catserialnumber, typecat, amount)
values (163, '9PN6WQ6RU09', 559);
insert into CATALOG (catserialnumber, typecat, amount)
values (164, '2VM4EA0VY19', 964);
insert into CATALOG (catserialnumber, typecat, amount)
values (165, '9HX3TU0QM17', 501);
insert into CATALOG (catserialnumber, typecat, amount)
values (166, '1C41D07QU58', 437);
insert into CATALOG (catserialnumber, typecat, amount)
values (167, '3C42U83FQ76', 834);
insert into CATALOG (catserialnumber, typecat, amount)
values (168, '6CF4QK7KH68', 873);
insert into CATALOG (catserialnumber, typecat, amount)
values (169, '2FX1E29GK85', 286);
insert into CATALOG (catserialnumber, typecat, amount)
values (170, '3YK5YW1AW43', 985);
insert into CATALOG (catserialnumber, typecat, amount)
values (171, '5WU0GV8DV11', 733);
insert into CATALOG (catserialnumber, typecat, amount)
values (172, '6KV9X75EM20', 571);
insert into CATALOG (catserialnumber, typecat, amount)
values (173, '8HQ7JY5FH39', 188);
insert into CATALOG (catserialnumber, typecat, amount)
values (174, '3DQ7KC3CU95', 512);
insert into CATALOG (catserialnumber, typecat, amount)
values (175, '6XM0TQ9KY92', 22);
insert into CATALOG (catserialnumber, typecat, amount)
values (176, '4WD6XU1DD68', 200);
insert into CATALOG (catserialnumber, typecat, amount)
values (177, '4D82G53NQ67', 337);
insert into CATALOG (catserialnumber, typecat, amount)
values (178, '8W36KE6CX83', 58);
insert into CATALOG (catserialnumber, typecat, amount)
values (179, '6U64WJ1UR77', 42);
insert into CATALOG (catserialnumber, typecat, amount)
values (180, '3TY2PG9DY93', 547);
insert into CATALOG (catserialnumber, typecat, amount)
values (181, '2R73RN6KR29', 65);
insert into CATALOG (catserialnumber, typecat, amount)
values (182, '4FH1G07GQ35', 132);
insert into CATALOG (catserialnumber, typecat, amount)
values (183, '2W37YU4CW55', 523);
insert into CATALOG (catserialnumber, typecat, amount)
values (184, '7T37Y34HU89', 355);
insert into CATALOG (catserialnumber, typecat, amount)
values (185, '4GP2JD6UW47', 940);
insert into CATALOG (catserialnumber, typecat, amount)
values (186, '9AR9P74ET73', 6);
insert into CATALOG (catserialnumber, typecat, amount)
values (187, '5HT7QR2UT55', 559);
insert into CATALOG (catserialnumber, typecat, amount)
values (188, '6T50TX8AK21', 86);
insert into CATALOG (catserialnumber, typecat, amount)
values (189, '7PN9CK0UJ33', 412);
insert into CATALOG (catserialnumber, typecat, amount)
values (190, '8NF8P35JN84', 177);
insert into CATALOG (catserialnumber, typecat, amount)
values (191, '4KK5N24RU92', 425);
insert into CATALOG (catserialnumber, typecat, amount)
values (192, '6PM9JJ7PN64', 714);
insert into CATALOG (catserialnumber, typecat, amount)
values (193, '4GX8DC8ER57', 829);
insert into CATALOG (catserialnumber, typecat, amount)
values (194, '9V50JE7GU33', 11);
insert into CATALOG (catserialnumber, typecat, amount)
values (195, '7WN2MK3WH11', 381);
insert into CATALOG (catserialnumber, typecat, amount)
values (196, '5NR4RU1CP89', 710);
insert into CATALOG (catserialnumber, typecat, amount)
values (197, '2RC0F33CH98', 113);
insert into CATALOG (catserialnumber, typecat, amount)
values (198, '9KH3TV4XD33', 25);
insert into CATALOG (catserialnumber, typecat, amount)
values (199, '4H91U08AX61', 600);
insert into CATALOG (catserialnumber, typecat, amount)
values (200, '4A05MA5UH32', 681);
commit;
prompt 200 records committed...
insert into CATALOG (catserialnumber, typecat, amount)
values (201, '7R10P07AM63', 404);
insert into CATALOG (catserialnumber, typecat, amount)
values (202, '9GY1MW9XQ15', 224);
insert into CATALOG (catserialnumber, typecat, amount)
values (203, '9K83FK1MW10', 394);
insert into CATALOG (catserialnumber, typecat, amount)
values (204, '3GF2YH9DT42', 782);
insert into CATALOG (catserialnumber, typecat, amount)
values (205, '6TQ9U67JM89', 41);
insert into CATALOG (catserialnumber, typecat, amount)
values (206, '9Q21KD5KT43', 879);
insert into CATALOG (catserialnumber, typecat, amount)
values (207, '4GQ1UF6WX01', 187);
insert into CATALOG (catserialnumber, typecat, amount)
values (208, '5YD3EP4CN57', 681);
insert into CATALOG (catserialnumber, typecat, amount)
values (209, '9EG3T53VF44', 562);
insert into CATALOG (catserialnumber, typecat, amount)
values (210, '8N88VQ6YD10', 311);
insert into CATALOG (catserialnumber, typecat, amount)
values (211, '9YA8D52TF47', 118);
insert into CATALOG (catserialnumber, typecat, amount)
values (212, '3T48Q31YD82', 734);
insert into CATALOG (catserialnumber, typecat, amount)
values (213, '1UQ6PX7EH81', 5);
insert into CATALOG (catserialnumber, typecat, amount)
values (214, '2CJ4E41FW51', 785);
insert into CATALOG (catserialnumber, typecat, amount)
values (215, '4G58MW7RQ48', 158);
insert into CATALOG (catserialnumber, typecat, amount)
values (216, '2QM7MX5VH09', 319);
insert into CATALOG (catserialnumber, typecat, amount)
values (217, '9U97YV2DD89', 621);
insert into CATALOG (catserialnumber, typecat, amount)
values (218, '5YJ1A67FD19', 892);
insert into CATALOG (catserialnumber, typecat, amount)
values (219, '2YG5U29MA04', 663);
insert into CATALOG (catserialnumber, typecat, amount)
values (220, '4AD6H34TQ56', 3);
insert into CATALOG (catserialnumber, typecat, amount)
values (221, '2UV2G22NP78', 777);
insert into CATALOG (catserialnumber, typecat, amount)
values (222, '8H47GU0HX51', 549);
insert into CATALOG (catserialnumber, typecat, amount)
values (223, '5YT0DK4QD71', 639);
insert into CATALOG (catserialnumber, typecat, amount)
values (224, '4UM1EE2FA62', 490);
insert into CATALOG (catserialnumber, typecat, amount)
values (225, '4JQ7GH8EH50', 75);
insert into CATALOG (catserialnumber, typecat, amount)
values (226, '1PF0RF6EX40', 796);
insert into CATALOG (catserialnumber, typecat, amount)
values (227, '4JD6DJ0FH95', 384);
insert into CATALOG (catserialnumber, typecat, amount)
values (228, '3MV7N13EY09', 153);
insert into CATALOG (catserialnumber, typecat, amount)
values (229, '3HR0WD0CC11', 261);
insert into CATALOG (catserialnumber, typecat, amount)
values (230, '3MQ3FR3FR58', 467);
insert into CATALOG (catserialnumber, typecat, amount)
values (231, '3PF9G25DH09', 340);
insert into CATALOG (catserialnumber, typecat, amount)
values (232, '9MD8M70VT37', 771);
insert into CATALOG (catserialnumber, typecat, amount)
values (233, '4A27K56MR03', 112);
insert into CATALOG (catserialnumber, typecat, amount)
values (234, '8KC6WW4XM68', 836);
insert into CATALOG (catserialnumber, typecat, amount)
values (235, '1UE9KK4PK23', 216);
insert into CATALOG (catserialnumber, typecat, amount)
values (236, '4FC8YV1KU62', 681);
insert into CATALOG (catserialnumber, typecat, amount)
values (237, '5A41KQ6JJ22', 333);
insert into CATALOG (catserialnumber, typecat, amount)
values (238, '8D58FQ4XJ05', 6);
insert into CATALOG (catserialnumber, typecat, amount)
values (239, '1F63FU8TQ88', 841);
insert into CATALOG (catserialnumber, typecat, amount)
values (240, '9PC1YH9GQ92', 111);
insert into CATALOG (catserialnumber, typecat, amount)
values (241, '3A71CW4KQ98', 233);
insert into CATALOG (catserialnumber, typecat, amount)
values (242, '2FE4EV3RG41', 690);
insert into CATALOG (catserialnumber, typecat, amount)
values (243, '6DQ2J89FC98', 862);
insert into CATALOG (catserialnumber, typecat, amount)
values (244, '2XA0MG3VQ38', 907);
insert into CATALOG (catserialnumber, typecat, amount)
values (245, '8GV5P55YQ94', 970);
insert into CATALOG (catserialnumber, typecat, amount)
values (246, '7WF1P11TP64', 941);
insert into CATALOG (catserialnumber, typecat, amount)
values (247, '3C04EU0HY12', 284);
insert into CATALOG (catserialnumber, typecat, amount)
values (248, '4X99UR6CC66', 328);
insert into CATALOG (catserialnumber, typecat, amount)
values (249, '1TJ1XY4WD43', 143);
insert into CATALOG (catserialnumber, typecat, amount)
values (250, '5M16FM4KH62', 494);
insert into CATALOG (catserialnumber, typecat, amount)
values (251, '2WU4JP4YA44', 792);
insert into CATALOG (catserialnumber, typecat, amount)
values (252, '3T95GF3VU58', 759);
insert into CATALOG (catserialnumber, typecat, amount)
values (253, '8H14RA1NR11', 365);
insert into CATALOG (catserialnumber, typecat, amount)
values (254, '7GJ4K03QM27', 43);
insert into CATALOG (catserialnumber, typecat, amount)
values (255, '8A83NC9HG63', 92);
insert into CATALOG (catserialnumber, typecat, amount)
values (256, '2R73CG3XM87', 430);
insert into CATALOG (catserialnumber, typecat, amount)
values (257, '4CC3V69JX59', 232);
insert into CATALOG (catserialnumber, typecat, amount)
values (258, '1V63CT2DC32', 885);
insert into CATALOG (catserialnumber, typecat, amount)
values (259, '9T94YT4QA00', 265);
insert into CATALOG (catserialnumber, typecat, amount)
values (260, '5YM2FF9GX00', 266);
insert into CATALOG (catserialnumber, typecat, amount)
values (261, '1YM5YQ0HJ85', 845);
insert into CATALOG (catserialnumber, typecat, amount)
values (262, '4A48MC6GX95', 132);
insert into CATALOG (catserialnumber, typecat, amount)
values (263, '8PT8N92NC64', 950);
insert into CATALOG (catserialnumber, typecat, amount)
values (264, '6YP9QQ2AC50', 828);
insert into CATALOG (catserialnumber, typecat, amount)
values (265, '1N61XK3XN86', 265);
insert into CATALOG (catserialnumber, typecat, amount)
values (266, '5U66ME1NK48', 454);
insert into CATALOG (catserialnumber, typecat, amount)
values (267, '4GK3FA2CQ81', 735);
insert into CATALOG (catserialnumber, typecat, amount)
values (268, '8U65WW5HT95', 587);
insert into CATALOG (catserialnumber, typecat, amount)
values (269, '9PE8UC3JP11', 122);
insert into CATALOG (catserialnumber, typecat, amount)
values (270, '9MK9XQ1WQ33', 219);
insert into CATALOG (catserialnumber, typecat, amount)
values (271, '9E48NT8HD38', 475);
insert into CATALOG (catserialnumber, typecat, amount)
values (272, '1K02JD7EP03', 906);
insert into CATALOG (catserialnumber, typecat, amount)
values (273, '2NC5YY9PV25', 697);
insert into CATALOG (catserialnumber, typecat, amount)
values (274, '4KW0H56RH03', 537);
insert into CATALOG (catserialnumber, typecat, amount)
values (275, '3CV1NE1GC66', 461);
insert into CATALOG (catserialnumber, typecat, amount)
values (276, '4HT7D40YG15', 360);
insert into CATALOG (catserialnumber, typecat, amount)
values (277, '3R41NN8QW81', 478);
insert into CATALOG (catserialnumber, typecat, amount)
values (278, '9W81GG1NW77', 368);
insert into CATALOG (catserialnumber, typecat, amount)
values (279, '8AT0JH4KM62', 371);
insert into CATALOG (catserialnumber, typecat, amount)
values (280, '6RF2HP9DR68', 680);
insert into CATALOG (catserialnumber, typecat, amount)
values (281, '3WG5JH2MQ53', 358);
insert into CATALOG (catserialnumber, typecat, amount)
values (282, '7P74GK7ED47', 424);
insert into CATALOG (catserialnumber, typecat, amount)
values (283, '3TG0WV7YP73', 968);
insert into CATALOG (catserialnumber, typecat, amount)
values (284, '7CH2R34QH95', 129);
insert into CATALOG (catserialnumber, typecat, amount)
values (285, '7MY8TY9FG24', 433);
insert into CATALOG (catserialnumber, typecat, amount)
values (286, '4JX4A39MP94', 397);
insert into CATALOG (catserialnumber, typecat, amount)
values (287, '7AR2VU3UE31', 643);
insert into CATALOG (catserialnumber, typecat, amount)
values (288, '8JU8FU2HR63', 850);
insert into CATALOG (catserialnumber, typecat, amount)
values (289, '7XA4FJ0FH11', 870);
insert into CATALOG (catserialnumber, typecat, amount)
values (290, '2QE3X01DX48', 362);
insert into CATALOG (catserialnumber, typecat, amount)
values (291, '6WT0JH5JK79', 26);
insert into CATALOG (catserialnumber, typecat, amount)
values (292, '4U47X96HD12', 365);
insert into CATALOG (catserialnumber, typecat, amount)
values (293, '1QA0HW1PQ35', 948);
insert into CATALOG (catserialnumber, typecat, amount)
values (294, '4J94PE1MY58', 965);
insert into CATALOG (catserialnumber, typecat, amount)
values (295, '9A01JT8PA35', 691);
insert into CATALOG (catserialnumber, typecat, amount)
values (296, '1U60NA1UG83', 453);
insert into CATALOG (catserialnumber, typecat, amount)
values (297, '7PW8RX2CK15', 589);
insert into CATALOG (catserialnumber, typecat, amount)
values (298, '6T87YK3JM71', 854);
insert into CATALOG (catserialnumber, typecat, amount)
values (299, '2T91DP1MA39', 219);
insert into CATALOG (catserialnumber, typecat, amount)
values (300, '6NV3U30MQ50', 196);
commit;
prompt 300 records committed...
insert into CATALOG (catserialnumber, typecat, amount)
values (301, '1ND0R19RC20', 581);
insert into CATALOG (catserialnumber, typecat, amount)
values (302, '7D92G21JR95', 980);
insert into CATALOG (catserialnumber, typecat, amount)
values (303, '7U87KR5TK02', 641);
insert into CATALOG (catserialnumber, typecat, amount)
values (304, '7XH6CV5QN56', 259);
insert into CATALOG (catserialnumber, typecat, amount)
values (305, '8A27YN3GD22', 970);
insert into CATALOG (catserialnumber, typecat, amount)
values (306, '4AX4MC5GV85', 842);
insert into CATALOG (catserialnumber, typecat, amount)
values (307, '2WK0H24KD95', 771);
insert into CATALOG (catserialnumber, typecat, amount)
values (308, '5U45NA2QR42', 219);
insert into CATALOG (catserialnumber, typecat, amount)
values (309, '6WJ2PU4JH47', 643);
insert into CATALOG (catserialnumber, typecat, amount)
values (310, '9V88G30QA97', 865);
insert into CATALOG (catserialnumber, typecat, amount)
values (311, '1PT5AY0RX08', 74);
insert into CATALOG (catserialnumber, typecat, amount)
values (312, '4DC6UG0HE98', 879);
insert into CATALOG (catserialnumber, typecat, amount)
values (313, '5TG1DV4YR47', 176);
insert into CATALOG (catserialnumber, typecat, amount)
values (314, '1PF4WP4WY78', 884);
insert into CATALOG (catserialnumber, typecat, amount)
values (315, '4VH4CU8EG13', 541);
insert into CATALOG (catserialnumber, typecat, amount)
values (316, '1MD8G86TP29', 662);
insert into CATALOG (catserialnumber, typecat, amount)
values (317, '9CU4R23VE82', 247);
insert into CATALOG (catserialnumber, typecat, amount)
values (318, '1CR8AU6QU45', 603);
insert into CATALOG (catserialnumber, typecat, amount)
values (319, '1H88WK6YP68', 279);
insert into CATALOG (catserialnumber, typecat, amount)
values (320, '2VY5G84KQ57', 102);
insert into CATALOG (catserialnumber, typecat, amount)
values (321, '5MU8X90XV20', 869);
insert into CATALOG (catserialnumber, typecat, amount)
values (322, '7MR1EM4AC99', 330);
insert into CATALOG (catserialnumber, typecat, amount)
values (323, '3UX4J06VV70', 922);
insert into CATALOG (catserialnumber, typecat, amount)
values (324, '7NT7Y64FA50', 958);
insert into CATALOG (catserialnumber, typecat, amount)
values (325, '7NV9RX6HE17', 604);
insert into CATALOG (catserialnumber, typecat, amount)
values (326, '8EQ7TD6PM83', 451);
insert into CATALOG (catserialnumber, typecat, amount)
values (327, '6Q51GR0FM19', 623);
insert into CATALOG (catserialnumber, typecat, amount)
values (328, '2U83D99CH31', 986);
insert into CATALOG (catserialnumber, typecat, amount)
values (329, '5R50EH5GF30', 474);
insert into CATALOG (catserialnumber, typecat, amount)
values (330, '1UE6UT5ME51', 483);
insert into CATALOG (catserialnumber, typecat, amount)
values (331, '6TM2H16UR69', 207);
insert into CATALOG (catserialnumber, typecat, amount)
values (332, '8HJ5UK4XX59', 596);
insert into CATALOG (catserialnumber, typecat, amount)
values (333, '9YD2Q87VC50', 736);
insert into CATALOG (catserialnumber, typecat, amount)
values (334, '6TA0D80UF37', 723);
insert into CATALOG (catserialnumber, typecat, amount)
values (335, '4JK4DH9FW37', 340);
insert into CATALOG (catserialnumber, typecat, amount)
values (336, '3R53V09EE06', 953);
insert into CATALOG (catserialnumber, typecat, amount)
values (337, '4NQ6VC1TK79', 47);
insert into CATALOG (catserialnumber, typecat, amount)
values (338, '8A53DE7HT43', 156);
insert into CATALOG (catserialnumber, typecat, amount)
values (339, '7T91U57QT53', 166);
insert into CATALOG (catserialnumber, typecat, amount)
values (340, '8TU3G95NV21', 20);
insert into CATALOG (catserialnumber, typecat, amount)
values (341, '8EX7U54KH00', 739);
insert into CATALOG (catserialnumber, typecat, amount)
values (342, '9AT9YX9JC92', 292);
insert into CATALOG (catserialnumber, typecat, amount)
values (343, '1D95E03NT53', 876);
insert into CATALOG (catserialnumber, typecat, amount)
values (344, '5V76RX7MU13', 440);
insert into CATALOG (catserialnumber, typecat, amount)
values (345, '7Q10MD0CU54', 313);
insert into CATALOG (catserialnumber, typecat, amount)
values (346, '9XD1RM7EC06', 331);
insert into CATALOG (catserialnumber, typecat, amount)
values (347, '2MP9Q63YT99', 13);
insert into CATALOG (catserialnumber, typecat, amount)
values (348, '7R58F20FA66', 370);
insert into CATALOG (catserialnumber, typecat, amount)
values (349, '5NX0P91MR85', 496);
insert into CATALOG (catserialnumber, typecat, amount)
values (350, '3VK1FM9CC57', 719);
insert into CATALOG (catserialnumber, typecat, amount)
values (351, '4GE3DC4XV10', 863);
insert into CATALOG (catserialnumber, typecat, amount)
values (352, '3D46GX1RU27', 175);
insert into CATALOG (catserialnumber, typecat, amount)
values (353, '8NM1HG2TG72', 601);
insert into CATALOG (catserialnumber, typecat, amount)
values (354, '8YE6GK7QY58', 695);
insert into CATALOG (catserialnumber, typecat, amount)
values (355, '4F21XM5KV40', 35);
insert into CATALOG (catserialnumber, typecat, amount)
values (356, '5UY3VQ1AR20', 707);
insert into CATALOG (catserialnumber, typecat, amount)
values (357, '3DY7D76QC04', 741);
insert into CATALOG (catserialnumber, typecat, amount)
values (358, '8FC9GE5UG67', 976);
insert into CATALOG (catserialnumber, typecat, amount)
values (359, '5VH0A42DH71', 590);
insert into CATALOG (catserialnumber, typecat, amount)
values (360, '3PC6PR4AA56', 981);
insert into CATALOG (catserialnumber, typecat, amount)
values (361, '3W45R53GM03', 308);
insert into CATALOG (catserialnumber, typecat, amount)
values (362, '6HK9XE2QW26', 497);
insert into CATALOG (catserialnumber, typecat, amount)
values (363, '3JG4GP2FG98', 17);
insert into CATALOG (catserialnumber, typecat, amount)
values (364, '1X61VA5TQ37', 239);
insert into CATALOG (catserialnumber, typecat, amount)
values (365, '3KE7HQ0AX78', 885);
insert into CATALOG (catserialnumber, typecat, amount)
values (366, '6EY0XY9GC06', 820);
insert into CATALOG (catserialnumber, typecat, amount)
values (367, '8TW6Y32HW57', 779);
insert into CATALOG (catserialnumber, typecat, amount)
values (368, '9G30UR9UF15', 661);
insert into CATALOG (catserialnumber, typecat, amount)
values (369, '3W46P05GY65', 152);
insert into CATALOG (catserialnumber, typecat, amount)
values (370, '2E90JQ5RP96', 474);
insert into CATALOG (catserialnumber, typecat, amount)
values (371, '7FC0NJ8XJ44', 127);
insert into CATALOG (catserialnumber, typecat, amount)
values (372, '5H02M33DV35', 706);
insert into CATALOG (catserialnumber, typecat, amount)
values (373, '8E54FC1YX27', 151);
insert into CATALOG (catserialnumber, typecat, amount)
values (374, '9W93G57GC91', 614);
insert into CATALOG (catserialnumber, typecat, amount)
values (375, '5QJ5EG6TY99', 984);
insert into CATALOG (catserialnumber, typecat, amount)
values (376, '2M73GW1RD37', 246);
insert into CATALOG (catserialnumber, typecat, amount)
values (377, '2QA9DJ2HD26', 526);
insert into CATALOG (catserialnumber, typecat, amount)
values (378, '1GA6EU2UV55', 800);
insert into CATALOG (catserialnumber, typecat, amount)
values (379, '9GQ3QC5UT06', 599);
insert into CATALOG (catserialnumber, typecat, amount)
values (380, '6UD6EK2CA32', 81);
insert into CATALOG (catserialnumber, typecat, amount)
values (381, '3JC9DG3CG20', 729);
insert into CATALOG (catserialnumber, typecat, amount)
values (382, '4QN4HQ8MK22', 140);
insert into CATALOG (catserialnumber, typecat, amount)
values (383, '9K67UG7AP93', 415);
insert into CATALOG (catserialnumber, typecat, amount)
values (384, '3P75YV2AE89', 464);
insert into CATALOG (catserialnumber, typecat, amount)
values (385, '6M46X13RA91', 648);
insert into CATALOG (catserialnumber, typecat, amount)
values (386, '1FH7VX9DJ27', 543);
insert into CATALOG (catserialnumber, typecat, amount)
values (387, '3Q24TW4GC25', 611);
insert into CATALOG (catserialnumber, typecat, amount)
values (388, '1EA6XQ4MT67', 9);
insert into CATALOG (catserialnumber, typecat, amount)
values (389, '2CQ2D16GK18', 998);
insert into CATALOG (catserialnumber, typecat, amount)
values (390, '5GC9FG4YP05', 832);
insert into CATALOG (catserialnumber, typecat, amount)
values (391, '3D19W25YJ53', 496);
insert into CATALOG (catserialnumber, typecat, amount)
values (392, '9DK0R11MX60', 565);
insert into CATALOG (catserialnumber, typecat, amount)
values (393, '5NN4EY8KD26', 201);
insert into CATALOG (catserialnumber, typecat, amount)
values (394, '9JV2KD9VA70', 272);
insert into CATALOG (catserialnumber, typecat, amount)
values (395, '1PG1TQ0MJ47', 877);
insert into CATALOG (catserialnumber, typecat, amount)
values (396, '5VF1YE1HV96', 171);
insert into CATALOG (catserialnumber, typecat, amount)
values (397, '6VV1GF4GW30', 131);
insert into CATALOG (catserialnumber, typecat, amount)
values (398, '2FV8W36RW94', 890);
insert into CATALOG (catserialnumber, typecat, amount)
values (399, '7GE6XM8TG21', 595);
insert into CATALOG (catserialnumber, typecat, amount)
values (400, '5XC5UA7KA87', 112);
commit;
prompt 400 records committed...
insert into CATALOG (catserialnumber, typecat, amount)
values (401, '6A65XT9WC50', 698);
insert into CATALOG (catserialnumber, typecat, amount)
values (402, '8JA1GN0XR37', 242);
insert into CATALOG (catserialnumber, typecat, amount)
values (403, '8H46VF9CQ48', 941);
insert into CATALOG (catserialnumber, typecat, amount)
values (404, '3C44F66JR42', 659);
insert into CATALOG (catserialnumber, typecat, amount)
values (405, '5E93E67NM22', 885);
insert into CATALOG (catserialnumber, typecat, amount)
values (406, '9HW0HQ0AY34', 799);
insert into CATALOG (catserialnumber, typecat, amount)
values (407, '1D01RQ1NA54', 708);
insert into CATALOG (catserialnumber, typecat, amount)
values (408, '9FG2WJ2JF28', 513);
insert into CATALOG (catserialnumber, typecat, amount)
values (409, '2RH4QF7YE42', 264);
insert into CATALOG (catserialnumber, typecat, amount)
values (410, '2J17DF4RP37', 467);
insert into CATALOG (catserialnumber, typecat, amount)
values (411, '9WV7JK2QY44', 519);
insert into CATALOG (catserialnumber, typecat, amount)
values (412, '4UC1AR7WT46', 740);
insert into CATALOG (catserialnumber, typecat, amount)
values (413, '2GX6JK0NT09', 650);
insert into CATALOG (catserialnumber, typecat, amount)
values (414, '2K09EE4TV93', 6);
insert into CATALOG (catserialnumber, typecat, amount)
values (415, '4TH1NW1WC32', 628);
insert into CATALOG (catserialnumber, typecat, amount)
values (416, '9J72DN6VX60', 387);
insert into CATALOG (catserialnumber, typecat, amount)
values (417, '2PG5NM1YJ89', 69);
insert into CATALOG (catserialnumber, typecat, amount)
values (418, '3M64JU4PC25', 247);
insert into CATALOG (catserialnumber, typecat, amount)
values (419, '4G30KU9FU55', 629);
insert into CATALOG (catserialnumber, typecat, amount)
values (420, '7W77E26FW77', 426);
insert into CATALOG (catserialnumber, typecat, amount)
values (421, '3R64FY0PW50', 774);
insert into CATALOG (catserialnumber, typecat, amount)
values (422, '1JM2HA0CQ46', 97);
insert into CATALOG (catserialnumber, typecat, amount)
values (423, '4UP7RD2HA05', 510);
insert into CATALOG (catserialnumber, typecat, amount)
values (424, '2WY8VU2DK93', 495);
insert into CATALOG (catserialnumber, typecat, amount)
values (425, '1UA9GC5CY76', 804);
insert into CATALOG (catserialnumber, typecat, amount)
values (426, '5TA6WK4MQ85', 763);
insert into CATALOG (catserialnumber, typecat, amount)
values (427, '3JN9JK1DN93', 320);
insert into CATALOG (catserialnumber, typecat, amount)
values (428, '8JW6CF7JY99', 221);
insert into CATALOG (catserialnumber, typecat, amount)
values (429, '5X75JN1EY41', 966);
insert into CATALOG (catserialnumber, typecat, amount)
values (430, '5ME0C70VW75', 674);
insert into CATALOG (catserialnumber, typecat, amount)
values (431, '5D78H66CF61', 859);
insert into CATALOG (catserialnumber, typecat, amount)
values (432, '5Y36C59VJ38', 354);
insert into CATALOG (catserialnumber, typecat, amount)
values (433, '4G67AY8KP41', 903);
insert into CATALOG (catserialnumber, typecat, amount)
values (434, '6NY5XC7HC42', 259);
insert into CATALOG (catserialnumber, typecat, amount)
values (435, '3U26Q14WX47', 132);
insert into CATALOG (catserialnumber, typecat, amount)
values (436, '8QH1E39AW53', 950);
insert into CATALOG (catserialnumber, typecat, amount)
values (437, '7UK7VM0DJ47', 796);
insert into CATALOG (catserialnumber, typecat, amount)
values (438, '8XX6WE7UU79', 926);
insert into CATALOG (catserialnumber, typecat, amount)
values (439, '3UP9J54DM61', 269);
insert into CATALOG (catserialnumber, typecat, amount)
values (440, '7XV0W16GT20', 0);
insert into CATALOG (catserialnumber, typecat, amount)
values (441, '6Y09YG4JY27', 371);
insert into CATALOG (catserialnumber, typecat, amount)
values (442, '2VW2D56AQ65', 710);
insert into CATALOG (catserialnumber, typecat, amount)
values (443, '5UW4P41RU46', 719);
insert into CATALOG (catserialnumber, typecat, amount)
values (444, '1R18R85JH08', 505);
insert into CATALOG (catserialnumber, typecat, amount)
values (445, '3JF6AE9KR13', 397);
insert into CATALOG (catserialnumber, typecat, amount)
values (446, '6DA7M66HT63', 259);
insert into CATALOG (catserialnumber, typecat, amount)
values (447, '5K73Y95VQ10', 202);
insert into CATALOG (catserialnumber, typecat, amount)
values (448, '6QE1DE7DK41', 130);
insert into CATALOG (catserialnumber, typecat, amount)
values (449, '1X79M63YH01', 33);
insert into CATALOG (catserialnumber, typecat, amount)
values (450, '3FY5CA8CE02', 202);
insert into CATALOG (catserialnumber, typecat, amount)
values (451, '7XC7JW4VC75', 745);
insert into CATALOG (catserialnumber, typecat, amount)
values (452, '8VC6MY7JV84', 518);
insert into CATALOG (catserialnumber, typecat, amount)
values (453, '2KF2RA4MP14', 496);
insert into CATALOG (catserialnumber, typecat, amount)
values (454, '2UH6R99DJ05', 180);
insert into CATALOG (catserialnumber, typecat, amount)
values (455, '4YF7W35MK97', 752);
insert into CATALOG (catserialnumber, typecat, amount)
values (456, '4U56HK9GE70', 961);
insert into CATALOG (catserialnumber, typecat, amount)
values (457, '3N04V76TH58', 947);
insert into CATALOG (catserialnumber, typecat, amount)
values (458, '8DG2QV6AJ99', 827);
insert into CATALOG (catserialnumber, typecat, amount)
values (459, '7GT7QK2PU71', 729);
insert into CATALOG (catserialnumber, typecat, amount)
values (460, '3M48D74RF72', 96);
insert into CATALOG (catserialnumber, typecat, amount)
values (461, '3N28MX7MJ33', 101);
insert into CATALOG (catserialnumber, typecat, amount)
values (462, '9H91RW6QG65', 194);
insert into CATALOG (catserialnumber, typecat, amount)
values (463, '6CY0PF3YD73', 537);
insert into CATALOG (catserialnumber, typecat, amount)
values (464, '5D49U31TJ09', 912);
insert into CATALOG (catserialnumber, typecat, amount)
values (465, '6TF7DJ0JU51', 783);
insert into CATALOG (catserialnumber, typecat, amount)
values (466, '9UG6P67TN57', 618);
insert into CATALOG (catserialnumber, typecat, amount)
values (467, '7CT3XJ3WK67', 987);
insert into CATALOG (catserialnumber, typecat, amount)
values (468, '4MJ3A73CR45', 463);
insert into CATALOG (catserialnumber, typecat, amount)
values (469, '9F90E88QR38', 850);
insert into CATALOG (catserialnumber, typecat, amount)
values (470, '7J85P64JF98', 911);
insert into CATALOG (catserialnumber, typecat, amount)
values (471, '4FG7TC4UG21', 794);
insert into CATALOG (catserialnumber, typecat, amount)
values (472, '8CW2TV2FR50', 151);
insert into CATALOG (catserialnumber, typecat, amount)
values (473, '8T82AA7QY89', 576);
insert into CATALOG (catserialnumber, typecat, amount)
values (474, '7XE7TM8JV11', 907);
insert into CATALOG (catserialnumber, typecat, amount)
values (475, '9TJ6TX9NT96', 106);
insert into CATALOG (catserialnumber, typecat, amount)
values (476, '2A07AR8FU38', 716);
insert into CATALOG (catserialnumber, typecat, amount)
values (477, '2DU8GE3HE48', 917);
insert into CATALOG (catserialnumber, typecat, amount)
values (478, '1J08VF7MD60', 784);
insert into CATALOG (catserialnumber, typecat, amount)
values (479, '6J21KD2AU55', 520);
insert into CATALOG (catserialnumber, typecat, amount)
values (480, '2G33KP5UN86', 391);
insert into CATALOG (catserialnumber, typecat, amount)
values (481, '5TD3JW3DF71', 983);
insert into CATALOG (catserialnumber, typecat, amount)
values (482, '2N29JP7HF89', 739);
insert into CATALOG (catserialnumber, typecat, amount)
values (483, '7W42AX0QF21', 636);
insert into CATALOG (catserialnumber, typecat, amount)
values (484, '4TN4JQ1CJ28', 174);
insert into CATALOG (catserialnumber, typecat, amount)
values (485, '9V44FF5NE81', 123);
insert into CATALOG (catserialnumber, typecat, amount)
values (486, '7GF6C69QE89', 543);
insert into CATALOG (catserialnumber, typecat, amount)
values (487, '6X06XJ6EG51', 987);
insert into CATALOG (catserialnumber, typecat, amount)
values (488, '3PC4KM9PM29', 298);
insert into CATALOG (catserialnumber, typecat, amount)
values (489, '2DV1CQ0XQ21', 119);
insert into CATALOG (catserialnumber, typecat, amount)
values (490, '3T62NE4GY78', 8);
insert into CATALOG (catserialnumber, typecat, amount)
values (491, '3MW7PD0NP51', 280);
insert into CATALOG (catserialnumber, typecat, amount)
values (492, '1T39MJ9YK05', 469);
insert into CATALOG (catserialnumber, typecat, amount)
values (493, '7KM2FK8TA93', 360);
insert into CATALOG (catserialnumber, typecat, amount)
values (494, '3JR2E96RD95', 336);
insert into CATALOG (catserialnumber, typecat, amount)
values (495, '8X99AU3XF13', 243);
insert into CATALOG (catserialnumber, typecat, amount)
values (496, '1QD4W74KH73', 700);
insert into CATALOG (catserialnumber, typecat, amount)
values (497, '9XQ7ET2VP36', 401);
insert into CATALOG (catserialnumber, typecat, amount)
values (498, '5T65QM6JM10', 199);
insert into CATALOG (catserialnumber, typecat, amount)
values (499, '9YF4Q13GJ57', 849);
insert into CATALOG (catserialnumber, typecat, amount)
values (500, '8MK7A92NH33', 32);
commit;
prompt 500 records committed...
insert into CATALOG (catserialnumber, typecat, amount)
values (501, '6U28WK7PC08', 345);
insert into CATALOG (catserialnumber, typecat, amount)
values (502, '1M02A46HM73', 756);
insert into CATALOG (catserialnumber, typecat, amount)
values (503, '9MW2WE3JG70', 713);
insert into CATALOG (catserialnumber, typecat, amount)
values (504, '3JA8JG4XW51', 543);
insert into CATALOG (catserialnumber, typecat, amount)
values (505, '5A24JJ2CX68', 400);
insert into CATALOG (catserialnumber, typecat, amount)
values (506, '6B37XK9WP66', 9695);
insert into CATALOG (catserialnumber, typecat, amount)
values (507, '6C37XK9WP66', 1344);
insert into CATALOG (catserialnumber, typecat, amount)
values (508, '6D37XK9WP66', 1365);
insert into CATALOG (catserialnumber, typecat, amount)
values (509, '6E37XK9WP66', 1365);
insert into CATALOG (catserialnumber, typecat, amount)
values (510, '6F37XK9WP66', 146);
insert into CATALOG (catserialnumber, typecat, amount)
values (511, '6G37XK9WP66', 1365);
insert into CATALOG (catserialnumber, typecat, amount)
values (512, '6H37XK9WP66', 1365);
insert into CATALOG (catserialnumber, typecat, amount)
values (513, '6I37XK9WP66', 1455);
insert into CATALOG (catserialnumber, typecat, amount)
values (514, '6J37XK9WP66', 5455);
insert into CATALOG (catserialnumber, typecat, amount)
values (515, '6K37XK9WP66', 1455);
insert into CATALOG (catserialnumber, typecat, amount)
values (516, '6M37XK9WP66', 2345);
insert into CATALOG (catserialnumber, typecat, amount)
values (517, '8I37XK9WP66', 1455);
commit;
prompt 517 records loaded
prompt Loading CLIENTS...
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (1, 'Sandra Keeslar', 'assistant', '0574900166', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (2, 'Cloris Arthur', 'nurse', '0576169641', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (3, 'Daryl Arden', 'nurse', '0559129938', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (4, 'Reese MacNeil', 'nurse', '0523313809', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (5, 'Maureen Chamber', 'doctor', '0592926210', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (6, 'Lois Reilly', 'assistant', '0588302424', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (7, 'Lin McBride', 'nurse', '0587502226', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (8, 'Clea Vinton', 'doctor', '0583745105', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (9, 'Henry Weaving', 'assistant', '0560975234', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (10, 'Etta Chappelle', 'assistant', '0526358238', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (11, 'Hookah Carlisle', 'nurse', '0591267370', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (12, 'Franco Douglas', 'assistant', '0547484975', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (13, 'Jack Cumming', 'doctor', '0530533206', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (14, 'Nicolas McDiarm', 'doctor', '0549074335', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (15, 'Rory Peniston', 'nurse', '0562951971', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (16, 'Clay Bracco', 'nurse', '0520240582', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (17, 'Amanda Branch', 'doctor', '0588474112', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (18, 'Lili Myers', 'nurse', '0536375447', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (19, 'Leslie D''Onofri', 'assistant', '0595660696', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (20, 'Ernie Crow', 'assistant', '0501072061', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (21, 'Gilberto Jeffre', 'doctor', '0594761021', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (22, 'Solomon Bridges', 'nurse', '0571595480', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (23, 'Merrill Rossell', 'assistant', '0570739207', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (24, 'Murray McLachla', 'assistant', '0560535409', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (25, 'Ryan Heatherly', 'assistant', '0569524700', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (26, 'Mary Beth Gersh', 'nurse', '0584278177', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (27, 'Mykelti Spiner', 'nurse', '0592214012', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (28, 'Busta Murdock', 'nurse', '0508616854', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (29, 'Brothers Stewar', 'doctor', '0588370009', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (30, 'Jonathan Brooks', 'doctor', '0564974528', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (31, 'Arturo Aniston', 'nurse', '0597372364', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (32, 'Melba Thurman', 'nurse', '0598230426', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (33, 'Stellan McAnall', 'nurse', '0596931070', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (34, 'Judd Tomlin', 'nurse', '0578594479', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (35, 'Rob Hall', 'doctor', '0534500519', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (36, 'Toni Ticotin', 'doctor', '0502437485', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (37, 'Molly Winter', 'assistant', '0580881837', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (38, 'Malcolm Twilley', 'doctor', '0573958379', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (39, 'Bobbi Gatlin', 'nurse', '0581753498', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (40, 'Walter Menikett', 'nurse', '0577286619', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (41, 'Lisa Cervine', 'nurse', '0504564496', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (42, 'Laura Satriani', 'nurse', '0520398436', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (43, 'Juan Gilley', 'assistant', '0583748052', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (44, 'Armin Hughes', 'doctor', '0513126607', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (45, 'Bette Moraz', 'nurse', '0515966812', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (46, 'Annette Tankard', 'doctor', '0587751771', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (47, 'Kitty Witt', 'doctor', '0538234520', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (48, 'Cevin Evett', 'nurse', '0510716266', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (49, 'Walter Statham', 'doctor', '0502469008', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (50, 'Trick Spacey', 'nurse', '0558233899', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (51, 'Elizabeth Tobol', 'nurse', '0596506807', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (52, 'Carrie Puckett', 'nurse', '0517780262', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (53, 'Nigel Malone', 'doctor', '0584747190', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (54, 'Ike Kirshner', 'assistant', '0583809734', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (55, 'Nick Hedaya', 'assistant', '0588473623', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (56, 'Jonny Elizabeth', 'assistant', '0559854796', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (57, 'Meg Birch', 'assistant', '0597810302', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (58, 'Charlie Holmes', 'nurse', '0539219026', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (59, 'Franz Marin', 'assistant', '0554467550', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (60, 'Crispin Lavigne', 'assistant', '0530890659', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (61, 'Dean Thornton', 'doctor', '0542587364', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (62, 'Nicholas Waits', 'assistant', '0589014201', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (63, 'Emily Henstridg', 'assistant', '0586915331', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (64, 'Harrison Lindle', 'assistant', '0502366391', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (65, 'Alex Peet', 'assistant', '0502372812', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (66, 'Tal Berkley', 'doctor', '0535655277', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (67, 'Sydney Ferrell', 'nurse', '0545570437', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (68, 'Julianna Sample', 'nurse', '0588206326', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (69, 'Wallace Gleeson', 'nurse', '0575292400', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (70, 'Courtney Martin', 'doctor', '0525955452', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (71, 'Dean Peniston', 'assistant', '0571592180', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (72, 'Fionnula Lynne', 'nurse', '0586022735', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (73, 'Joseph Cooper', 'doctor', '0564403863', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (74, 'Jude Sherman', 'doctor', '0565814752', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (75, 'Cyndi Watson', 'nurse', '0543435862', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (76, 'Brian Conners', 'assistant', '0523972655', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (77, 'April DiFranco', 'doctor', '0537514538', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (78, 'Larnelle Jeffre', 'nurse', '0538254180', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (79, 'Nanci Palin', 'assistant', '0552721614', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (80, 'Lea Hewitt', 'doctor', '0590398590', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (81, 'Richard Crystal', 'doctor', '0554146549', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (82, 'Elijah Beck', 'doctor', '0523257105', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (83, 'Yolanda Woodard', 'assistant', '0536418917', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (84, 'Jack Berkeley', 'nurse', '0500813772', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (85, 'Roberta Hughes', 'doctor', '0520476276', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (86, 'Embeth Snow', 'doctor', '0528675002', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (87, 'Bret Mazzello', 'nurse', '0532843741', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (88, 'Stellan Ruffalo', 'assistant', '0506327341', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (89, 'Ernest Church', 'nurse', '0516866012', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (90, 'Maria Rawls', 'nurse', '0500895492', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (91, 'Jose Kleinenber', 'assistant', '0502134475', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (92, 'Hector Arjona', 'doctor', '0583186226', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (93, 'Andre Todd', 'doctor', '0548179511', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (94, 'Loretta Burns', 'doctor', '0588180517', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (95, 'Dennis Sylvian', 'doctor', '0552922912', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (96, 'Tramaine Boothe', 'nurse', '0568644768', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (97, 'Juan LaSalle', 'assistant', '0536342426', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (98, 'Alice Lunch', 'doctor', '0509548178', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (99, 'Bruce Krieger', 'doctor', '0576542034', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (100, 'Marie Colman', 'doctor', '0542348123', null);
commit;
prompt 100 records committed...
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (101, 'Gordie Francis', 'nurse', '0599695867', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (102, 'Marc Burke', 'assistant', '0571071890', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (103, 'Rik Mazzello', 'doctor', '0584296641', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (104, 'Shelby Winwood', 'nurse', '0549503791', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (105, 'Diamond Epps', 'doctor', '0516356712', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (106, 'Kieran Llewelyn', 'nurse', '0548767116', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (107, 'Denis Karyo', 'assistant', '0596589280', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (108, 'Sally Lonsdale', 'assistant', '0555045795', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (109, 'Nicole Kilmer', 'assistant', '0509060505', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (110, 'Mint Coyote', 'doctor', '0560413195', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (111, 'Rhett Cobbs', 'nurse', '0529515821', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (112, 'Gary Burke', 'doctor', '0578586758', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (113, 'Colm Puckett', 'doctor', '0501154205', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (114, 'Rowan Weaver', 'assistant', '0572206400', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (115, 'Benjamin Lennox', 'doctor', '0558741111', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (116, 'Carole Wood', 'nurse', '0503139391', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (117, 'Sally Bacharach', 'doctor', '0540953727', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (118, 'Linda Cockburn', 'doctor', '0581578547', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (119, 'Roberta Herndon', 'doctor', '0592550609', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (120, 'Kieran Statham', 'nurse', '0568473385', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (121, 'Juliette Niven', 'doctor', '0526215784', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (122, 'Julianne Beatty', 'doctor', '0561400455', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (123, 'Willie Morrison', 'nurse', '0535514969', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (124, 'Millie Makowicz', 'doctor', '0506947097', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (125, 'Alan Heatherly', 'doctor', '0597291445', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (126, 'Kid Moreno', 'doctor', '0503145319', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (127, 'Julie Utada', 'assistant', '0527055257', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (128, 'Julia James', 'doctor', '0515980875', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (129, 'Joaquin Clark', 'doctor', '0584969566', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (130, 'Emily Santana', 'nurse', '0596393696', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (131, 'Oliver Hagerty', 'doctor', '0569098182', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (132, 'Petula Kleinenb', 'nurse', '0505510400', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (133, 'Tony Khan', 'nurse', '0555753592', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (134, 'Omar Rippy', 'nurse', '0563245017', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (135, 'Eddie Molina', 'assistant', '0539844483', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (136, 'Allan Vicious', 'nurse', '0572900219', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (137, 'Yolanda Emmeric', 'doctor', '0597314790', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (138, 'Jack Tobolowsky', 'doctor', '0567239345', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (139, 'Malcolm Nichols', 'assistant', '0509820163', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (140, 'Nikka Elliott', 'doctor', '0530506052', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (141, 'Wayman Carnes', 'doctor', '0516248575', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (142, 'Elizabeth Press', 'nurse', '0599581916', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (143, 'Illeana Astin', 'nurse', '0564487389', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (144, 'Hookah Sampson', 'doctor', '0549369399', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (145, 'Pierce Joli', 'nurse', '0517646224', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (146, 'Mitchell Maxwel', 'doctor', '0518282453', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (147, 'Rose Sobieski', 'doctor', '0575175403', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (148, 'Charles Tambor', 'nurse', '0515593299', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (149, 'Maxine Pride', 'doctor', '0512206592', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (150, 'Bebe DiCaprio', 'doctor', '0562289402', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (151, 'Vondie Scaggs', 'doctor', '0596299876', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (152, 'Liv Clarkson', 'assistant', '0537745093', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (153, 'Junior Marsden', 'assistant', '0513877723', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (154, 'Miko Macy', 'nurse', '0579909609', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (155, 'Jessica Caldwel', 'doctor', '0502032436', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (156, 'Orlando Newman', 'nurse', '0534325794', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (157, 'Gilbert Cole', 'nurse', '0552852414', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (158, 'Ritchie Murray', 'doctor', '0572384919', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (159, 'Juan Drive', 'assistant', '0596764499', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (160, 'Buddy Warren', 'assistant', '0531203703', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (161, 'Sal MacPherson', 'doctor', '0522823991', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (162, 'Angela Leguizam', 'assistant', '0588499069', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (163, 'Elvis Ojeda', 'doctor', '0526416270', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (164, 'Kurt Archer', 'nurse', '0552869013', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (165, 'Marina Madonna', 'nurse', '0566624629', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (166, 'Angela Bonham', 'assistant', '0567296888', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (167, 'Jason Tsettos', 'nurse', '0554251474', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (168, 'Jesus Schock', 'assistant', '0515782200', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (169, 'Elvis Malkovich', 'assistant', '0580009938', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (170, 'Sinead Ratzenbe', 'doctor', '0564056546', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (171, 'Lesley Brock', 'assistant', '0593539511', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (172, 'Warren Culkin', 'doctor', '0575401960', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (173, 'Judi Gray', 'doctor', '0593189874', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (174, 'Forest Crimson', 'assistant', '0542103585', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (175, 'Matt Crimson', 'assistant', '0544857540', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (176, 'Tia Sedaka', 'nurse', '0582909432', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (177, 'Kurt Paquin', 'nurse', '0587299813', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (178, 'Ashley Checker', 'assistant', '0575540675', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (179, 'Jennifer Thurma', 'doctor', '0571889425', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (180, 'Fiona Loggins', 'assistant', '0507006223', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (181, 'Don Damon', 'nurse', '0517184883', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (182, 'First Willis', 'doctor', '0543743313', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (183, 'Goran Buckingha', 'doctor', '0576536679', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (184, 'Elijah Basinger', 'doctor', '0578723748', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (185, 'Darius Donelly', 'doctor', '0527572364', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (186, 'Phil McBride', 'doctor', '0516897659', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (187, 'Eileen Tippe', 'nurse', '0545455672', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (188, 'Lily Nelligan', 'doctor', '0582905944', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (189, 'Kurt Curfman', 'doctor', '0535804862', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (190, 'Carrie-Anne Woo', 'doctor', '0523373510', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (191, 'Emmylou Armstro', 'doctor', '0544809007', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (192, 'Milla Wakeling', 'assistant', '0579751633', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (193, 'Randy Parm', 'assistant', '0519028713', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (194, 'Temuera Humphre', 'assistant', '0590641085', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (195, 'Nina Skarsgard', 'nurse', '0535899372', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (196, 'Gates Lipnicki', 'assistant', '0525425873', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (197, 'Mira Ruffalo', 'assistant', '0501242670', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (198, 'Lydia Trippleho', 'doctor', '0596543920', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (199, 'Emily Lopez', 'doctor', '0541785748', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (200, 'Hector King', 'nurse', '0572067018', null);
commit;
prompt 200 records committed...
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (201, 'Rolando Tilly', 'assistant', '0544656948', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (202, 'Lydia Jackson', 'doctor', '0535425676', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (203, 'Vin Numan', 'doctor', '0509871507', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (204, 'Gino Calle', 'assistant', '0562561383', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (205, 'Colin Duvall', 'doctor', '0520959465', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (206, 'Ice Tilly', 'nurse', '0504196479', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (207, 'Geoff Shalhoub', 'assistant', '0595573839', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (208, 'Carol Kristoffe', 'doctor', '0528420816', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (209, 'Gabrielle El-Sa', 'doctor', '0511303620', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (210, 'Pamela Street', 'doctor', '0598797291', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (211, 'Pelvic Orton', 'assistant', '0569560932', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (212, 'Billy DiCaprio', 'doctor', '0559283288', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (213, 'Joely Rio', 'assistant', '0534646945', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (214, 'Davis Meniketti', 'nurse', '0581441671', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (215, 'Colleen Heald', 'assistant', '0595949901', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (216, 'Nelly Madonna', 'doctor', '0582746253', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (217, 'Grant Mason', 'nurse', '0589436475', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (218, 'Rob Gunton', 'assistant', '0550178573', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (219, 'Luis Azaria', 'doctor', '0524943611', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (220, 'Wendy Thomson', 'assistant', '0598915528', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (221, 'Annette Lewin', 'assistant', '0540461447', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (222, 'Night Reinhold', 'nurse', '0509547568', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (223, 'Vanessa Ferry', 'nurse', '0579581687', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (224, 'Thin Cruise', 'doctor', '0517317066', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (225, 'Luis Conners', 'doctor', '0597211860', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (226, 'Vienna Wills', 'assistant', '0580302097', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (227, 'Mykelti Redgrav', 'doctor', '0569023359', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (228, 'Ruth Sevenfold', 'doctor', '0589005746', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (229, 'Stephen Graham', 'assistant', '0569125153', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (230, 'Madeline Heathe', 'assistant', '0521028416', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (231, 'Mos Holden', 'nurse', '0588296030', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (232, 'Stephen Barkin', 'nurse', '0571953747', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (233, 'Grant Randal', 'doctor', '0582735375', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (234, 'Phil Keith', 'assistant', '0504678777', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (235, 'Roger Laurie', 'nurse', '0593135303', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (236, 'Anthony Carlton', 'doctor', '0540117286', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (237, 'Cevin Deschanel', 'nurse', '0507067153', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (238, 'Brian Reynolds', 'nurse', '0564885992', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (239, 'Percy Stowe', 'doctor', '0589873121', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (240, 'Dustin Vinton', 'doctor', '0528189553', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (241, 'Anthony Bening', 'nurse', '0543564434', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (242, 'Lucinda Sorvino', 'doctor', '0515664905', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (243, 'Gilberto Goldbe', 'doctor', '0520910725', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (244, 'Lance Senior', 'doctor', '0574667947', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (245, 'Jerry Lloyd', 'nurse', '0506347158', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (246, 'Edwin Dempsey', 'assistant', '0583890242', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (247, 'Beverley Burke', 'doctor', '0593081036', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (248, 'Gin Detmer', 'nurse', '0519794370', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (249, 'Sally Brandt', 'assistant', '0594129730', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (250, 'Maceo Hughes', 'nurse', '0578672416', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (251, 'Cloris O''Donnel', 'nurse', '0507680357', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (252, 'Jeff Elwes', 'doctor', '0570695393', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (253, 'Omar Christie', 'doctor', '0514109284', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (254, 'Raymond Badaluc', 'nurse', '0507933313', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (255, 'Jay Damon', 'nurse', '0554286393', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (256, 'Vern Broza', 'nurse', '0500301557', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (257, 'Breckin O''Neal', 'nurse', '0539928983', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (258, 'Oro James', 'nurse', '0500062347', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (259, 'Samantha Heslov', 'assistant', '0508346760', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (260, 'Marc Stuermer', 'nurse', '0514985381', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (261, 'Louise Kurtz', 'assistant', '0560191511', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (262, 'Thora Gellar', 'doctor', '0529140541', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (263, 'Nicole Orbit', 'nurse', '0505269968', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (264, 'Ben Stigers', 'nurse', '0506292668', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (265, 'Donald Bruce', 'doctor', '0532669522', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (266, 'Clint Englund', 'assistant', '0592633733', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (267, 'Loreena Rock', 'doctor', '0502295563', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (268, 'Woody Monk', 'nurse', '0532047916', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (269, 'Elle Busey', 'nurse', '0513853262', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (270, 'Willem Allan', 'doctor', '0557506696', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (271, 'Hector Fiennes', 'doctor', '0547874295', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (272, 'Garry Kinnear', 'nurse', '0531181774', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (273, 'Fred McGovern', 'assistant', '0580025945', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (274, 'Coley Curtis-Ha', 'assistant', '0531770602', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (275, 'Lee Basinger', 'nurse', '0576395454', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (276, 'Oliver Snow', 'doctor', '0583718306', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (277, 'Cheech Gershon', 'assistant', '0553335523', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (278, 'Stellan Ticotin', 'assistant', '0519656964', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (279, 'Uma Napolitano', 'nurse', '0565657063', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (280, 'Franz Weisz', 'nurse', '0504114769', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (281, 'Spencer Heron', 'assistant', '0567302293', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (282, 'Annette Postlet', 'doctor', '0530494243', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (283, 'Ashton Stallone', 'doctor', '0559008387', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (284, 'Bradley Arnold', 'nurse', '0579143455', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (285, 'Rita Mellencamp', 'assistant', '0515483521', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (286, 'Carl Platt', 'doctor', '0598236844', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (287, 'Joey Lawrence', 'nurse', '0568942342', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (288, 'Nelly Apple', 'doctor', '0536009374', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (289, 'Rade Suvari', 'doctor', '0500171580', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (290, 'Kyle Heston', 'doctor', '0508660845', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (291, 'Sophie Perlman', 'assistant', '0535912300', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (292, 'Gerald Mason', 'assistant', '0587929062', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (293, 'Merrill Minogue', 'assistant', '0594230676', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (294, 'Brooke Hagar', 'assistant', '0581886412', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (295, 'Brendan Wolf', 'assistant', '0578725689', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (296, 'CeCe Mills', 'assistant', '0504297150', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (297, 'Charlize Frakes', 'doctor', '0533421552', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (298, 'Leon Heslov', 'doctor', '0506448744', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (299, 'Mandy Rhames', 'assistant', '0592839286', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (300, 'Colm Robbins', 'nurse', '0574410009', null);
commit;
prompt 300 records committed...
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (301, 'Chet Goldwyn', 'assistant', '0502580527', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (302, 'Betty Hart', 'doctor', '0561413968', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (303, 'Mickey Stanley', 'assistant', '0503085370', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (304, 'Moe Wheel', 'doctor', '0529756323', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (305, 'Laurie Ball', 'nurse', '0528215431', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (306, 'James Redgrave', 'nurse', '0513769591', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (307, 'Bruce Heslov', 'doctor', '0541545782', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (308, 'Norm Valentin', 'nurse', '0591768125', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (309, 'Selma Robbins', 'assistant', '0551207782', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (310, 'Reese Coolidge', 'doctor', '0550002151', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (311, 'Chi Cervine', 'nurse', '0500770779', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (312, 'Rueben Dupree', 'doctor', '0518527309', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (313, 'Jesus Rawls', 'nurse', '0534566269', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (314, 'Ellen Webb', 'doctor', '0590667630', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (315, 'Chloe Giraldo', 'doctor', '0526629903', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (316, 'Halle Lennix', 'doctor', '0556265003', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (317, 'Shannon Purefoy', 'assistant', '0505721436', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (318, 'Fred Dourif', 'nurse', '0534338607', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (319, 'Billy Vega', 'doctor', '0543764143', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (320, 'Dave McCormack', 'doctor', '0505141499', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (321, 'Christmas Salt', 'nurse', '0587369144', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (322, 'Bernie Hudson', 'nurse', '0563650352', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (323, 'Jerry Pacino', 'nurse', '0551077593', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (324, 'Lynn Coleman', 'assistant', '0527668008', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (325, 'Coley Lynskey', 'assistant', '0500237248', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (326, 'Anthony Grant', 'assistant', '0536511134', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (327, 'Chalee Tucker', 'nurse', '0581890172', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (328, 'Geggy Colman', 'doctor', '0507681809', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (329, 'Demi Tobolowsky', 'doctor', '0526351922', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (330, 'Sinead Mellenca', 'nurse', '0584961896', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (331, 'Night Gunton', 'doctor', '0504974949', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (332, 'Harrison Watley', 'doctor', '0503997038', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (333, 'Willem Love', 'nurse', '0547291779', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (334, 'Cevin Colon', 'doctor', '0538533303', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (335, 'Neve Rawls', 'doctor', '0525174095', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (336, 'Adrien Harmon', 'assistant', '0587917540', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (337, 'Jane Holiday', 'assistant', '0536859644', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (338, 'Udo Burns', 'nurse', '0586840826', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (339, 'Geggy Guest', 'nurse', '0531307167', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (340, 'Vickie Wilder', 'nurse', '0593503657', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (341, 'Rosie Easton', 'nurse', '0529411720', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (342, 'Fionnula Downey', 'assistant', '0579250480', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (343, 'Larry Burton', 'nurse', '0552742758', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (344, 'Glen Murphy', 'assistant', '0520723707', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (345, 'Julianna Salt', 'nurse', '0582832627', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (346, 'Mekhi Soda', 'doctor', '0518793901', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (347, 'Angela Chaplin', 'assistant', '0544261250', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (348, 'Corey Ricci', 'assistant', '0520541779', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (349, 'Karen Steiger', 'doctor', '0585006481', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (350, 'Chris Sedgwick', 'doctor', '0578655934', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (351, 'Arnold Holly', 'assistant', '0543720857', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (352, 'Sarah Polley', 'nurse', '0596896147', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (353, 'Mitchell Diddle', 'doctor', '0574337415', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (354, 'Nastassja Waite', 'assistant', '0548092782', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (355, 'Tilda Thurman', 'nurse', '0515033577', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (356, 'Roger Weston', 'nurse', '0571938489', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (357, 'Omar Hackman', 'doctor', '0538604722', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (358, 'Cloris Everett', 'nurse', '0517755146', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (359, 'Marley Viterell', 'doctor', '0521676957', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (360, 'Johnette Gray', 'assistant', '0588351266', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (361, 'Alfred Goldwyn', 'doctor', '0582248484', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (362, 'Derek Kapanka', 'assistant', '0560083587', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (363, 'Russell Ellis', 'doctor', '0560480800', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (364, 'Stephen Gordon', 'assistant', '0568581750', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (365, 'Maury Costello', 'nurse', '0528108241', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (366, 'Ceili Pride', 'doctor', '0536203906', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (367, 'Howard McIntyre', 'doctor', '0534044369', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (368, 'Robin Cochran', 'assistant', '0523374712', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (369, 'Kurt Saucedo', 'doctor', '0515302730', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (370, 'Fionnula White', 'doctor', '0584008427', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (371, 'Wallace Nielsen', 'nurse', '0531032923', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (372, 'Devon Carrack', 'assistant', '0507929367', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (373, 'Avril Mahood', 'nurse', '0508234424', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (374, 'Chloe Allison', 'assistant', '0563008972', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (375, 'Harold Englund', 'nurse', '0554030034', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (376, 'Ike Schiff', 'assistant', '0570721873', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (377, 'Caroline Chan', 'assistant', '0591321476', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (378, 'Shannyn Stuart', 'assistant', '0589172361', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (379, 'Terri Withers', 'assistant', '0591470651', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (380, 'Aidan MacIsaac', 'doctor', '0544863257', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (381, 'Ming-Na Ceasar', 'doctor', '0500617204', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (382, 'Gates Stigers', 'assistant', '0552466996', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (383, 'Patrick Quinlan', 'doctor', '0575124983', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (384, 'Wayman McCormac', 'assistant', '0547844700', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (385, 'Howard Mraz', 'assistant', '0575498744', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (386, 'Julie Nivola', 'assistant', '0545145810', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (387, 'Sona Donelly', 'doctor', '0598866715', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (388, 'Dan Stiles', 'assistant', '0574646416', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (389, 'Sammy Mills', 'assistant', '0569871119', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (390, 'Sander Pesci', 'doctor', '0524586754', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (391, 'Louise Wolf', 'assistant', '0591106978', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (392, 'Sarah DiFranco', 'doctor', '0596393346', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (393, 'Curt Cartlidge', 'nurse', '0512009987', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (394, 'Leon Rhodes', 'doctor', '0599193324', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (395, 'Ethan Herndon', 'doctor', '0506346922', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (396, 'Hilary McPherso', 'assistant', '0506582906', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (397, 'Josh Gugino', 'doctor', '0566215679', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (398, 'Red Curry', 'assistant', '0529034714', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (399, 'Teri Hawthorne', 'assistant', '0549671213', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (400, 'Giancarlo Cohn', 'doctor', '0572853823', null);
commit;
prompt 400 records committed...
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (401, 'Angela Brando', 'doctor', '0547966739', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (402, 'Juan Elizondo', 'doctor', '0553907577', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (403, 'Terri Hawn', 'nurse', '0519735023', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (404, 'Ben Platt', 'doctor', '0558015064', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (405, 'Dermot Freeman', 'nurse', '0562879393', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (406, 'Stephen Johanse', 'nurse', '0546727259', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (407, 'Clive Ribisi', 'nurse', '0545509542', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (408, 'Rod Waite', 'nurse', '0544412682', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (409, 'Kirk Isaak', 'doctor', '0518237845', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (410, 'Larenz Washingt', 'assistant', '0544321591', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (411, 'Taryn Polito', 'doctor', '0526852719', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (412, 'Ethan Giraldo', 'assistant', '0533930930', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (413, 'Freddie Ellis', 'doctor', '0592409326', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (414, 'Donal Lucien', 'nurse', '0513525696', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (415, 'Luke Chambers', 'nurse', '0574716895', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (416, 'Kelly Burke', 'assistant', '0588354941', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (417, 'Christmas Colle', 'doctor', '0586444467', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (418, 'Kate Chaykin', 'assistant', '0587552584', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (419, 'Radney Chan', 'nurse', '0592253458', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (420, 'Chloe Kinski', 'nurse', '0535105792', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (421, 'Roscoe Pryce', 'doctor', '0541849693', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (422, 'Trick Gugino', 'assistant', '0513809509', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (423, 'Lucinda Thorton', 'nurse', '0589180517', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (424, 'Lizzy Feuerstei', 'nurse', '0525934376', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (425, 'Leon Schock', 'assistant', '0560434274', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (426, 'Alice Ness', 'nurse', '0532291161', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (427, 'Jane Deejay', 'nurse', '0572598916', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (428, 'Vickie Hedaya', 'doctor', '0554765952', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (429, 'Annette Gandolf', 'assistant', '0543379065', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (430, 'Marley McKennit', 'doctor', '0551848086', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (431, 'Brian Theron', 'nurse', '0596455107', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (432, 'Natacha Wiest', 'nurse', '0556509479', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (433, 'Fisher Chapman', 'nurse', '0571556364', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (434, 'Suzanne Darren', 'doctor', '0514973498', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (435, 'Brothers Chappe', 'doctor', '0568529032', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (436, 'Claire Daniels', 'nurse', '0595053330', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (437, 'Frank Malkovich', 'assistant', '0510605150', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (438, 'Meredith Sarsga', 'nurse', '0539196471', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (439, 'Sander Aykroyd', 'nurse', '0534173856', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (440, 'Marlon Suchet', 'doctor', '0553717591', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (441, 'Gaby Chaplin', 'doctor', '0598354297', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (442, 'Taryn Warwick', 'assistant', '0572493171', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (443, 'Orlando Khan', 'nurse', '0577960778', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (444, 'Lydia Kennedy', 'nurse', '0574997170', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (445, 'Arnold Akins', 'doctor', '0541837927', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (446, 'Mark Aglukark', 'assistant', '0533408745', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (447, 'Patti Cohn', 'nurse', '0559675823', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (448, 'Emma Dillane', 'assistant', '0559870035', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (449, 'Crystal Murray', 'doctor', '0572183897', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (450, 'King McLachlan', 'doctor', '0570774863', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (451, 'Ralph Rhames', 'doctor', '0509650931', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (452, 'Robert Garofalo', 'doctor', '0509327556', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (453, 'Udo Weisz', 'nurse', '0500271874', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (454, 'Nigel Hauer', 'doctor', '0504579852', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (455, 'Robby Stanton', 'doctor', '0541681496', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (456, 'Barry Koteas', 'doctor', '0527940663', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (457, 'Linda Ford', 'assistant', '0559993179', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (458, 'Hank Atkinson', 'nurse', '0553739065', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (459, 'Rebecca Underwo', 'doctor', '0557549219', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (460, 'Stevie Hanks', 'nurse', '0517195964', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (461, 'Beth Gaines', 'nurse', '0576899386', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (462, 'Rene Whitman', 'doctor', '0582327951', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (463, 'Nina urban', 'doctor', '0532945740', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (464, 'Judy Kurtz', 'assistant', '0590518539', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (465, 'Marianne Belles', 'nurse', '0523903373', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (466, 'Kieran Peebles', 'doctor', '0567915767', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (467, 'Isaac Kennedy', 'assistant', '0580203161', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (468, 'Katie Tankard', 'doctor', '0588433117', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (469, 'Christina Sherm', 'assistant', '0575343877', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (470, 'Hector Harmon', 'nurse', '0512322098', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (471, 'Samantha Rispol', 'assistant', '0591720045', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (472, 'Chubby Leguizam', 'nurse', '0537448834', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (473, 'Lari Makowicz', 'nurse', '0547403920', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (474, 'Mary-Louise Cum', 'nurse', '0547652942', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (475, 'Alessandro Krav', 'nurse', '0572580891', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (476, 'Emm Richter', 'nurse', '0593604085', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (477, 'Tara Mazar', 'nurse', '0512248129', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (478, 'Joe Ponty', 'assistant', '0533192702', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (479, 'Terrence McCona', 'nurse', '0546603521', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (480, 'Carrie-Anne Log', 'nurse', '0534205591', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (481, 'Darius Dorn', 'doctor', '0522183757', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (482, 'Rosie Whitford', 'nurse', '0515829336', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (483, 'Roy Kudrow', 'doctor', '0549620634', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (484, 'Julie Vai', 'nurse', '0587978739', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (485, 'Garry Stills', 'nurse', '0541883838', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (486, 'Woody Hunter', 'nurse', '0574324028', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (487, 'Crystal Gaynor', 'assistant', '0549576897', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (488, 'Guy Evett', 'doctor', '0500633160', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (489, 'Praga McCain', 'doctor', '0507411946', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (490, 'Julianna Senior', 'assistant', '0599886005', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (491, 'Mos Bening', 'nurse', '0506467733', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (492, 'Art Harris', 'assistant', '0598461577', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (493, 'Dabney Haynes', 'nurse', '0571069991', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (494, 'Gloria Fender', 'nurse', '0586443391', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (495, 'Diane Mandrell', 'doctor', '0587893570', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (496, 'Ralph Rooker', 'doctor', '0588764308', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (497, 'Geggy Lynne', 'doctor', '0569397552', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (498, 'Rade Scaggs', 'doctor', '0588890787', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (499, 'Ernest Ferrer', 'doctor', '0573358850', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (500, 'Scott Rhymes', 'assistant', '0530607607', null);
commit;
prompt 500 records committed...
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (501, 'noa', 'doctor', '0525501770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (502, 'shira', 'doctor', '0528501770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (503, 'dror', 'nurse', '0527501770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (504, 'hod', 'doctor', '0527601770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (505, 'rivka', 'nurse', '0523241770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (506, 'bat sheva', 'assistant', '0512301770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (507, 'moriya', 'assistant', '0534501770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (508, 'hila', 'doctor', '0523401770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (509, 'shaar', 'assistant', '0527655770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (510, 'talya', 'doctor', '0527651770', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (601, 'Dr. Smith', 'doctor', '5551112222', null);
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (602, 'Lin Stigers', 'doctor', '700', 'Colorectal Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (603, 'Bernard Brickel', 'doctor', '701', 'Pain Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (604, 'Carolyn Boothe', 'doctor', '702', 'Clinical Pharmacology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (605, 'Kate MacPherson', 'doctor', '703', 'Occupational Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (606, 'Pat Biehn', 'doctor', '704', 'Orthopedics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (607, 'Rick Coburn', 'doctor', '705', 'Nuclear Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (608, 'Gates Paltrow', 'doctor', '706', 'Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (609, 'Anita Cheadle', 'doctor', '707', 'Interventional Radiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (610, 'Lenny Hong', 'doctor', '708', 'Family Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (611, 'Andrea Kirshner', 'doctor', '709', 'Oncology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (612, 'Bebe Blaine', 'doctor', '710', 'Pain Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (613, 'Franz Bridges', 'doctor', '711', 'Sports Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (614, 'Jann Harry', 'doctor', '712', 'Pediatric Endocrinology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (615, 'Wallace Ceasar', 'doctor', '713', 'Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (616, 'Sally Mahoney', 'doctor', '714', 'Hospice and Palliative Medicin');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (617, 'Rhea Gough', 'doctor', '715', 'Pediatric Cardiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (618, 'Davey Askew', 'doctor', '716', 'Speech-Language Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (619, 'Embeth Rosas', 'doctor', '717', 'Pediatrics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (620, 'Sal Shand', 'doctor', '718', 'Burn Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (621, 'Ryan Ermey', 'doctor', '719', 'Speech-Language Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (622, 'Carolyn Voight', 'doctor', '720', 'Allergy and Immunology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (623, 'Grant Miles', 'doctor', '721', 'Medical Toxicology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (624, 'Gary Broza', 'doctor', '722', 'Emergency Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (625, 'Shirley Fariq', 'doctor', '723', 'Speech-Language Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (626, 'Mark Postlethwa', 'doctor', '724', 'Aerospace Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (627, 'Mike DiFranco', 'doctor', '725', 'General Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (628, 'Raul Conroy', 'doctor', '726', 'Neuroradiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (629, 'Dick McGovern', 'doctor', '727', 'Clinical Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (630, 'Lauren Levy', 'doctor', '728', 'Infectious Disease');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (631, 'Gabrielle Salt', 'doctor', '729', 'Pediatric Gastroenterology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (632, 'Demi Loveless', 'doctor', '730', 'Cytopathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (633, 'Mindy Chesnutt', 'doctor', '731', 'Gynecology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (634, 'Mary Briscoe', 'doctor', '732', 'Pain Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (635, 'Christmas Colli', 'doctor', '733', 'Pediatric Gastroenterology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (636, 'Marisa Close', 'doctor', '734', 'Nuclear Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (637, 'Spencer DeVito', 'doctor', '735', 'Transplant Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (638, 'Julianne Agluka', 'doctor', '736', 'Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (639, 'Stephanie Moore', 'doctor', '737', 'Public Health Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (640, 'Terry Rispoli', 'doctor', '738', 'Infectious Disease');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (641, 'Saul Ifans', 'doctor', '739', 'Genetic Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (642, 'Winona Sawa', 'doctor', '740', 'Allergy and Immunology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (643, 'Oded Sampson', 'doctor', '741', 'Pediatric Pulmonology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (644, 'Jesse James', 'doctor', '742', 'Forensic Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (645, 'Roscoe Tomei', 'doctor', '743', 'Internal Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (646, 'Judi Hershey', 'doctor', '744', 'General Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (647, 'Debby Wilkinson', 'doctor', '745', 'Pediatric Pulmonology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (648, 'Maureen Balaban', 'doctor', '746', 'Oncology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (649, 'Saul Dafoe', 'doctor', '747', 'Preventive Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (650, 'Edgar Adkins', 'doctor', '748', 'Pediatric Orthopedics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (651, 'Quentin El-Sahe', 'doctor', '749', 'Forensic Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (652, 'Buddy Pearce', 'doctor', '750', 'Pediatric Pulmonology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (653, 'Quentin Bratt', 'doctor', '751', 'Nutrition and Dietetics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (654, 'Janeane Conditi', 'doctor', '752', 'Nuclear Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (655, 'Simon Tisdale', 'doctor', '753', 'Transplant Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (656, 'Treat Holmes', 'doctor', '754', 'Hepatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (657, 'Manu Wahlberg', 'doctor', '755', 'Pediatric Urology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (658, 'Oded Bonneville', 'doctor', '756', 'Neurology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (659, 'Miles Reno', 'doctor', '757', 'Nuclear Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (660, 'Ellen Oates', 'doctor', '758', 'Pediatric Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (661, 'Carrie-Anne Vai', 'doctor', '759', 'Anesthesiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (662, 'Frank Stanton', 'doctor', '760', 'Pediatric Orthopedics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (663, 'Roger Wright', 'doctor', '761', 'Pediatric Urology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (664, 'Sal Blair', 'doctor', '762', 'Pediatric Infectious Disease');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (665, 'Millie Thornton', 'doctor', '763', 'Nuclear Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (666, 'Heather Peterso', 'doctor', '764', 'Genetic Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (667, 'Ty Hornsby', 'doctor', '765', 'Surgical Oncology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (668, 'Ahmad Clark', 'doctor', '766', 'Geriatric Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (669, 'Meg Nivola', 'doctor', '767', 'Clinical Pharmacology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (670, 'Anthony Berkley', 'doctor', '768', 'Clinical Neurophysiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (671, 'Gina Pfeiffer', 'doctor', '769', 'Pediatric Urology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (672, 'Geraldine Green', 'doctor', '770', 'Pediatric Neurology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (673, 'Lee Capshaw', 'doctor', '771', 'Clinical Pharmacology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (674, 'Bo Condition', 'doctor', '772', 'Pharmacology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (675, 'Gates Prowse', 'doctor', '773', 'Pharmacology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (676, 'Sydney Sampson', 'doctor', '774', 'Ophthalmology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (677, 'Ani McDiarmid', 'doctor', '775', 'Pediatric Nephrology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (678, 'Etta Peniston', 'doctor', '776', 'Interventional Radiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (679, 'Ramsey Sisto', 'doctor', '777', 'Molecular Genetic Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (680, 'Mike Raye', 'doctor', '778', 'Pediatric Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (681, 'Julio Ward', 'doctor', '779', 'Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (682, 'Martha Carradin', 'doctor', '780', 'Clinical Laboratory Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (683, 'Lari Marshall', 'doctor', '781', 'Nephrology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (684, 'Rose Loring', 'doctor', '782', 'Obstetrics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (685, 'Earl Peebles', 'doctor', '783', 'Interventional Radiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (686, 'Gordie Madonna', 'doctor', '784', 'Medical Microbiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (687, 'Suzanne Bogguss', 'doctor', '785', 'Endocrine Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (688, 'Wade Lawrence', 'doctor', '786', 'Gastroenterology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (689, 'Jerry Branagh', 'doctor', '787', 'Infectious Disease');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (690, 'Timothy Lang', 'doctor', '788', 'Emergency Medicine');
commit;
prompt 600 records committed...
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (691, 'Alfie Mewes', 'doctor', '789', 'Ophthalmology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (692, 'Corey Brando', 'doctor', '790', 'Adolescent Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (693, 'Roger Payne', 'doctor', '791', 'Pediatric Orthopedics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (694, 'Darius DiBiasio', 'doctor', '792', 'Addiction Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (695, 'Gloria Larter', 'doctor', '793', 'Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (696, 'Norm Favreau', 'doctor', '794', 'Pediatric Gastroenterology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (697, 'Hazel Epps', 'doctor', '795', 'General Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (698, 'Glen Sawa', 'doctor', '796', 'Military Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (699, 'Gina Mitra', 'doctor', '797', 'Palliative Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (700, 'Radney Bragg', 'doctor', '798', 'Pediatric Endocrinology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (701, 'Kyra Rebhorn', 'doctor', '799', 'Legal Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (702, 'Junior Gertner', 'doctor', '800', 'Preventive Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (703, 'Ozzy Duke', 'doctor', '801', 'Pediatric Orthopedics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (704, 'Jimmy Jane', 'doctor', '802', 'Pediatric Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (705, 'Vondie Lipnicki', 'doctor', '803', 'Obstetrics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (706, 'Vickie Salt', 'doctor', '804', 'Family Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (707, 'Lennie Tempest', 'doctor', '805', 'Cardiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (708, 'Bret Bright', 'doctor', '806', 'Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (709, 'Meredith Platt', 'doctor', '807', 'Nutrition and Dietetics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (710, 'Miles Wayans', 'doctor', '808', 'Dermatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (711, 'Julio Dupree', 'doctor', '809', 'Hematology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (712, 'Fats Coltrane', 'doctor', '810', 'Allergy and Immunology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (713, 'Lari Shaw', 'doctor', '811', 'Burn Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (714, 'Tzi Gibson', 'doctor', '812', 'Nuclear Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (715, 'Davey Randal', 'doctor', '813', 'Forensic Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (716, 'Josh Holly', 'doctor', '814', 'Physical Medicine and Rehabili');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (717, 'Bo Union', 'doctor', '815', 'Obstetrics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (718, 'Brendan Levy', 'doctor', '816', 'Neurosurgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (719, 'Radney Vicious', 'doctor', '817', 'Plastic Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (720, 'Tia Lennix', 'doctor', '818', 'Nuclear Radiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (721, 'Frances Mac', 'doctor', '819', 'Hyperbaric Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (722, 'Belinda Plowrig', 'doctor', '820', 'General Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (723, 'Gil Zahn', 'doctor', '821', 'Neurology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (724, 'Jesse Rapaport', 'doctor', '822', 'Social Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (725, 'Davy McKellen', 'doctor', '823', 'Infectious Disease');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (726, 'Helen Weaving', 'doctor', '824', 'Medical Microbiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (727, 'Scarlett Baldwi', 'doctor', '825', 'Colorectal Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (728, 'Carlos Busey', 'doctor', '826', 'Pain Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (729, 'Wayman Forster', 'doctor', '827', 'Oral and Maxillofacial Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (730, 'Chad Berry', 'doctor', '828', 'Hematology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (731, 'Candice O''Neal', 'doctor', '829', 'Forensic Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (732, 'Sylvester MacIs', 'doctor', '830', 'Preventive Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (733, 'Rita Ramirez', 'doctor', '831', 'Interventional Cardiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (734, 'Lindsey Carlton', 'doctor', '832', 'Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (735, 'Mili Mann', 'doctor', '833', 'Aerospace Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (736, 'Talvin Sinatra', 'doctor', '834', 'Transplant Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (737, 'Mika Kidman', 'doctor', '835', 'Transfusion Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (738, 'Meg Guilfoyle', 'doctor', '836', 'Radiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (739, 'Javon Madonna', 'doctor', '837', 'Nutrition and Dietetics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (740, 'Pat Henriksen', 'doctor', '838', 'Genetic Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (741, 'Emma Monk', 'doctor', '839', 'Vascular Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (742, 'Lee McGregor', 'doctor', '840', 'Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (743, 'Sharon Oldman', 'doctor', '841', 'General Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (744, 'Colm Cobbs', 'doctor', '842', 'Cardiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (745, 'Alex Busey', 'doctor', '843', 'Pediatric Pulmonology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (746, 'Fiona Lloyd', 'doctor', '844', 'Geriatric Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (747, 'Dabney Apple', 'doctor', '845', 'Anatomic Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (748, 'Azucar Williams', 'doctor', '846', 'Pediatric Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (749, 'Jared Tambor', 'doctor', '847', 'Pediatric Endocrinology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (750, 'Jessica Popper', 'doctor', '848', 'Pediatric Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (751, 'Tanya Parm', 'doctor', '849', 'Occupational and Environmental');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (752, 'Barbara Holbroo', 'doctor', '850', 'Radiation Oncology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (753, 'Sam O''Donnell', 'doctor', '851', 'Pediatrics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (754, 'Sarah Tolkan', 'doctor', '852', 'Forensic Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (755, 'Lindsay Rebhorn', 'doctor', '853', 'Transfusion Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (756, 'Wayne Weaver', 'doctor', '854', 'Occupational and Environmental');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (757, 'Daryle Cazale', 'doctor', '855', 'Medical Microbiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (758, 'Bruce Arkin', 'doctor', '856', 'Cytopathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (759, 'Rolando Daniels', 'doctor', '857', 'Internal Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (760, 'Lindsey Rossell', 'doctor', '858', 'Medical Toxicology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (761, 'Sean Armstrong', 'doctor', '859', 'Transplant Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (762, 'Phoebe Broza', 'doctor', '860', 'Preventive Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (763, 'Sandra Miles', 'doctor', '861', 'Family Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (764, 'Teena Presley', 'doctor', '862', 'Surgical Oncology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (765, 'Brian Buscemi', 'doctor', '863', 'Emergency Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (766, 'Mia Tyler', 'doctor', '864', 'Pediatrics');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (767, 'Sander Dillane', 'doctor', '865', 'Medical Microbiology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (768, 'Bobbi Cole', 'doctor', '866', 'Clinical Immunology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (769, 'Sarah Flemyng', 'doctor', '867', 'Geriatric Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (770, 'Alice Berkoff', 'doctor', '868', 'Neurosurgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (771, 'First McLean', 'doctor', '869', 'Adolescent Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (772, 'Katrin Solido', 'doctor', '870', 'Public Health Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (773, 'Leo Irving', 'doctor', '871', 'Transplant Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (774, 'Ashton Quatro', 'doctor', '872', 'Public Health Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (775, 'Taryn Gershon', 'doctor', '873', 'Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (776, 'Diane Stevenson', 'doctor', '874', 'Colorectal Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (777, 'Chet Brooke', 'doctor', '875', 'Intensive Care Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (778, 'Busta Lithgow', 'doctor', '876', 'Otolaryngology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (779, 'Peter Rooker', 'doctor', '877', 'Pediatric Neurology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (780, 'Brooke Hopkins', 'doctor', '878', 'Genetic Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (781, 'Tom Webb', 'doctor', '879', 'Hepatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (782, 'Sander Aaron', 'doctor', '880', 'Pediatric Hematology-Oncology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (783, 'Rip Tomlin', 'doctor', '881', 'Otolaryngology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (784, 'Jean-Claude Alm', 'doctor', '882', 'Ophthalmology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (785, 'Hugo Emmett', 'doctor', '883', 'Transfusion Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (786, 'Stellan Pullman', 'doctor', '884', 'Pediatric Rheumatology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (787, 'Wang Furay', 'doctor', '885', 'Pediatric Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (788, 'Rachael Clayton', 'doctor', '886', 'Chemical Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (789, 'Martha Madonna', 'doctor', '887', 'Oncology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (790, 'Rip Charles', 'doctor', '888', 'Vascular Surgery');
commit;
prompt 700 records committed...
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (791, 'Franz Love', 'doctor', '889', 'Gynecology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (792, 'Shawn Stanton', 'doctor', '890', 'Molecular Genetic Pathology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (793, 'Lou Jolie', 'doctor', '891', 'Otolaryngology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (794, 'Lionel Kinski', 'doctor', '892', 'Neonatal-Perinatal Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (795, 'Val Noseworthy', 'doctor', '893', 'Pediatric Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (796, 'Rupert Gray', 'doctor', '894', 'Allergy and Immunology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (797, 'Leonardo Moody', 'doctor', '895', 'Palliative Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (798, 'Peabo Hornsby', 'doctor', '896', 'Pharmacology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (799, 'Bebe Goodman', 'doctor', '897', 'Geriatric Medicine');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (800, 'Cliff Torino', 'doctor', '898', 'Urology');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (801, 'Kasey Thornton', 'doctor', '899', 'Vascular Surgery');
insert into CLIENTS (cid, cname, crole, cphonenumber, speciallization)
values (802, 'roni cohen', 'doctor', '890', 'Pediatrics women');
commit;
prompt 712 records loaded
prompt Loading DEPARTMENT...
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (89, 'Palliative Care', 3, 1);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (103, 'Rheumatology', 4, 2);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (66, 'Infectious Diseases', 0, 3);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (10, 'Anesthesiology', 1, 4);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (188, 'Geriatrics', 0, 5);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (174, 'Plastic Surgery', 5, 6);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (38, 'Burn Unit', 6, 7);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (65, 'Hepatology', 2, 8);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (96, 'General Surgery', 0, 9);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (13, 'Clinical Laboratory', 5, 10);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (61, 'Endocrinology', 2, 11);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (119, 'Plastic Surgery', 5, 12);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (181, 'Gastroenterology', 4, 13);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (111, 'Palliative Care', 0, 14);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (177, 'Ophthalmology', 3, 15);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (54, 'Neonatology', 5, 16);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (56, 'Internal Medicine', 0, 17);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (24, 'Allergy', 4, 18);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (27, 'ENT', 0, 19);
insert into DEPARTMENT (cuurent_num_of_patient, dep_name, floor, dep_id)
values (68, 'Allergy', 4, 20);
commit;
prompt 20 records loaded
prompt Loading SHIPMENTADDRESS...
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 145, 1, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 178, 2, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 245, 3, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 367, 4, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 234, 5, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 123, 6, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 12, 7, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 34, 8, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 23, 9, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 45, 10, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 34, 11, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 23, 12, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 67, 13, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 34, 14, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 23, 15, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 45, 16, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 56, 17, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 67, 18, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 78, 19, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 123, 20, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 456, 21, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 789, 22, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 345, 23, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 654, 24, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 246, 25, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 754, 26, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 875, 27, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 457, 28, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 123, 29, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 345, 30, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 765, 31, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 458, 32, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 1, 33, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 2, 34, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 3, 35, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 4, 36, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 5, 37, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 5, 38, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 3, 39, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 4, 40, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 3, 41, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 233, 42, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 6, 43, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 5, 44, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 4, 45, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 3, 46, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 4, 47, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 2, 48, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 1, 49, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 6, 50, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 5, 51, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 4, 52, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 3, 53, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 4, 54, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 123, 55, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 456, 56, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 345, 57, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 678, 58, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 123, 59, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 465, 60, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 888, 61, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 777, 62, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 666, 63, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 555, 64, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 444, 65, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 333, 66, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 456, 67, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 234, 68, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 654, 69, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 876, 70, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 456, 71, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 123, 72, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 543, 73, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 111, 74, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 112, 75, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 113, 76, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 114, 77, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 115, 78, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 116, 79, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 117, 80, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 118, 81, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 119, 82, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 120, 83, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 121, 84, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 122, 85, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 123, 86, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 124, 87, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 125, 88, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 126, 89, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 127, 90, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 128, 91, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 129, 92, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 130, 93, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 131, 94, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 132, 95, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 133, 96, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 134, 97, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 135, 98, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 136, 99, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 137, 100, null, null, null);
commit;
prompt 100 records committed...
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 138, 101, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 139, 102, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 140, 103, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 141, 104, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 142, 105, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 143, 106, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 144, 107, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 145, 108, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 146, 109, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 147, 110, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 148, 111, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 149, 112, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 150, 113, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 151, 114, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 152, 115, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 153, 116, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 154, 117, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 155, 118, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 156, 119, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 157, 120, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 158, 121, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 159, 122, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 160, 123, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 161, 124, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 162, 125, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 163, 126, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 164, 127, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 165, 128, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 166, 129, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 167, 130, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 168, 131, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 169, 132, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 170, 133, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 171, 134, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 172, 135, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 173, 136, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 174, 137, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 175, 138, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 176, 139, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 177, 140, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 178, 141, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 179, 142, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 180, 143, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 181, 144, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 182, 145, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 183, 146, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 184, 147, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 185, 148, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 186, 149, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 187, 150, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 188, 151, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 189, 152, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 190, 153, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 191, 154, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 192, 155, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 193, 156, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 194, 157, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 195, 158, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 196, 159, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 197, 160, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 198, 161, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 199, 162, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 200, 163, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 201, 164, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 202, 165, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 203, 166, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 204, 167, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 205, 168, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 206, 169, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 207, 170, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 208, 171, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 209, 172, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 210, 173, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 211, 174, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 212, 175, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 213, 176, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 214, 177, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 215, 178, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 216, 179, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 217, 180, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 218, 181, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 219, 182, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 220, 183, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 221, 184, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 222, 185, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 223, 186, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 224, 187, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 225, 188, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 226, 189, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 227, 190, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 228, 191, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 229, 192, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 230, 193, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 231, 194, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 232, 195, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 233, 196, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 234, 197, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 235, 198, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 236, 199, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 237, 200, null, null, null);
commit;
prompt 200 records committed...
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 238, 201, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 239, 202, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 240, 203, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 241, 204, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 242, 205, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 243, 206, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 244, 207, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 245, 208, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 246, 209, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 247, 210, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 248, 211, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 249, 212, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 250, 213, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 251, 214, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 252, 215, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 253, 216, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 254, 217, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 255, 218, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 256, 219, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 257, 220, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 258, 221, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 259, 222, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 260, 223, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 261, 224, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 262, 225, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 263, 226, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 264, 227, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 265, 228, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 266, 229, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 267, 230, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 268, 231, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 269, 232, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 270, 233, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 271, 234, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 272, 235, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 273, 236, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 274, 237, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 275, 238, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 276, 239, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 277, 240, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 278, 241, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 279, 242, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 280, 243, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 281, 244, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 282, 245, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 283, 246, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 284, 247, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 285, 248, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 286, 249, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 287, 250, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 288, 251, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 289, 252, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 290, 253, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 291, 254, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 292, 255, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 293, 256, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 294, 257, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 295, 258, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 296, 259, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 297, 260, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 298, 261, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 299, 262, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 300, 263, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 301, 264, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 302, 265, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 303, 266, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 304, 267, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 305, 268, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 306, 269, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 307, 270, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 308, 271, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 309, 272, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 310, 273, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 311, 274, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 312, 275, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 313, 276, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 314, 277, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 315, 278, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 316, 279, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 317, 280, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 318, 281, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 319, 282, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 320, 283, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 321, 284, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 322, 285, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 323, 286, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 324, 287, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 325, 288, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 326, 289, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 327, 290, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 328, 291, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 329, 292, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 330, 293, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 331, 294, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 332, 295, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 333, 296, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 334, 297, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 335, 298, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 336, 299, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 337, 300, null, null, null);
commit;
prompt 300 records committed...
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 338, 301, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 339, 302, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 340, 303, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 341, 304, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 342, 305, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 343, 306, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 344, 307, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 345, 308, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 346, 309, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 347, 310, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 348, 311, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 349, 312, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 350, 313, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 351, 314, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 352, 315, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 353, 316, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 354, 317, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 355, 318, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 356, 319, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 357, 320, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 358, 321, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 359, 322, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 360, 323, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 361, 324, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 362, 325, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 363, 326, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 364, 327, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 365, 328, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 366, 329, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 367, 330, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 368, 331, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 369, 332, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 370, 333, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 371, 334, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 372, 335, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 373, 336, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 374, 337, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 375, 338, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 376, 339, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 377, 340, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 378, 341, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 379, 342, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 380, 343, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 381, 344, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 382, 345, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 383, 346, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 384, 347, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 385, 348, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 386, 349, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 387, 350, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 388, 351, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 389, 352, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 390, 353, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 391, 354, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 392, 355, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 393, 356, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 394, 357, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 395, 358, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 396, 359, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 397, 360, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 398, 361, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 399, 362, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 400, 363, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 401, 364, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 402, 365, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 403, 366, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 404, 367, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 405, 368, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 406, 369, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 407, 370, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 408, 371, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 409, 372, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 410, 373, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 411, 374, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 412, 375, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 413, 376, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 414, 377, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 415, 378, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 416, 379, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 417, 380, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 418, 381, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 419, 382, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 420, 383, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 421, 384, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 422, 385, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 423, 386, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 424, 387, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 425, 388, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 426, 389, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 427, 390, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 428, 391, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 429, 392, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 430, 393, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 431, 394, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 432, 395, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 433, 396, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 434, 397, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 435, 398, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 436, 399, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 437, 400, null, null, null);
commit;
prompt 400 records committed...
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 438, 401, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 439, 402, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 440, 403, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 441, 404, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 442, 405, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 443, 406, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 444, 407, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 445, 408, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 446, 409, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 447, 410, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 448, 411, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 449, 412, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 111, 413, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 112, 414, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 113, 415, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 114, 416, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 115, 417, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 116, 418, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 117, 419, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 118, 420, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 119, 421, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 120, 422, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 121, 423, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 122, 424, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 123, 425, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 124, 426, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 125, 427, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 126, 428, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 127, 429, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 128, 430, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 129, 431, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 130, 432, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 131, 433, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 132, 434, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 133, 435, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 134, 436, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 135, 437, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 136, 438, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 137, 439, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 138, 440, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 139, 441, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 140, 442, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 141, 443, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 142, 444, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 143, 445, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 144, 446, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 145, 447, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 146, 448, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 147, 449, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 148, 450, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 149, 451, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 150, 452, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 151, 453, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 152, 454, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 153, 455, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 154, 456, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 155, 457, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 156, 458, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 157, 459, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 158, 460, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 159, 461, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 160, 462, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 161, 463, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 162, 464, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 163, 465, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 164, 466, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 165, 467, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 166, 468, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 167, 469, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 168, 470, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 169, 471, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 170, 472, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 171, 473, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 172, 474, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 173, 475, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 174, 476, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 175, 477, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 176, 478, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 177, 479, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 178, 480, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 179, 481, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 180, 482, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 181, 483, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 182, 484, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 183, 485, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 184, 486, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 185, 487, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 186, 488, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 187, 489, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 188, 490, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 189, 491, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 190, 492, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 191, 493, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 192, 494, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 193, 495, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 194, 496, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 195, 497, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 196, 498, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 197, 499, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 198, 500, null, null, null);
commit;
prompt 500 records committed...
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 199, 501, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 200, 502, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 201, 503, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 202, 504, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 203, 505, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 4, 506, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 17, 507, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 17, 508, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 27, 509, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 67, 510, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 7, 511, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 7, 512, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 8, 513, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 277, 514, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('shaarey tzedek', 27, 515, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('hadsa', 1, 516, null, null, null);
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 800, 517, 1, 3, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 801, 518, 1, 4, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 802, 519, 1, 2, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 803, 520, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 804, 521, 1, 2, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 805, 522, 1, 4, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 806, 523, 1, 5, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 807, 524, 1, 1, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 808, 525, 1, 2, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 809, 526, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 810, 527, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 811, 528, 1, 2, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 812, 529, 1, 5, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 813, 530, 1, 5, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 814, 531, 1, 2, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 815, 532, 1, 3, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 816, 533, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 817, 534, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 818, 535, 1, 4, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 819, 536, 1, 4, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 820, 537, 1, 2, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 821, 538, 1, 5, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 822, 539, 1, 4, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 823, 540, 1, 4, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 824, 541, 1, 5, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 825, 542, 1, 4, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 826, 543, 1, 3, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 827, 544, 1, 2, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 828, 545, 1, 2, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 829, 546, 1, 2, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 830, 547, 1, 3, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 831, 548, 1, 4, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 832, 549, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 833, 550, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 834, 551, 1, 3, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 835, 552, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 836, 553, 1, 2, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 837, 554, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 838, 555, 1, 5, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 839, 556, 1, 3, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 840, 557, 1, 4, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 841, 558, 1, 5, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 842, 559, 1, 2, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 843, 560, 1, 5, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 844, 561, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 845, 562, 1, 4, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 846, 563, 1, 5, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 847, 564, 1, 4, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 848, 565, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 849, 566, 1, 3, 'Available');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 851, 567, 1, 1, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 852, 568, 1, 3, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 799, 569, 1, 4, 'Occupied');
insert into SHIPMENTADDRESS (hospitalname, hroom, shipid, dep_id, num_of_beds, availability)
values ('soroka', 798, 570, 1, 4, 'Available');
commit;
prompt 570 records loaded
prompt Loading PATIENT...
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (235, 'released', ' 04884 Laura Springs', to_date('04-07-1972', 'dd-mm-yyyy'), ' Kimberly Bowen', 250, to_date('28-01-2024', 'dd-mm-yyyy'), to_date('07-12-2023', 'dd-mm-yyyy'), 519);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (236, 'released', ' 5667 Joshua Traffic', to_date('09-07-2002', 'dd-mm-yyyy'), ' Shelly Barrett', 846, to_date('05-02-2024', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 530);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (237, 'released', ' 931 Chung Burg', to_date('22-04-1982', 'dd-mm-yyyy'), ' Marc Torres', 180, to_date('07-02-2024', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 563);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (238, 'released', ' 03453 Snow Forest A', to_date('08-10-2013', 'dd-mm-yyyy'), ' Linda Clark', 667, to_date('27-05-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 522);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (239, 'released', ' 99760 Jeff Port', to_date('18-02-1959', 'dd-mm-yyyy'), ' Brittany Olson', 615, to_date('25-04-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 547);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (241, 'released', ' 53975 Skinner Hollo', to_date('08-04-1993', 'dd-mm-yyyy'), ' Jose Davis', 791, to_date('11-06-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 518);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (242, 'released', ' 615 Laura Ford Apt.', to_date('10-09-1962', 'dd-mm-yyyy'), ' Karen Mcknight', 670, to_date('09-12-2023', 'dd-mm-yyyy'), to_date('21-08-2023', 'dd-mm-yyyy'), 533);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (243, 'released', ' 173 Walter Corner', to_date('30-04-1952', 'dd-mm-yyyy'), ' Lisa Neal', 203, to_date('28-06-2023', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 564);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (244, 'released', ' 951 Charles Haven A', to_date('02-07-1966', 'dd-mm-yyyy'), ' Michelle Stewart', 809, to_date('26-04-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 565);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (245, 'released', ' 39993 Mason Squares', to_date('14-05-1944', 'dd-mm-yyyy'), ' Crystal Wise', 645, to_date('02-09-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 518);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (246, 'released', ' 29244 Catherine Jun', to_date('18-03-1950', 'dd-mm-yyyy'), ' Julie Brown', 449, to_date('17-07-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 527);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (247, 'released', ' 809 Tiffany Lodge', to_date('24-07-1951', 'dd-mm-yyyy'), ' Shelby Carter', 671, to_date('26-03-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 541);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (248, 'released', ' 6796 Hoover Meadow', to_date('21-02-1982', 'dd-mm-yyyy'), ' Kathryn Simon', 961, to_date('15-04-2024', 'dd-mm-yyyy'), to_date('24-11-2023', 'dd-mm-yyyy'), 533);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (249, 'released', ' 941 Jessica Rest', to_date('18-03-1947', 'dd-mm-yyyy'), ' Ryan Martinez Jr.', 847, to_date('16-08-2023', 'dd-mm-yyyy'), to_date('24-09-2023', 'dd-mm-yyyy'), 559);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (250, 'released', ' 38684 Patel Shoals', to_date('27-09-1956', 'dd-mm-yyyy'), ' Austin Gates', 896, to_date('16-03-2024', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 519);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (200, 'released', ' 1421 Catherine Vall', to_date('28-08-1944', 'dd-mm-yyyy'), ' Jessica Anthony', 487, to_date('23-02-2024', 'dd-mm-yyyy'), to_date('05-12-2023', 'dd-mm-yyyy'), 565);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (201, 'released', ' 8839 Timothy Viaduc', to_date('18-11-1989', 'dd-mm-yyyy'), ' Mary Smith', 392, to_date('01-06-2023', 'dd-mm-yyyy'), to_date('29-10-2023', 'dd-mm-yyyy'), 528);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (202, 'released', ' 514 Rich Glens Suit', to_date('01-08-1974', 'dd-mm-yyyy'), ' Robert Matthews Jr.', 530, to_date('04-09-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 539);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (203, 'released', ' 614 Nicole Branch', to_date('21-12-1984', 'dd-mm-yyyy'), ' Catherine Fletcher', 171, to_date('15-12-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 539);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (204, 'released', ' 6184 Moore Mews Apt', to_date('30-11-2008', 'dd-mm-yyyy'), ' Catherine King', 687, to_date('23-03-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 538);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (205, 'released', ' 3678 Michael Mounta', to_date('26-03-1999', 'dd-mm-yyyy'), ' Jaclyn Gonzales', 320, to_date('01-02-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 518);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (207, 'released', ' 5054 Kyle Ville', to_date('25-05-2014', 'dd-mm-yyyy'), ' Laura Church', 675, to_date('14-07-2023', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 532);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (208, 'released', ' 4445 Webb Heights A', to_date('11-06-1970', 'dd-mm-yyyy'), ' Alexander Mathews', 243, to_date('17-12-2023', 'dd-mm-yyyy'), to_date('04-01-2024', 'dd-mm-yyyy'), 537);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (210, 'released', ' 90894 Nicole Shore ', to_date('30-06-1990', 'dd-mm-yyyy'), ' William Gill', 451, to_date('24-05-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 525);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (211, 'released', ' 887 Kennedy Square ', to_date('26-07-1991', 'dd-mm-yyyy'), ' Crystal Hodge', 665, to_date('21-06-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 560);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (213, 'released', ' 0351 Gordon Harbor ', to_date('02-08-1980', 'dd-mm-yyyy'), ' Joseph Porter', 145, to_date('29-05-2024', 'dd-mm-yyyy'), to_date('03-01-2024', 'dd-mm-yyyy'), 562);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (214, 'released', ' 3338 Cynthia Road', to_date('15-10-1947', 'dd-mm-yyyy'), ' Dean Conner', 761, to_date('16-01-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 538);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (215, 'released', ' 5890 Russell Drive ', to_date('14-02-1963', 'dd-mm-yyyy'), ' Brett Weiss', 259, to_date('20-01-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 522);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (216, 'released', ' 206 Romero Isle', to_date('14-04-1985', 'dd-mm-yyyy'), ' Brooke Pennington', 932, to_date('06-07-2023', 'dd-mm-yyyy'), to_date('08-05-2024', 'dd-mm-yyyy'), 532);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (217, 'released', ' 072 Norman Springs', to_date('26-05-2006', 'dd-mm-yyyy'), ' Mrs. Katie Wheeler', 480, to_date('14-01-2024', 'dd-mm-yyyy'), to_date('23-07-2023', 'dd-mm-yyyy'), 563);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (218, 'released', ' 90270 Ford Crest', to_date('14-05-2005', 'dd-mm-yyyy'), ' Troy Kim', 534, to_date('01-02-2024', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 558);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (219, 'released', ' 79545 Miles Springs', to_date('21-10-1957', 'dd-mm-yyyy'), ' Donna Johnson', 994, to_date('16-02-2024', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 544);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (220, 'released', ' 07444 Jones River', to_date('31-05-2005', 'dd-mm-yyyy'), ' James Wheeler', 637, to_date('21-02-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 566);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (221, 'released', ' 8700 Chelsea Pines ', to_date('30-09-1954', 'dd-mm-yyyy'), ' Erica Haney', 822, to_date('20-09-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 560);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (222, 'released', ' 76692 Garcia Prairi', to_date('21-11-2013', 'dd-mm-yyyy'), ' Tara Huber', 555, to_date('28-12-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 555);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (223, 'released', ' 8823 Graves Ville S', to_date('26-07-1998', 'dd-mm-yyyy'), ' Jennifer Barnes', 985, to_date('01-07-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 523);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (224, 'released', ' 7804 Spencer Mills ', to_date('30-09-1975', 'dd-mm-yyyy'), ' Jeffrey Rivera', 531, to_date('14-12-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 522);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (225, 'released', ' 1694 Amanda Pike', to_date('22-11-1982', 'dd-mm-yyyy'), ' Jay Ellison', 804, to_date('07-09-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 548);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (226, 'released', ' 37727 Shannon Roads', to_date('23-12-1946', 'dd-mm-yyyy'), ' Jordan Black', 538, to_date('01-04-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 553);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (227, 'released', ' 948 Smith Roads', to_date('23-01-1983', 'dd-mm-yyyy'), ' Courtney Martin', 813, to_date('28-04-2024', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 566);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (228, 'released', ' 46485 Bowers Island', to_date('07-09-1974', 'dd-mm-yyyy'), ' Curtis Anderson', 462, to_date('13-08-2023', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 556);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (229, 'released', ' 4028 Jason Shore Su', to_date('06-03-1975', 'dd-mm-yyyy'), ' Jennifer Jones', 639, to_date('06-06-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 551);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (231, 'released', ' 792 Scott Cape Suit', to_date('16-07-2005', 'dd-mm-yyyy'), ' Shannon Hancock', 956, to_date('15-01-2024', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 556);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (232, 'released', ' 810 Myers Mill', to_date('06-09-1984', 'dd-mm-yyyy'), ' Jillian Russell', 752, to_date('13-07-2023', 'dd-mm-yyyy'), to_date('01-01-2099', 'dd-mm-yyyy'), 531);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (233, 'released', ' 973 Kayla Pass', to_date('09-01-1970', 'dd-mm-yyyy'), ' Ashley Hansen', 227, to_date('30-10-2023', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 525);
insert into PATIENT (p_id, status, address, date_of_birth, p_name, p_phone, date_of_hospitalization, date_of_release, ship_id)
values (234, 'released', ' 61591 William Estat', to_date('12-08-1969', 'dd-mm-yyyy'), ' Carl Beasley', 556, to_date('20-05-2024', 'dd-mm-yyyy'), to_date('02-04-2024', 'dd-mm-yyyy'), 563);
commit;
prompt 46 records loaded
prompt Loading VISIT...
insert into VISIT (v_id, date_of_visit, p_id)
values (131, to_date('01-01-2020', 'dd-mm-yyyy'), 250);
insert into VISIT (v_id, date_of_visit, p_id)
values (132, to_date('02-01-2020', 'dd-mm-yyyy'), 232);
insert into VISIT (v_id, date_of_visit, p_id)
values (133, to_date('02-01-2020', 'dd-mm-yyyy'), 245);
insert into VISIT (v_id, date_of_visit, p_id)
values (134, to_date('01-01-2020', 'dd-mm-yyyy'), 242);
insert into VISIT (v_id, date_of_visit, p_id)
values (100, to_date('26-07-2001', 'dd-mm-yyyy'), 221);
insert into VISIT (v_id, date_of_visit, p_id)
values (101, to_date('02-04-2016', 'dd-mm-yyyy'), 221);
insert into VISIT (v_id, date_of_visit, p_id)
values (102, to_date('21-02-2004', 'dd-mm-yyyy'), 213);
insert into VISIT (v_id, date_of_visit, p_id)
values (103, to_date('15-08-2002', 'dd-mm-yyyy'), 202);
insert into VISIT (v_id, date_of_visit, p_id)
values (104, to_date('12-09-2019', 'dd-mm-yyyy'), 235);
insert into VISIT (v_id, date_of_visit, p_id)
values (105, to_date('12-03-2011', 'dd-mm-yyyy'), 217);
insert into VISIT (v_id, date_of_visit, p_id)
values (106, to_date('16-02-2001', 'dd-mm-yyyy'), 200);
insert into VISIT (v_id, date_of_visit, p_id)
values (107, to_date('27-01-2001', 'dd-mm-yyyy'), 250);
insert into VISIT (v_id, date_of_visit, p_id)
values (108, to_date('20-05-2021', 'dd-mm-yyyy'), 204);
insert into VISIT (v_id, date_of_visit, p_id)
values (109, to_date('14-07-2009', 'dd-mm-yyyy'), 215);
insert into VISIT (v_id, date_of_visit, p_id)
values (110, to_date('21-05-2006', 'dd-mm-yyyy'), 235);
insert into VISIT (v_id, date_of_visit, p_id)
values (111, to_date('01-03-1998', 'dd-mm-yyyy'), 227);
insert into VISIT (v_id, date_of_visit, p_id)
values (112, to_date('08-05-1998', 'dd-mm-yyyy'), 244);
insert into VISIT (v_id, date_of_visit, p_id)
values (113, to_date('17-09-2005', 'dd-mm-yyyy'), 241);
insert into VISIT (v_id, date_of_visit, p_id)
values (114, to_date('19-07-1994', 'dd-mm-yyyy'), 247);
insert into VISIT (v_id, date_of_visit, p_id)
values (115, to_date('18-09-2022', 'dd-mm-yyyy'), 232);
insert into VISIT (v_id, date_of_visit, p_id)
values (116, to_date('28-10-2004', 'dd-mm-yyyy'), 227);
insert into VISIT (v_id, date_of_visit, p_id)
values (117, to_date('04-07-1997', 'dd-mm-yyyy'), 210);
insert into VISIT (v_id, date_of_visit, p_id)
values (118, to_date('08-10-1993', 'dd-mm-yyyy'), 250);
insert into VISIT (v_id, date_of_visit, p_id)
values (119, to_date('22-09-2017', 'dd-mm-yyyy'), 200);
insert into VISIT (v_id, date_of_visit, p_id)
values (120, to_date('20-10-1993', 'dd-mm-yyyy'), 224);
insert into VISIT (v_id, date_of_visit, p_id)
values (121, to_date('15-11-2005', 'dd-mm-yyyy'), 225);
insert into VISIT (v_id, date_of_visit, p_id)
values (122, to_date('10-02-2004', 'dd-mm-yyyy'), 246);
insert into VISIT (v_id, date_of_visit, p_id)
values (123, to_date('19-01-2010', 'dd-mm-yyyy'), 247);
insert into VISIT (v_id, date_of_visit, p_id)
values (124, to_date('20-09-2012', 'dd-mm-yyyy'), 242);
insert into VISIT (v_id, date_of_visit, p_id)
values (125, to_date('12-06-2003', 'dd-mm-yyyy'), 250);
insert into VISIT (v_id, date_of_visit, p_id)
values (126, to_date('20-07-2011', 'dd-mm-yyyy'), 218);
insert into VISIT (v_id, date_of_visit, p_id)
values (127, to_date('06-09-2018', 'dd-mm-yyyy'), 244);
insert into VISIT (v_id, date_of_visit, p_id)
values (128, to_date('24-10-2018', 'dd-mm-yyyy'), 210);
insert into VISIT (v_id, date_of_visit, p_id)
values (129, to_date('13-08-2023', 'dd-mm-yyyy'), 207);
insert into VISIT (v_id, date_of_visit, p_id)
values (130, to_date('02-01-2020', 'dd-mm-yyyy'), 213);
commit;
prompt 35 records loaded
prompt Loading DOCTOR_VISIT...
insert into DOCTOR_VISIT (v_id, cid)
values (100, 602);
insert into DOCTOR_VISIT (v_id, cid)
values (100, 622);
insert into DOCTOR_VISIT (v_id, cid)
values (100, 624);
insert into DOCTOR_VISIT (v_id, cid)
values (100, 637);
insert into DOCTOR_VISIT (v_id, cid)
values (100, 701);
insert into DOCTOR_VISIT (v_id, cid)
values (100, 707);
insert into DOCTOR_VISIT (v_id, cid)
values (100, 741);
insert into DOCTOR_VISIT (v_id, cid)
values (100, 783);
insert into DOCTOR_VISIT (v_id, cid)
values (100, 787);
insert into DOCTOR_VISIT (v_id, cid)
values (101, 626);
insert into DOCTOR_VISIT (v_id, cid)
values (101, 638);
insert into DOCTOR_VISIT (v_id, cid)
values (101, 741);
insert into DOCTOR_VISIT (v_id, cid)
values (101, 765);
insert into DOCTOR_VISIT (v_id, cid)
values (102, 610);
insert into DOCTOR_VISIT (v_id, cid)
values (102, 688);
insert into DOCTOR_VISIT (v_id, cid)
values (102, 691);
insert into DOCTOR_VISIT (v_id, cid)
values (102, 729);
insert into DOCTOR_VISIT (v_id, cid)
values (102, 777);
insert into DOCTOR_VISIT (v_id, cid)
values (103, 639);
insert into DOCTOR_VISIT (v_id, cid)
values (103, 656);
insert into DOCTOR_VISIT (v_id, cid)
values (103, 661);
insert into DOCTOR_VISIT (v_id, cid)
values (103, 678);
insert into DOCTOR_VISIT (v_id, cid)
values (103, 691);
insert into DOCTOR_VISIT (v_id, cid)
values (103, 761);
insert into DOCTOR_VISIT (v_id, cid)
values (103, 775);
insert into DOCTOR_VISIT (v_id, cid)
values (104, 629);
insert into DOCTOR_VISIT (v_id, cid)
values (104, 682);
insert into DOCTOR_VISIT (v_id, cid)
values (104, 710);
insert into DOCTOR_VISIT (v_id, cid)
values (104, 718);
insert into DOCTOR_VISIT (v_id, cid)
values (104, 734);
insert into DOCTOR_VISIT (v_id, cid)
values (104, 739);
insert into DOCTOR_VISIT (v_id, cid)
values (104, 778);
insert into DOCTOR_VISIT (v_id, cid)
values (104, 794);
insert into DOCTOR_VISIT (v_id, cid)
values (105, 643);
insert into DOCTOR_VISIT (v_id, cid)
values (105, 652);
insert into DOCTOR_VISIT (v_id, cid)
values (105, 665);
insert into DOCTOR_VISIT (v_id, cid)
values (105, 669);
insert into DOCTOR_VISIT (v_id, cid)
values (105, 680);
insert into DOCTOR_VISIT (v_id, cid)
values (105, 727);
insert into DOCTOR_VISIT (v_id, cid)
values (106, 626);
insert into DOCTOR_VISIT (v_id, cid)
values (106, 627);
insert into DOCTOR_VISIT (v_id, cid)
values (106, 632);
insert into DOCTOR_VISIT (v_id, cid)
values (106, 716);
insert into DOCTOR_VISIT (v_id, cid)
values (106, 732);
insert into DOCTOR_VISIT (v_id, cid)
values (106, 760);
insert into DOCTOR_VISIT (v_id, cid)
values (107, 640);
insert into DOCTOR_VISIT (v_id, cid)
values (107, 709);
insert into DOCTOR_VISIT (v_id, cid)
values (107, 722);
insert into DOCTOR_VISIT (v_id, cid)
values (107, 724);
insert into DOCTOR_VISIT (v_id, cid)
values (107, 727);
insert into DOCTOR_VISIT (v_id, cid)
values (107, 767);
insert into DOCTOR_VISIT (v_id, cid)
values (108, 637);
insert into DOCTOR_VISIT (v_id, cid)
values (108, 653);
insert into DOCTOR_VISIT (v_id, cid)
values (108, 657);
insert into DOCTOR_VISIT (v_id, cid)
values (108, 671);
insert into DOCTOR_VISIT (v_id, cid)
values (108, 702);
insert into DOCTOR_VISIT (v_id, cid)
values (109, 621);
insert into DOCTOR_VISIT (v_id, cid)
values (109, 690);
insert into DOCTOR_VISIT (v_id, cid)
values (109, 706);
insert into DOCTOR_VISIT (v_id, cid)
values (109, 724);
insert into DOCTOR_VISIT (v_id, cid)
values (109, 758);
insert into DOCTOR_VISIT (v_id, cid)
values (109, 760);
insert into DOCTOR_VISIT (v_id, cid)
values (109, 770);
insert into DOCTOR_VISIT (v_id, cid)
values (109, 775);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 619);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 636);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 662);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 668);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 680);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 722);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 737);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 762);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 765);
insert into DOCTOR_VISIT (v_id, cid)
values (110, 770);
insert into DOCTOR_VISIT (v_id, cid)
values (111, 619);
insert into DOCTOR_VISIT (v_id, cid)
values (111, 695);
insert into DOCTOR_VISIT (v_id, cid)
values (111, 710);
insert into DOCTOR_VISIT (v_id, cid)
values (112, 618);
insert into DOCTOR_VISIT (v_id, cid)
values (112, 664);
insert into DOCTOR_VISIT (v_id, cid)
values (112, 738);
insert into DOCTOR_VISIT (v_id, cid)
values (112, 749);
insert into DOCTOR_VISIT (v_id, cid)
values (112, 780);
insert into DOCTOR_VISIT (v_id, cid)
values (113, 615);
insert into DOCTOR_VISIT (v_id, cid)
values (113, 632);
insert into DOCTOR_VISIT (v_id, cid)
values (113, 650);
insert into DOCTOR_VISIT (v_id, cid)
values (113, 672);
insert into DOCTOR_VISIT (v_id, cid)
values (113, 680);
insert into DOCTOR_VISIT (v_id, cid)
values (113, 759);
insert into DOCTOR_VISIT (v_id, cid)
values (113, 774);
insert into DOCTOR_VISIT (v_id, cid)
values (113, 783);
insert into DOCTOR_VISIT (v_id, cid)
values (113, 788);
insert into DOCTOR_VISIT (v_id, cid)
values (114, 631);
insert into DOCTOR_VISIT (v_id, cid)
values (114, 644);
insert into DOCTOR_VISIT (v_id, cid)
values (114, 657);
insert into DOCTOR_VISIT (v_id, cid)
values (114, 683);
insert into DOCTOR_VISIT (v_id, cid)
values (114, 706);
insert into DOCTOR_VISIT (v_id, cid)
values (114, 728);
insert into DOCTOR_VISIT (v_id, cid)
values (114, 735);
insert into DOCTOR_VISIT (v_id, cid)
values (114, 781);
insert into DOCTOR_VISIT (v_id, cid)
values (114, 787);
commit;
prompt 100 records committed...
insert into DOCTOR_VISIT (v_id, cid)
values (115, 697);
insert into DOCTOR_VISIT (v_id, cid)
values (115, 733);
insert into DOCTOR_VISIT (v_id, cid)
values (115, 743);
insert into DOCTOR_VISIT (v_id, cid)
values (115, 750);
insert into DOCTOR_VISIT (v_id, cid)
values (115, 787);
insert into DOCTOR_VISIT (v_id, cid)
values (115, 788);
insert into DOCTOR_VISIT (v_id, cid)
values (116, 628);
insert into DOCTOR_VISIT (v_id, cid)
values (116, 673);
insert into DOCTOR_VISIT (v_id, cid)
values (116, 676);
insert into DOCTOR_VISIT (v_id, cid)
values (116, 746);
insert into DOCTOR_VISIT (v_id, cid)
values (116, 764);
insert into DOCTOR_VISIT (v_id, cid)
values (117, 731);
insert into DOCTOR_VISIT (v_id, cid)
values (117, 740);
insert into DOCTOR_VISIT (v_id, cid)
values (117, 762);
insert into DOCTOR_VISIT (v_id, cid)
values (118, 632);
insert into DOCTOR_VISIT (v_id, cid)
values (118, 679);
insert into DOCTOR_VISIT (v_id, cid)
values (118, 683);
insert into DOCTOR_VISIT (v_id, cid)
values (118, 713);
insert into DOCTOR_VISIT (v_id, cid)
values (118, 798);
insert into DOCTOR_VISIT (v_id, cid)
values (119, 606);
insert into DOCTOR_VISIT (v_id, cid)
values (119, 637);
insert into DOCTOR_VISIT (v_id, cid)
values (119, 699);
insert into DOCTOR_VISIT (v_id, cid)
values (119, 701);
insert into DOCTOR_VISIT (v_id, cid)
values (119, 711);
insert into DOCTOR_VISIT (v_id, cid)
values (119, 713);
insert into DOCTOR_VISIT (v_id, cid)
values (119, 782);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 605);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 626);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 650);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 654);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 659);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 668);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 679);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 701);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 745);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 775);
insert into DOCTOR_VISIT (v_id, cid)
values (120, 781);
insert into DOCTOR_VISIT (v_id, cid)
values (121, 664);
insert into DOCTOR_VISIT (v_id, cid)
values (121, 687);
insert into DOCTOR_VISIT (v_id, cid)
values (121, 697);
insert into DOCTOR_VISIT (v_id, cid)
values (121, 706);
insert into DOCTOR_VISIT (v_id, cid)
values (121, 729);
insert into DOCTOR_VISIT (v_id, cid)
values (121, 751);
insert into DOCTOR_VISIT (v_id, cid)
values (121, 788);
insert into DOCTOR_VISIT (v_id, cid)
values (122, 611);
insert into DOCTOR_VISIT (v_id, cid)
values (122, 632);
insert into DOCTOR_VISIT (v_id, cid)
values (122, 642);
insert into DOCTOR_VISIT (v_id, cid)
values (122, 668);
insert into DOCTOR_VISIT (v_id, cid)
values (122, 725);
insert into DOCTOR_VISIT (v_id, cid)
values (122, 763);
insert into DOCTOR_VISIT (v_id, cid)
values (122, 776);
insert into DOCTOR_VISIT (v_id, cid)
values (122, 782);
insert into DOCTOR_VISIT (v_id, cid)
values (123, 606);
insert into DOCTOR_VISIT (v_id, cid)
values (123, 641);
insert into DOCTOR_VISIT (v_id, cid)
values (123, 713);
insert into DOCTOR_VISIT (v_id, cid)
values (123, 716);
insert into DOCTOR_VISIT (v_id, cid)
values (123, 775);
insert into DOCTOR_VISIT (v_id, cid)
values (123, 785);
insert into DOCTOR_VISIT (v_id, cid)
values (124, 616);
insert into DOCTOR_VISIT (v_id, cid)
values (124, 623);
insert into DOCTOR_VISIT (v_id, cid)
values (124, 641);
insert into DOCTOR_VISIT (v_id, cid)
values (124, 700);
insert into DOCTOR_VISIT (v_id, cid)
values (124, 738);
insert into DOCTOR_VISIT (v_id, cid)
values (124, 743);
insert into DOCTOR_VISIT (v_id, cid)
values (124, 749);
insert into DOCTOR_VISIT (v_id, cid)
values (125, 602);
insert into DOCTOR_VISIT (v_id, cid)
values (125, 624);
insert into DOCTOR_VISIT (v_id, cid)
values (125, 711);
insert into DOCTOR_VISIT (v_id, cid)
values (125, 725);
insert into DOCTOR_VISIT (v_id, cid)
values (125, 776);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 602);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 604);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 652);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 710);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 715);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 729);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 734);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 746);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 750);
insert into DOCTOR_VISIT (v_id, cid)
values (126, 758);
insert into DOCTOR_VISIT (v_id, cid)
values (127, 619);
insert into DOCTOR_VISIT (v_id, cid)
values (127, 622);
insert into DOCTOR_VISIT (v_id, cid)
values (127, 687);
insert into DOCTOR_VISIT (v_id, cid)
values (127, 690);
insert into DOCTOR_VISIT (v_id, cid)
values (128, 614);
insert into DOCTOR_VISIT (v_id, cid)
values (128, 620);
insert into DOCTOR_VISIT (v_id, cid)
values (128, 636);
insert into DOCTOR_VISIT (v_id, cid)
values (128, 643);
insert into DOCTOR_VISIT (v_id, cid)
values (128, 644);
insert into DOCTOR_VISIT (v_id, cid)
values (128, 653);
insert into DOCTOR_VISIT (v_id, cid)
values (129, 657);
insert into DOCTOR_VISIT (v_id, cid)
values (129, 720);
insert into DOCTOR_VISIT (v_id, cid)
values (129, 723);
insert into DOCTOR_VISIT (v_id, cid)
values (129, 736);
commit;
prompt 194 records loaded
prompt Loading EMPLOYEES...
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (1, 'Liev Austin', 148348, '0565566875');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (3, 'Miki Nugent', 489873, '0520722617');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (5, 'Rawlins Rankin', 64665, '0525126295');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (6, 'Jamie Chan', 507884, '0512532198');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (7, 'Micky Hudson', 103706, '0591158069');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (9, 'Aidan Chaplin', 121201, '0564160555');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (10, 'Orlando Goldblu', 648397, '0570264125');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (11, 'Eileen Savage', 187434, '0565336056');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (13, 'Rosanna Hobson', 240003, '0529406060');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (14, 'Buffy Quinones', 974573, '0527853290');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (18, 'Junior Cumming', 867686, '0557556247');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (19, 'Scott MacDonald', 939429, '0542467990');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (22, 'Lenny Sedaka', 300446, '0560572782');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (25, 'Stellan Farrell', 509350, '0520911414');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (28, 'Johnny Lapointe', 115084, '0599519904');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (30, 'Carolyn Scorses', 442088, '0533855225');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (31, 'Reese Flemyng', 801720, '0502012070');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (33, 'Miriam Owen', 606533, '0573509310');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (34, 'Balthazar Dukak', 631284, '0583499559');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (35, 'Carole Lorenz', 723529, '0573905984');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (38, 'Debbie Maxwell', 29154, '0556675465');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (39, 'Dar Sizemore', 583771, '0522137604');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (41, 'Bruce Murphy', 446983, '0559218511');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (42, 'Wade Emmett', 549460, '0561829787');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (44, 'Eric Stigers', 398308, '0586261889');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (45, 'Xander Loeb', 172235, '0519016776');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (47, 'Andrew Braugher', 127722, '0586781266');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (52, 'Jay Foley', 750695, '0584703713');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (53, 'Marina Dillon', 735709, '0558412895');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (54, 'Alan Palmieri', 285350, '0531957767');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (55, 'Campbell Eastwo', 138902, '0579043108');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (56, 'Judge Hanks', 528453, '0543341979');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (57, 'Radney Vinton', 383555, '0513627332');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (58, 'Mae Mollard', 432372, '0545399765');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (59, 'Carol Gosdin', 644496, '0595814539');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (62, 'Judd Cumming', 484038, '0567807352');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (63, 'Sally Forrest', 255896, '0508680983');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (64, 'Meredith Sepulv', 673138, '0541166167');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (65, 'Jude Shandling', 591308, '0555157064');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (66, 'Alfred Levine', 922068, '0525818075');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (67, 'Angie Gracie', 149279, '0565502514');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (69, 'Gerald Thomson', 268599, '0585276530');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (70, 'Tommy Hurley', 939419, '0528355286');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (72, 'Jann Secada', 173820, '0579297240');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (73, 'Sona Moffat', 35855, '0573998853');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (74, 'Chloe Chambers', 354937, '0525638404');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (75, 'Taylor Tah', 634481, '0589270511');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (76, 'Carlos Grant', 268415, '0578094078');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (77, 'Joy Fonda', 972717, '0511178838');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (78, 'Josh Giamatti', 814851, '0582584525');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (79, 'Candice Rhys-Da', 111711, '0517128751');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (83, 'Lorraine Moraz', 482284, '0535325103');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (84, 'Joely Moreno', 202568, '0517545113');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (85, 'Renee Johansen', 906387, '0586434522');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (87, 'Brian Mitchell', 640653, '0548711827');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (89, 'Curtis Saxon', 698199, '0501345496');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (91, 'Eric Borden', 585604, '0511512907');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (93, 'Shawn Heron', 682486, '0506750595');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (94, 'Geraldine Berry', 602181, '0506072269');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (95, 'Buddy Soul', 845945, '0500084335');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (97, 'Lily Witherspoo', 771559, '0591993761');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (98, 'Denise Tierney', 53723, '0570830646');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (101, 'Sally Heatherly', 492497, '0586612625');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (102, 'Merrill Eder', 691546, '0563291543');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (104, 'Kirsten Baez', 41158, '0519533035');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (105, 'Antonio Hewett', 559607, '0516336912');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (106, 'Dar Peet', 462011, '0576901393');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (108, 'Robby Guzman', 182176, '0596924706');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (110, 'Balthazar Carra', 434929, '0550847077');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (111, 'Nickel Del Toro', 652379, '0572279081');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (112, 'Lou Thewlis', 742289, '0569541164');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (113, 'Ian Biel', 26360, '0551802576');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (114, 'Nelly Zevon', 39346, '0541807435');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (115, 'Illeana Seagal', 444349, '0599011947');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (117, 'Clive Coltrane', 617573, '0569201715');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (119, 'Julianne Crowe', 392438, '0569066432');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (120, 'Humberto Cervin', 769977, '0532200015');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (121, 'Busta Conlee', 11001, '0525198123');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (122, 'Manu Faithfull', 640454, '0502619123');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (123, 'Percy Sharp', 318882, '0585855923');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (124, 'Dylan Lewin', 643624, '0540550300');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (125, 'Whoopi Curtis', 295449, '0500976824');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (126, 'Kurt Paul', 899073, '0527604676');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (127, 'Pat Fichtner', 574476, '0563275329');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (130, 'Leonardo Singh', 760939, '0533804297');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (131, 'Nikki Shand', 36976, '0530512030');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (134, 'Andie Mahood', 188074, '0551802397');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (135, 'Alicia Amos', 432273, '0583572000');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (136, 'LeVar Schreiber', 147985, '0517837923');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (139, 'Sander Hatfield', 697761, '0583609439');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (140, 'Veruca Chambers', 943597, '0574698810');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (141, 'Delroy McGriff', 338059, '0565951282');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (144, 'Rowan Olin', 867118, '0520534932');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (145, 'Bernie Lindo', 976446, '0586066122');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (146, 'Jay Kristoffers', 672091, '0595446587');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (149, 'Dave Burton', 485471, '0572831940');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (155, 'Daryle Rickman', 857599, '0574389686');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (157, 'Peter Tambor', 643066, '0550628848');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (159, 'CeCe Grant', 82084, '0588111252');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (160, 'Sydney Johansso', 682812, '0577663887');
commit;
prompt 100 records committed...
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (161, 'Russell Cheadle', 226333, '0560731439');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (162, 'Corey Harrison', 986326, '0572869887');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (163, 'Kazem Tilly', 956717, '0563968692');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (164, 'Jonny Lee Malon', 974385, '0501621564');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (165, 'Kevin Keen', 979402, '0551676108');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (167, 'Buffy Warden', 761187, '0555954509');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (169, 'Alannah Tilly', 437697, '0527221843');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (171, 'Rosanne Seagal', 876762, '0551706544');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (173, 'Edgar Day', 767509, '0588620443');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (174, 'Christopher Str', 219933, '0519577543');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (175, 'Ralph Bonham', 331145, '0554951799');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (176, 'Reese Elizondo', 737940, '0511419004');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (177, 'Rita Hutch', 147483, '0588017506');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (178, 'Leonardo Bush', 744536, '0542380129');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (183, 'Tal Newton', 957738, '0586067704');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (184, 'Victoria Weston', 475100, '0537035062');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (185, 'Lindsay Skerrit', 179748, '0500358582');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (186, 'Christian Vanne', 918126, '0592443227');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (188, 'Katrin Byrne', 215318, '0501727976');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (189, 'Tobey Weiss', 425493, '0563126762');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (190, 'Mike Gibson', 207203, '0531337455');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (191, 'Winona Berkeley', 649347, '0548043670');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (193, 'Carlene Vega', 666924, '0501482908');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (194, 'Merillee Dillon', 873419, '0587122954');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (196, 'Ike Lindo', 960412, '0596427825');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (197, 'Fiona Gayle', 8538, '0521700599');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (198, 'Gladys Puckett', 291850, '0524265126');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (199, 'Lili Ali', 88007, '0513464101');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (200, 'Elias Popper', 89395, '0542279563');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (201, 'Ossie Lang', 466410, '0568955894');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (202, 'Dave Carlton', 118005, '0576922785');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (204, 'Javon DeGraw', 873419, '0564921777');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (205, 'Chrissie Ricci', 799385, '0527061751');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (209, 'Elle Tempest', 136115, '0548561932');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (213, 'Avril Ifans', 237268, '0557744641');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (214, 'Cesar McCann', 552555, '0581848872');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (215, 'Lara Squier', 781277, '0500578237');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (216, 'Stewart Burke', 479003, '0562500369');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (219, 'Blair Garofalo', 365593, '0545859159');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (220, 'Nicholas LuPone', 7716, '0525912538');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (221, 'Jesus Nakai', 855992, '0506045658');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (222, 'Meryl Vai', 188416, '0532601338');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (223, 'Donal Rockwell', 200827, '0588970151');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (224, 'Xander Farrow', 662556, '0566592252');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (225, 'Swoosie Fiennes', 638130, '0529638543');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (226, 'Rachael Rock', 768672, '0555526301');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (227, 'William Plummer', 77975, '0503635235');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (228, 'Sheryl Choice', 310079, '0584821899');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (229, 'Colin Flanery', 428563, '0547626068');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (230, 'Keith Winger', 971535, '0571965461');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (232, 'Shelby Ratzenbe', 622743, '0558429952');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (234, 'Kyra Russell', 470763, '0583212683');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (235, 'Cyndi DiBiasio', 281832, '0570743496');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (236, 'Dorry Gleeson', 291816, '0524523125');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (237, 'Chi Askew', 655756, '0561600097');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (238, 'Tara Glenn', 379702, '0549838355');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (240, 'Jackson Mathis', 865345, '0504417555');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (242, 'Arnold LaSalle', 391417, '0582758841');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (243, 'Mike Feuerstein', 135182, '0541173134');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (244, 'Tobey Davies', 126917, '0581426732');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (245, 'Tcheky Diaz', 432623, '0521914987');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (246, 'Carla Kenoly', 606510, '0561692829');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (248, 'Belinda Gilliam', 128689, '0590582753');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (250, 'Larry Wells', 321997, '0539751964');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (251, 'Whoopi Playboys', 315577, '0549254374');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (252, 'Pat Li', 299940, '0566290868');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (253, 'Graham Skaggs', 665935, '0593441050');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (256, 'Brittany Molina', 240109, '0535972737');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (257, 'Ned Lightfoot', 637133, '0532445218');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (258, 'Nils von Sydow', 222462, '0578072101');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (259, 'Robby Giraldo', 79693, '0546990146');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (260, 'Karen Reeve', 120068, '0522276152');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (261, 'Lois Baker', 662564, '0587927795');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (263, 'Miles Gleeson', 451838, '0594636671');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (264, 'Donna Brock', 795105, '0563167498');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (266, 'Ray Arden', 660374, '0502531537');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (267, 'Mark Mars', 379344, '0504415762');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (268, 'Lily Shatner', 58859, '0540153182');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (269, 'Maureen Lynch', 74798, '0546838970');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (270, 'Geena Dreyfuss', 292632, '0517517188');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (271, 'Bebe Evans', 121680, '0549732173');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (272, 'Miki Ford', 642183, '0590215065');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (278, 'Anne Reeves', 952232, '0566278313');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (279, 'Joshua Gosdin', 586326, '0538811703');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (280, 'Carlos Todd', 179383, '0513952415');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (281, 'Stockard Gellar', 591672, '0590904170');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (282, 'Ned Sawa', 289231, '0561820132');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (284, 'Alice Del Toro', 620831, '0509433099');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (285, 'Sigourney Crosb', 100805, '0549145259');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (286, 'Debby Swank', 381370, '0579801966');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (287, 'Bobbi Elliott', 145615, '0586289017');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (288, 'Miles Imbruglia', 466500, '0514218585');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (290, 'Adrien Harris', 986087, '0515300662');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (291, 'Marley Balin', 727493, '0579770820');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (293, 'Kyra Hatosy', 148238, '0512195523');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (294, 'Owen Tisdale', 169630, '0546351963');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (295, 'Domingo Molina', 701795, '0545559093');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (296, 'Howie Rispoli', 151981, '0575632329');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (297, 'Bernie Kleinenb', 540010, '0542947807');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (299, 'Leon Winstone', 306525, '0530347487');
commit;
prompt 200 records committed...
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (300, 'Ed Day-Lewis', 619538, '0544799296');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (301, 'Brooke Lucas', 308799, '0538930903');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (303, 'Celia Cherry', 417268, '0580383180');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (304, 'Parker Akins', 204526, '0577596606');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (306, 'Leon Baranski', 378004, '0589085314');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (307, 'Lucy Carmen', 182672, '0550778116');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (308, 'April Lattimore', 177091, '0562404479');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (309, 'Geoffrey Palin', 859455, '0506520307');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (312, 'Simon Bacharach', 465359, '0573501995');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (313, 'Chazz Cantrell', 443629, '0513380719');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (314, 'Eric Balin', 156426, '0590654115');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (316, 'Jared Calle', 833026, '0581307830');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (317, 'Freddy Bachman', 920192, '0575989160');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (319, 'Stevie Hutch', 586970, '0581358224');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (321, 'Jann Hauser', 537560, '0585412094');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (323, 'Emma Peet', 650311, '0591468966');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (324, 'Leonardo Shelto', 653216, '0590558909');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (325, 'Patrick Howard', 336892, '0539870382');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (327, 'Bret Adams', 373550, '0548016552');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (328, 'Joseph Reubens', 314917, '0592305348');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (330, 'Humberto Prinze', 718446, '0518109419');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (331, 'Lili Skarsgard', 975183, '0597142424');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (333, 'Derrick Wagner', 128153, '0592023924');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (335, 'Alex Raitt', 719671, '0534086175');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (336, 'Clive Kidman', 256870, '0513775845');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (337, 'Crispin LaMond', 56554, '0515673305');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (338, 'Morgan Dupree', 637037, '0527207064');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (339, 'Kimberly Gaines', 365408, '0521521760');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (340, 'Graham Detmer', 922324, '0535281310');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (341, 'Rhys Wahlberg', 497044, '0554301064');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (343, 'Marty Purefoy', 12914, '0590047899');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (344, 'Gilberto Winger', 898935, '0519594706');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (345, 'Goran Buffalo', 623832, '0581558703');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (346, 'Darius DeLuise', 344182, '0562999923');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (347, 'Sydney Furay', 43648, '0526405941');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (348, 'Ed Ticotin', 123961, '0501870261');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (349, 'Clint Harary', 403797, '0594512116');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (350, 'Rip Cook', 769338, '0576487851');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (352, 'Lloyd Ferrell', 111229, '0525069996');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (353, 'Hank Goodall', 262648, '0566459749');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (356, 'Allan Quinn', 713220, '0500104892');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (357, 'Kenneth Holmes', 697440, '0546270636');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (358, 'Peabo Diddley', 541373, '0579002020');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (359, 'Maggie Benet', 423787, '0535814045');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (360, 'Shelby Blaine', 985506, '0593377896');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (361, 'Gilbert Hauser', 914472, '0513588773');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (362, 'Avril Sewell', 928604, '0596821326');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (363, 'Dar McCoy', 690360, '0505811382');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (367, 'Brenda Morrison', 85131, '0579640683');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (368, 'Denzel Balin', 83256, '0573711452');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (369, 'Juice Krieger', 921900, '0500354965');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (370, 'Neil Stills', 354062, '0567353789');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (371, 'Jeanne Lowe', 308944, '0596244733');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (372, 'Rod Rea', 867849, '0587376075');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (373, 'Orlando Zevon', 46839, '0548594705');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (374, 'Geoffrey Holema', 465193, '0559748409');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (375, 'Holland Hayek', 139941, '0593508170');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (376, 'Ralph Arkin', 471477, '0563284769');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (377, 'Leslie Crewson', 813877, '0589559651');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (378, 'Clea Bonham', 976520, '0543668021');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (379, 'Marina Connelly', 438625, '0576635944');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (380, 'First Madsen', 7867, '0552637858');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (381, 'Bill Whitman', 342430, '0567732521');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (382, 'Bradley Henriks', 568964, '0597260176');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (385, 'Gran Sarsgaard', 661858, '0514388461');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (387, 'Claire Griffin', 282420, '0583166847');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (388, 'Olympia Hutton', 906237, '0568437764');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (389, 'Rutger Sirtis', 714408, '0537912753');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (390, 'Rory Gill', 889139, '0568319687');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (392, 'Chazz Renfro', 944387, '0584201086');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (393, 'Elisabeth Cara', 994912, '0558806168');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (394, 'Colleen Potter', 660014, '0586633914');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (396, 'Embeth McCoy', 446239, '0599753271');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (398, 'Fiona Candy', 495909, '0531256758');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (399, 'Andrea Ratzenbe', 207876, '0529924454');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (400, 'Sam Malone', 544273, '0593612396');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (401, 'Suzanne Mitra', 280751, '0557025684');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (402, 'Al Womack', 741852, '0506576835');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (404, 'Lionel Ammons', 587430, '0593902264');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (405, 'Morris Collette', 249919, '0597503321');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (407, 'Bill Lemmon', 720510, '0512986585');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (408, 'Liquid James', 250399, '0554499898');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (409, 'Oded Reynolds', 960714, '0576604649');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (411, 'Lorraine Keaton', 816622, '0535091333');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (412, 'Randy Franks', 328771, '0556784727');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (413, 'Rene Devine', 45010, '0593944089');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (414, 'Percy Moffat', 362101, '0516583555');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (415, 'Pamela Marsden', 531836, '0561522409');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (416, 'Morris Levy', 862078, '0525107106');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (417, 'Stellan Robinso', 62672, '0542724649');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (418, 'Aidan Sandler', 326184, '0566980246');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (419, 'Mos Bloch', 699254, '0536442681');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (420, 'Armin Beckinsal', 471431, '0595582317');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (421, 'Fred Green', 886929, '0520161169');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (422, 'Lindsay Black', 503390, '0563747659');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (423, 'Vivica Michaels', 194868, '0590520259');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (424, 'Burton Skarsgar', 49245, '0593843851');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (425, 'Vickie Pastore', 355881, '0504685826');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (426, 'Warren McFadden', 341080, '0509573653');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (427, 'Nigel Snider', 423604, '0562077460');
commit;
prompt 300 records committed...
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (428, 'Janeane Mortens', 202293, '0589426097');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (430, 'Tara Abraham', 573035, '0549452339');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (431, 'Petula Foxx', 425116, '0503987708');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (432, 'Micky Hawkins', 81056, '0506679537');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (434, 'Gilberto Griffi', 219104, '0561289314');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (435, 'Ellen Witt', 784237, '0598284737');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (436, 'Red Sarsgaard', 483133, '0587672338');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (437, 'Rupert Winstone', 863973, '0553939535');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (438, 'Thin Santana', 20791, '0549726810');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (440, 'Irene Malkovich', 382160, '0580037445');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (441, 'Millie Mellenca', 277657, '0507248161');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (442, 'Desmond Derring', 590139, '0580458330');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (443, 'Mili Bergen', 708016, '0527973731');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (444, 'Gin Playboys', 259498, '0508903101');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (445, 'Cornell Gallagh', 334566, '0560183273');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (447, 'Maureen Van Dam', 607289, '0502820851');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (449, 'Robert Duchovny', 554428, '0585033524');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (450, 'Victor Henstrid', 51734, '0566831983');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (451, 'Marley Carnes', 807194, '0532156565');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (452, 'Hank Kline', 474264, '0542276008');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (453, 'Courtney Stanto', 730748, '0546179443');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (454, 'Jimmie Rosselli', 817385, '0505117860');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (455, 'Jay Hanley', 533500, '0590374966');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (457, 'Tracy Green', 591121, '0531090634');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (458, 'Joshua Purefoy', 103626, '0530351944');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (459, 'Ramsey Mortense', 1927, '0537252195');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (460, 'Cliff Hedaya', 900881, '0597673747');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (461, 'Julio Saxon', 683858, '0509280812');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (463, 'Jennifer Vai', 714048, '0575666636');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (464, 'Alfred Holeman', 709289, '0529374548');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (466, 'Pierce Heston', 404439, '0588489446');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (470, 'Dylan Rockwell', 36793, '0579520738');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (471, 'Dar Koyana', 622337, '0542391403');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (473, 'Cary Amos', 241376, '0584002986');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (475, 'Nik Vaughn', 33419, '0566230235');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (478, 'Mira Dillane', 417189, '0544487454');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (479, 'Belinda Winger', 108900, '0522587674');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (480, 'Cevin Alexander', 238132, '0584115150');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (481, 'Hugo Cusack', 995325, '0500131570');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (482, 'Chalee Koteas', 871271, '0563660809');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (484, 'Walter Gyllenha', 809494, '0575653406');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (487, 'Pierce Guilfoyl', 488195, '0551676082');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (488, 'Debi Lee', 512878, '0549821297');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (489, 'Meg Tierney', 562733, '0548608823');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (490, 'Larry McBride', 781902, '0590918859');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (492, 'Chely Belle', 957775, '0559643722');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (494, 'Isaiah Lemmon', 946046, '0580255251');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (495, 'Lena Keith', 692850, '0505129821');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (496, 'Willie Arthur', 27200, '0573690690');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (497, 'Andrew Diggs', 721233, '0567816512');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (499, 'Jody Colin Youn', 130536, '0525953192');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (500, 'Rebeka Rosas', 553639, '0544764377');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (501, 'noa', 99999, '0525501770');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (504, 'hod', 98897, '0527601770');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (505, 'rivka', 1297, '0523241770');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (506, 'bat sheva', 897, '0512301770');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (507, 'moriya', 6547, '0534501770');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (508, 'hila', 9891, '0523401770');
insert into EMPLOYEES (eid, ename, salary, ephonenumber)
values (509, 'shaar', 991241, '0527655770');
commit;
prompt 359 records loaded
prompt Loading ORDERS...
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-01-2020', 'dd-mm-yyyy'), 1, 'cash', 329, 193);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-11-2021', 'dd-mm-yyyy'), 2, 'credit card', 302, 132);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-03-2020', 'dd-mm-yyyy'), 3, 'bit', 332, 217);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-07-2020', 'dd-mm-yyyy'), 4, 'paybox', 309, 397);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-10-2021', 'dd-mm-yyyy'), 5, 'credit card', 116, 158);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-11-2020', 'dd-mm-yyyy'), 6, 'paybox', 259, 133);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-05-2021', 'dd-mm-yyyy'), 7, 'cash', 24, 316);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-05-2020', 'dd-mm-yyyy'), 8, 'credit card', 40, 390);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-09-2021', 'dd-mm-yyyy'), 9, 'paybox', 392, 230);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-05-2021', 'dd-mm-yyyy'), 10, 'bit', 2, 298);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-02-2021', 'dd-mm-yyyy'), 11, 'cash', 159, 245);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-08-2021', 'dd-mm-yyyy'), 12, 'cash', 185, 224);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-04-2020', 'dd-mm-yyyy'), 13, 'paybox', 358, 459);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-08-2021', 'dd-mm-yyyy'), 14, 'cash', 326, 292);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-05-2020', 'dd-mm-yyyy'), 15, 'paybox', 391, 75);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-10-2021', 'dd-mm-yyyy'), 16, 'paybox', 143, 320);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-05-2020', 'dd-mm-yyyy'), 17, 'bit', 77, 201);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-11-2021', 'dd-mm-yyyy'), 18, 'bit', 409, 177);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-11-2021', 'dd-mm-yyyy'), 19, 'cash', 494, 489);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-05-2020', 'dd-mm-yyyy'), 20, 'paybox', 300, 30);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-12-2021', 'dd-mm-yyyy'), 21, 'bit', 90, 229);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-06-2020', 'dd-mm-yyyy'), 22, 'paybox', 26, 8);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-06-2020', 'dd-mm-yyyy'), 23, 'paybox', 83, 354);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('08-03-2021', 'dd-mm-yyyy'), 24, 'credit card', 248, 261);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-06-2021', 'dd-mm-yyyy'), 25, 'credit card', 139, 305);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-11-2021', 'dd-mm-yyyy'), 26, 'bit', 268, 430);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-05-2020', 'dd-mm-yyyy'), 27, 'credit card', 332, 351);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-09-2021', 'dd-mm-yyyy'), 28, 'paybox', 8, 29);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-12-2021', 'dd-mm-yyyy'), 29, 'bit', 385, 285);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-04-2020', 'dd-mm-yyyy'), 30, 'paybox', 263, 247);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-07-2021', 'dd-mm-yyyy'), 31, 'credit card', 193, 40);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-05-2021', 'dd-mm-yyyy'), 32, 'cash', 244, 98);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-03-2021', 'dd-mm-yyyy'), 33, 'paybox', 126, 213);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-08-2021', 'dd-mm-yyyy'), 34, 'credit card', 393, 54);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-06-2021', 'dd-mm-yyyy'), 35, 'paybox', 114, 476);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-02-2021', 'dd-mm-yyyy'), 36, 'credit card', 485, 33);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-07-2021', 'dd-mm-yyyy'), 38, 'paybox', 12, 310);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-08-2020', 'dd-mm-yyyy'), 39, 'bit', 258, 269);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-07-2021', 'dd-mm-yyyy'), 40, 'credit card', 342, 326);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-05-2020', 'dd-mm-yyyy'), 41, 'paybox', 279, 77);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-01-2021', 'dd-mm-yyyy'), 42, 'credit card', 167, 423);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-12-2020', 'dd-mm-yyyy'), 43, 'bit', 224, 221);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-07-2020', 'dd-mm-yyyy'), 44, 'cash', 227, 461);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-12-2020', 'dd-mm-yyyy'), 45, 'credit card', 443, 377);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-05-2020', 'dd-mm-yyyy'), 46, 'cash', 316, 358);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-06-2021', 'dd-mm-yyyy'), 47, 'paybox', 262, 388);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-06-2021', 'dd-mm-yyyy'), 48, 'credit card', 72, 27);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-05-2021', 'dd-mm-yyyy'), 49, 'bit', 38, 26);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-03-2021', 'dd-mm-yyyy'), 50, 'paybox', 45, 232);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-12-2021', 'dd-mm-yyyy'), 51, 'cash', 493, 180);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-09-2020', 'dd-mm-yyyy'), 52, 'cash', 48, 320);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-01-2020', 'dd-mm-yyyy'), 53, 'paybox', 330, 416);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-04-2020', 'dd-mm-yyyy'), 54, 'paybox', 290, 402);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-02-2021', 'dd-mm-yyyy'), 55, 'cash', 131, 474);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-07-2021', 'dd-mm-yyyy'), 56, 'credit card', 285, 405);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-12-2020', 'dd-mm-yyyy'), 57, 'credit card', 35, 163);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-02-2021', 'dd-mm-yyyy'), 58, 'paybox', 52, 49);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-05-2020', 'dd-mm-yyyy'), 59, 'paybox', 197, 170);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-06-2020', 'dd-mm-yyyy'), 60, 'cash', 86, 235);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-09-2021', 'dd-mm-yyyy'), 61, 'cash', 34, 246);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-04-2020', 'dd-mm-yyyy'), 62, 'credit card', 119, 302);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-09-2021', 'dd-mm-yyyy'), 63, 'bit', 240, 331);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-08-2020', 'dd-mm-yyyy'), 64, 'bit', 152, 243);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-08-2021', 'dd-mm-yyyy'), 65, 'credit card', 98, 66);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-01-2021', 'dd-mm-yyyy'), 66, 'cash', 283, 292);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-04-2021', 'dd-mm-yyyy'), 67, 'credit card', 57, 234);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-08-2021', 'dd-mm-yyyy'), 68, 'paybox', 297, 427);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-02-2021', 'dd-mm-yyyy'), 69, 'bit', 104, 63);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-02-2021', 'dd-mm-yyyy'), 70, 'bit', 58, 276);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-01-2020', 'dd-mm-yyyy'), 71, 'paybox', 408, 496);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-12-2021', 'dd-mm-yyyy'), 72, 'credit card', 166, 445);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-01-2020', 'dd-mm-yyyy'), 73, 'credit card', 252, 297);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-11-2020', 'dd-mm-yyyy'), 74, 'cash', 403, 218);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-09-2020', 'dd-mm-yyyy'), 75, 'cash', 239, 139);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-04-2020', 'dd-mm-yyyy'), 76, 'credit card', 458, 212);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-05-2021', 'dd-mm-yyyy'), 77, 'bit', 287, 37);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-12-2020', 'dd-mm-yyyy'), 78, 'credit card', 434, 389);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-04-2020', 'dd-mm-yyyy'), 79, 'credit card', 398, 219);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-07-2021', 'dd-mm-yyyy'), 80, 'paybox', 138, 503);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-01-2021', 'dd-mm-yyyy'), 81, 'cash', 215, 384);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-01-2020', 'dd-mm-yyyy'), 82, 'cash', 149, 450);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-09-2021', 'dd-mm-yyyy'), 83, 'paybox', 355, 386);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-01-2021', 'dd-mm-yyyy'), 84, 'bit', 165, 17);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-10-2021', 'dd-mm-yyyy'), 85, 'credit card', 25, 318);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-04-2021', 'dd-mm-yyyy'), 86, 'credit card', 142, 53);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-07-2021', 'dd-mm-yyyy'), 87, 'bit', 420, 494);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-11-2021', 'dd-mm-yyyy'), 88, 'paybox', 201, 13);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-03-2021', 'dd-mm-yyyy'), 89, 'cash', 403, 337);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-07-2021', 'dd-mm-yyyy'), 90, 'cash', 326, 450);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-05-2020', 'dd-mm-yyyy'), 91, 'credit card', 463, 191);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-03-2021', 'dd-mm-yyyy'), 92, 'credit card', 336, 371);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-07-2021', 'dd-mm-yyyy'), 93, 'cash', 456, 19);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-07-2021', 'dd-mm-yyyy'), 94, 'cash', 148, 44);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-12-2021', 'dd-mm-yyyy'), 95, 'bit', 129, 21);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-10-2021', 'dd-mm-yyyy'), 96, 'credit card', 307, 186);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-05-2021', 'dd-mm-yyyy'), 97, 'bit', 425, 143);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-10-2021', 'dd-mm-yyyy'), 98, 'cash', 311, 36);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-10-2021', 'dd-mm-yyyy'), 99, 'credit card', 64, 7);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-05-2020', 'dd-mm-yyyy'), 100, 'paybox', 210, 392);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-11-2021', 'dd-mm-yyyy'), 101, 'credit card', 89, 494);
commit;
prompt 100 records committed...
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-11-2021', 'dd-mm-yyyy'), 102, 'cash', 29, 126);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-12-2020', 'dd-mm-yyyy'), 103, 'cash', 29, 230);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-04-2021', 'dd-mm-yyyy'), 104, 'bit', 463, 87);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-01-2021', 'dd-mm-yyyy'), 105, 'cash', 214, 50);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-07-2021', 'dd-mm-yyyy'), 106, 'bit', 278, 107);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-01-2020', 'dd-mm-yyyy'), 107, 'cash', 439, 347);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-03-2021', 'dd-mm-yyyy'), 108, 'bit', 343, 423);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-04-2020', 'dd-mm-yyyy'), 109, 'bit', 120, 274);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-04-2021', 'dd-mm-yyyy'), 110, 'credit card', 336, 457);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-05-2021', 'dd-mm-yyyy'), 111, 'paybox', 154, 59);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-03-2021', 'dd-mm-yyyy'), 112, 'cash', 252, 391);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-08-2020', 'dd-mm-yyyy'), 113, 'bit', 129, 61);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-02-2020', 'dd-mm-yyyy'), 114, 'paybox', 74, 487);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-06-2020', 'dd-mm-yyyy'), 115, 'credit card', 204, 116);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-10-2021', 'dd-mm-yyyy'), 116, 'credit card', 91, 204);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-04-2020', 'dd-mm-yyyy'), 117, 'bit', 124, 175);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-09-2021', 'dd-mm-yyyy'), 118, 'cash', 382, 104);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('08-09-2020', 'dd-mm-yyyy'), 119, 'paybox', 412, 214);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-09-2020', 'dd-mm-yyyy'), 120, 'credit card', 449, 23);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-10-2020', 'dd-mm-yyyy'), 121, 'cash', 202, 435);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-04-2021', 'dd-mm-yyyy'), 122, 'bit', 10, 32);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-09-2021', 'dd-mm-yyyy'), 123, 'credit card', 237, 226);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-01-2021', 'dd-mm-yyyy'), 124, 'credit card', 449, 181);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-12-2020', 'dd-mm-yyyy'), 125, 'cash', 18, 445);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-09-2021', 'dd-mm-yyyy'), 126, 'paybox', 416, 13);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-07-2021', 'dd-mm-yyyy'), 127, 'bit', 114, 426);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-01-2020', 'dd-mm-yyyy'), 128, 'bit', 93, 389);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-04-2021', 'dd-mm-yyyy'), 129, 'credit card', 126, 320);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-12-2021', 'dd-mm-yyyy'), 130, 'cash', 106, 37);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-03-2021', 'dd-mm-yyyy'), 131, 'credit card', 305, 190);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-01-2021', 'dd-mm-yyyy'), 132, 'bit', 103, 468);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-06-2020', 'dd-mm-yyyy'), 133, 'credit card', 328, 397);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-06-2021', 'dd-mm-yyyy'), 134, 'paybox', 478, 62);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-03-2021', 'dd-mm-yyyy'), 135, 'credit card', 234, 244);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-01-2020', 'dd-mm-yyyy'), 136, 'cash', 265, 61);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-07-2021', 'dd-mm-yyyy'), 137, 'bit', 10, 452);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-07-2020', 'dd-mm-yyyy'), 138, 'credit card', 170, 230);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-05-2021', 'dd-mm-yyyy'), 139, 'cash', 338, 352);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-04-2020', 'dd-mm-yyyy'), 140, 'credit card', 276, 368);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-08-2020', 'dd-mm-yyyy'), 141, 'bit', 493, 422);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-07-2020', 'dd-mm-yyyy'), 142, 'paybox', 396, 78);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-12-2021', 'dd-mm-yyyy'), 143, 'credit card', 407, 47);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-02-2020', 'dd-mm-yyyy'), 144, 'bit', 83, 333);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-11-2020', 'dd-mm-yyyy'), 145, 'paybox', 375, 122);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-08-2020', 'dd-mm-yyyy'), 146, 'credit card', 298, 280);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-06-2021', 'dd-mm-yyyy'), 147, 'cash', 430, 367);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-10-2021', 'dd-mm-yyyy'), 148, 'bit', 232, 391);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-04-2021', 'dd-mm-yyyy'), 149, 'bit', 370, 477);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-10-2021', 'dd-mm-yyyy'), 150, 'paybox', 286, 335);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-02-2021', 'dd-mm-yyyy'), 151, 'paybox', 436, 32);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-10-2021', 'dd-mm-yyyy'), 152, 'bit', 206, 172);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-08-2020', 'dd-mm-yyyy'), 153, 'cash', 157, 208);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-06-2021', 'dd-mm-yyyy'), 154, 'credit card', 379, 309);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-06-2021', 'dd-mm-yyyy'), 155, 'paybox', 341, 215);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-11-2020', 'dd-mm-yyyy'), 156, 'paybox', 274, 232);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-03-2020', 'dd-mm-yyyy'), 157, 'bit', 224, 88);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-08-2021', 'dd-mm-yyyy'), 158, 'paybox', 54, 43);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-08-2020', 'dd-mm-yyyy'), 159, 'paybox', 287, 214);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-01-2021', 'dd-mm-yyyy'), 160, 'paybox', 331, 257);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-01-2020', 'dd-mm-yyyy'), 161, 'bit', 208, 142);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-06-2021', 'dd-mm-yyyy'), 162, 'cash', 86, 383);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-08-2020', 'dd-mm-yyyy'), 163, 'paybox', 492, 200);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-05-2021', 'dd-mm-yyyy'), 164, 'bit', 243, 292);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-02-2021', 'dd-mm-yyyy'), 165, 'cash', 240, 364);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-08-2021', 'dd-mm-yyyy'), 166, 'paybox', 395, 374);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-08-2021', 'dd-mm-yyyy'), 167, 'paybox', 88, 426);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-07-2020', 'dd-mm-yyyy'), 168, 'bit', 192, 455);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-02-2020', 'dd-mm-yyyy'), 169, 'credit card', 291, 439);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-08-2020', 'dd-mm-yyyy'), 170, 'paybox', 385, 6);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-09-2020', 'dd-mm-yyyy'), 171, 'bit', 470, 442);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-04-2021', 'dd-mm-yyyy'), 172, 'bit', 19, 155);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-06-2021', 'dd-mm-yyyy'), 173, 'cash', 13, 466);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-01-2021', 'dd-mm-yyyy'), 174, 'cash', 293, 429);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-11-2021', 'dd-mm-yyyy'), 175, 'bit', 134, 321);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-12-2020', 'dd-mm-yyyy'), 176, 'cash', 66, 324);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-11-2021', 'dd-mm-yyyy'), 177, 'cash', 85, 170);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-03-2020', 'dd-mm-yyyy'), 178, 'cash', 29, 143);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-08-2020', 'dd-mm-yyyy'), 179, 'cash', 26, 378);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-05-2021', 'dd-mm-yyyy'), 180, 'credit card', 23, 110);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-10-2020', 'dd-mm-yyyy'), 181, 'paybox', 54, 132);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-05-2020', 'dd-mm-yyyy'), 182, 'cash', 22, 261);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-04-2020', 'dd-mm-yyyy'), 183, 'cash', 382, 380);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-08-2021', 'dd-mm-yyyy'), 184, 'credit card', 267, 124);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-05-2020', 'dd-mm-yyyy'), 185, 'paybox', 182, 496);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-02-2021', 'dd-mm-yyyy'), 186, 'paybox', 61, 190);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-04-2020', 'dd-mm-yyyy'), 187, 'cash', 75, 272);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-05-2020', 'dd-mm-yyyy'), 188, 'credit card', 212, 138);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-05-2020', 'dd-mm-yyyy'), 189, 'credit card', 287, 179);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-08-2021', 'dd-mm-yyyy'), 190, 'credit card', 143, 374);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-07-2020', 'dd-mm-yyyy'), 191, 'credit card', 454, 397);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-03-2020', 'dd-mm-yyyy'), 192, 'credit card', 148, 315);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-04-2020', 'dd-mm-yyyy'), 193, 'paybox', 89, 123);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-05-2021', 'dd-mm-yyyy'), 194, 'paybox', 312, 496);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-02-2020', 'dd-mm-yyyy'), 195, 'bit', 195, 204);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-11-2021', 'dd-mm-yyyy'), 196, 'bit', 85, 418);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-07-2021', 'dd-mm-yyyy'), 197, 'cash', 51, 486);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-02-2020', 'dd-mm-yyyy'), 198, 'credit card', 8, 206);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-04-2021', 'dd-mm-yyyy'), 199, 'credit card', 136, 489);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-11-2020', 'dd-mm-yyyy'), 200, 'paybox', 101, 36);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-05-2020', 'dd-mm-yyyy'), 201, 'cash', 138, 408);
commit;
prompt 200 records committed...
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-05-2021', 'dd-mm-yyyy'), 202, 'credit card', 378, 131);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-04-2020', 'dd-mm-yyyy'), 203, 'credit card', 212, 180);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-03-2021', 'dd-mm-yyyy'), 204, 'credit card', 475, 99);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-12-2021', 'dd-mm-yyyy'), 205, 'cash', 91, 260);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-08-2020', 'dd-mm-yyyy'), 206, 'bit', 71, 382);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-05-2020', 'dd-mm-yyyy'), 207, 'credit card', 475, 57);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-07-2020', 'dd-mm-yyyy'), 208, 'paybox', 201, 432);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-03-2020', 'dd-mm-yyyy'), 209, 'credit card', 161, 249);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-11-2021', 'dd-mm-yyyy'), 210, 'bit', 11, 288);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-06-2020', 'dd-mm-yyyy'), 211, 'credit card', 259, 69);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-07-2021', 'dd-mm-yyyy'), 212, 'paybox', 162, 96);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-12-2020', 'dd-mm-yyyy'), 213, 'paybox', 481, 323);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-02-2020', 'dd-mm-yyyy'), 214, 'paybox', 265, 296);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-11-2021', 'dd-mm-yyyy'), 215, 'cash', 471, 492);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-08-2020', 'dd-mm-yyyy'), 216, 'paybox', 352, 448);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-07-2020', 'dd-mm-yyyy'), 217, 'paybox', 163, 38);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-04-2020', 'dd-mm-yyyy'), 218, 'credit card', 373, 235);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-06-2021', 'dd-mm-yyyy'), 219, 'cash', 173, 373);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-09-2021', 'dd-mm-yyyy'), 220, 'credit card', 228, 124);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-03-2021', 'dd-mm-yyyy'), 221, 'credit card', 214, 419);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-08-2020', 'dd-mm-yyyy'), 222, 'bit', 325, 162);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-09-2020', 'dd-mm-yyyy'), 223, 'credit card', 54, 404);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-05-2021', 'dd-mm-yyyy'), 224, 'credit card', 177, 440);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-05-2020', 'dd-mm-yyyy'), 225, 'bit', 497, 268);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-02-2021', 'dd-mm-yyyy'), 226, 'credit card', 23, 210);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-08-2020', 'dd-mm-yyyy'), 227, 'credit card', 397, 238);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-06-2021', 'dd-mm-yyyy'), 228, 'bit', 485, 179);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-05-2021', 'dd-mm-yyyy'), 229, 'cash', 205, 49);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-11-2020', 'dd-mm-yyyy'), 230, 'paybox', 253, 425);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-07-2020', 'dd-mm-yyyy'), 231, 'paybox', 47, 349);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-05-2020', 'dd-mm-yyyy'), 232, 'credit card', 305, 486);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-02-2020', 'dd-mm-yyyy'), 233, 'paybox', 329, 210);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-07-2020', 'dd-mm-yyyy'), 234, 'paybox', 153, 110);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-11-2020', 'dd-mm-yyyy'), 235, 'bit', 381, 363);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2021', 'dd-mm-yyyy'), 236, 'paybox', 127, 167);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-06-2020', 'dd-mm-yyyy'), 237, 'cash', 125, 19);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-08-2021', 'dd-mm-yyyy'), 238, 'credit card', 183, 184);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-04-2020', 'dd-mm-yyyy'), 239, 'credit card', 279, 414);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-03-2020', 'dd-mm-yyyy'), 240, 'bit', 246, 72);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-05-2020', 'dd-mm-yyyy'), 241, 'credit card', 86, 435);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-10-2020', 'dd-mm-yyyy'), 242, 'credit card', 89, 504);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-03-2020', 'dd-mm-yyyy'), 243, 'bit', 86, 479);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-01-2021', 'dd-mm-yyyy'), 244, 'paybox', 232, 415);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-07-2021', 'dd-mm-yyyy'), 245, 'bit', 405, 415);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-04-2021', 'dd-mm-yyyy'), 246, 'paybox', 380, 215);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-12-2021', 'dd-mm-yyyy'), 247, 'cash', 88, 223);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-03-2020', 'dd-mm-yyyy'), 248, 'credit card', 395, 111);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-10-2021', 'dd-mm-yyyy'), 249, 'bit', 451, 291);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-07-2021', 'dd-mm-yyyy'), 250, 'cash', 289, 108);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-10-2021', 'dd-mm-yyyy'), 251, 'paybox', 477, 354);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-07-2020', 'dd-mm-yyyy'), 252, 'credit card', 259, 153);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('08-03-2020', 'dd-mm-yyyy'), 253, 'paybox', 232, 100);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-02-2020', 'dd-mm-yyyy'), 254, 'cash', 245, 452);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-02-2021', 'dd-mm-yyyy'), 255, 'credit card', 320, 448);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-05-2020', 'dd-mm-yyyy'), 256, 'paybox', 26, 422);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-09-2021', 'dd-mm-yyyy'), 257, 'credit card', 366, 430);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-07-2020', 'dd-mm-yyyy'), 258, 'bit', 343, 326);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-03-2020', 'dd-mm-yyyy'), 259, 'cash', 29, 302);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-09-2020', 'dd-mm-yyyy'), 260, 'credit card', 50, 38);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-03-2020', 'dd-mm-yyyy'), 261, 'paybox', 50, 250);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-03-2020', 'dd-mm-yyyy'), 262, 'cash', 309, 490);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-06-2020', 'dd-mm-yyyy'), 263, 'bit', 328, 285);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-07-2021', 'dd-mm-yyyy'), 264, 'credit card', 300, 229);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-05-2021', 'dd-mm-yyyy'), 265, 'paybox', 29, 279);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-03-2021', 'dd-mm-yyyy'), 266, 'bit', 474, 203);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-06-2021', 'dd-mm-yyyy'), 267, 'paybox', 225, 169);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-05-2021', 'dd-mm-yyyy'), 268, 'paybox', 333, 135);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-07-2021', 'dd-mm-yyyy'), 269, 'credit card', 64, 312);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-04-2021', 'dd-mm-yyyy'), 270, 'paybox', 238, 89);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-11-2021', 'dd-mm-yyyy'), 271, 'bit', 475, 486);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-06-2021', 'dd-mm-yyyy'), 272, 'cash', 259, 185);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-07-2020', 'dd-mm-yyyy'), 273, 'paybox', 398, 63);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-09-2020', 'dd-mm-yyyy'), 274, 'credit card', 40, 467);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-07-2020', 'dd-mm-yyyy'), 275, 'bit', 54, 350);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-01-2021', 'dd-mm-yyyy'), 276, 'credit card', 214, 424);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-08-2020', 'dd-mm-yyyy'), 277, 'cash', 233, 25);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-01-2021', 'dd-mm-yyyy'), 278, 'cash', 329, 184);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-10-2020', 'dd-mm-yyyy'), 279, 'cash', 127, 327);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-05-2020', 'dd-mm-yyyy'), 280, 'bit', 326, 354);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-03-2021', 'dd-mm-yyyy'), 281, 'cash', 188, 298);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('08-01-2020', 'dd-mm-yyyy'), 282, 'cash', 30, 495);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-12-2021', 'dd-mm-yyyy'), 283, 'credit card', 15, 264);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-01-2021', 'dd-mm-yyyy'), 284, 'credit card', 185, 292);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-01-2020', 'dd-mm-yyyy'), 285, 'cash', 277, 431);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-09-2020', 'dd-mm-yyyy'), 286, 'paybox', 13, 363);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-09-2021', 'dd-mm-yyyy'), 287, 'paybox', 164, 133);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-07-2021', 'dd-mm-yyyy'), 288, 'credit card', 310, 204);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-08-2021', 'dd-mm-yyyy'), 289, 'credit card', 371, 277);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-11-2021', 'dd-mm-yyyy'), 290, 'bit', 65, 336);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-05-2021', 'dd-mm-yyyy'), 291, 'credit card', 113, 384);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-06-2021', 'dd-mm-yyyy'), 292, 'paybox', 120, 50);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-08-2020', 'dd-mm-yyyy'), 293, 'credit card', 172, 338);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-06-2021', 'dd-mm-yyyy'), 294, 'bit', 354, 376);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-06-2020', 'dd-mm-yyyy'), 295, 'bit', 468, 269);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-11-2020', 'dd-mm-yyyy'), 296, 'bit', 401, 130);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-05-2020', 'dd-mm-yyyy'), 297, 'credit card', 177, 92);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-12-2020', 'dd-mm-yyyy'), 298, 'credit card', 400, 201);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-09-2021', 'dd-mm-yyyy'), 299, 'paybox', 363, 210);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-02-2021', 'dd-mm-yyyy'), 300, 'bit', 275, 425);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-09-2021', 'dd-mm-yyyy'), 301, 'cash', 88, 47);
commit;
prompt 300 records committed...
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-07-2020', 'dd-mm-yyyy'), 302, 'bit', 395, 438);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-07-2020', 'dd-mm-yyyy'), 303, 'paybox', 123, 173);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-09-2021', 'dd-mm-yyyy'), 304, 'bit', 229, 96);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-06-2020', 'dd-mm-yyyy'), 305, 'paybox', 44, 428);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-11-2021', 'dd-mm-yyyy'), 306, 'paybox', 203, 288);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-02-2021', 'dd-mm-yyyy'), 307, 'credit card', 187, 294);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-02-2020', 'dd-mm-yyyy'), 308, 'cash', 290, 212);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-07-2021', 'dd-mm-yyyy'), 309, 'credit card', 345, 425);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-12-2020', 'dd-mm-yyyy'), 310, 'paybox', 158, 465);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-08-2020', 'dd-mm-yyyy'), 311, 'bit', 255, 80);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-04-2021', 'dd-mm-yyyy'), 312, 'bit', 141, 375);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-02-2020', 'dd-mm-yyyy'), 313, 'paybox', 399, 156);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-09-2020', 'dd-mm-yyyy'), 314, 'credit card', 119, 413);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-10-2020', 'dd-mm-yyyy'), 315, 'paybox', 205, 192);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-10-2021', 'dd-mm-yyyy'), 316, 'paybox', 303, 96);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-07-2020', 'dd-mm-yyyy'), 317, 'cash', 165, 443);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-09-2021', 'dd-mm-yyyy'), 318, 'paybox', 422, 461);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-04-2021', 'dd-mm-yyyy'), 319, 'credit card', 349, 465);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-10-2021', 'dd-mm-yyyy'), 320, 'credit card', 323, 8);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-02-2021', 'dd-mm-yyyy'), 321, 'cash', 333, 251);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-02-2020', 'dd-mm-yyyy'), 322, 'credit card', 472, 274);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-05-2020', 'dd-mm-yyyy'), 323, 'credit card', 28, 380);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-07-2020', 'dd-mm-yyyy'), 324, 'paybox', 363, 318);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-02-2020', 'dd-mm-yyyy'), 325, 'paybox', 420, 196);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-06-2020', 'dd-mm-yyyy'), 326, 'paybox', 334, 340);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-08-2020', 'dd-mm-yyyy'), 327, 'paybox', 210, 40);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-06-2021', 'dd-mm-yyyy'), 328, 'bit', 292, 271);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-07-2020', 'dd-mm-yyyy'), 329, 'paybox', 365, 494);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-08-2021', 'dd-mm-yyyy'), 330, 'credit card', 333, 422);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-05-2020', 'dd-mm-yyyy'), 331, 'cash', 76, 140);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-10-2021', 'dd-mm-yyyy'), 332, 'paybox', 285, 138);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-07-2021', 'dd-mm-yyyy'), 333, 'paybox', 119, 420);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-07-2021', 'dd-mm-yyyy'), 334, 'credit card', 141, 27);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-10-2020', 'dd-mm-yyyy'), 335, 'cash', 122, 423);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-12-2021', 'dd-mm-yyyy'), 336, 'bit', 413, 174);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-05-2020', 'dd-mm-yyyy'), 337, 'bit', 242, 299);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-03-2021', 'dd-mm-yyyy'), 338, 'cash', 376, 404);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-08-2021', 'dd-mm-yyyy'), 339, 'cash', 246, 150);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-09-2020', 'dd-mm-yyyy'), 340, 'credit card', 237, 83);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-12-2020', 'dd-mm-yyyy'), 341, 'cash', 496, 467);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-10-2021', 'dd-mm-yyyy'), 342, 'credit card', 192, 462);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-03-2020', 'dd-mm-yyyy'), 343, 'cash', 345, 88);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-11-2020', 'dd-mm-yyyy'), 344, 'credit card', 404, 500);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-12-2021', 'dd-mm-yyyy'), 345, 'paybox', 437, 225);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-10-2021', 'dd-mm-yyyy'), 346, 'paybox', 375, 282);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-03-2021', 'dd-mm-yyyy'), 347, 'credit card', 410, 462);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-04-2020', 'dd-mm-yyyy'), 348, 'credit card', 238, 437);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-09-2021', 'dd-mm-yyyy'), 349, 'paybox', 11, 332);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-11-2020', 'dd-mm-yyyy'), 350, 'cash', 437, 69);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-06-2021', 'dd-mm-yyyy'), 351, 'bit', 116, 417);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-05-2021', 'dd-mm-yyyy'), 352, 'paybox', 335, 276);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-10-2021', 'dd-mm-yyyy'), 353, 'cash', 149, 455);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-11-2020', 'dd-mm-yyyy'), 354, 'credit card', 207, 125);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-01-2020', 'dd-mm-yyyy'), 355, 'credit card', 418, 4);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-10-2020', 'dd-mm-yyyy'), 356, 'bit', 157, 230);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-05-2020', 'dd-mm-yyyy'), 357, 'bit', 354, 141);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-02-2021', 'dd-mm-yyyy'), 358, 'bit', 428, 309);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-03-2021', 'dd-mm-yyyy'), 359, 'bit', 147, 152);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-04-2020', 'dd-mm-yyyy'), 360, 'paybox', 126, 303);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-07-2021', 'dd-mm-yyyy'), 361, 'credit card', 303, 303);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-05-2020', 'dd-mm-yyyy'), 362, 'paybox', 349, 9);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-08-2021', 'dd-mm-yyyy'), 363, 'bit', 98, 108);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-06-2020', 'dd-mm-yyyy'), 364, 'cash', 217, 266);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-08-2020', 'dd-mm-yyyy'), 365, 'cash', 437, 156);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-05-2021', 'dd-mm-yyyy'), 366, 'credit card', 318, 127);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-03-2020', 'dd-mm-yyyy'), 367, 'paybox', 129, 439);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-01-2020', 'dd-mm-yyyy'), 368, 'cash', 51, 126);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-10-2021', 'dd-mm-yyyy'), 369, 'paybox', 54, 221);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-02-2021', 'dd-mm-yyyy'), 370, 'credit card', 380, 20);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-03-2021', 'dd-mm-yyyy'), 371, 'cash', 251, 472);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-02-2021', 'dd-mm-yyyy'), 372, 'cash', 492, 96);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-03-2021', 'dd-mm-yyyy'), 373, 'bit', 403, 267);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-04-2021', 'dd-mm-yyyy'), 374, 'credit card', 364, 496);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-08-2021', 'dd-mm-yyyy'), 375, 'paybox', 227, 287);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-10-2020', 'dd-mm-yyyy'), 376, 'credit card', 234, 58);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-08-2020', 'dd-mm-yyyy'), 377, 'paybox', 279, 294);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-07-2020', 'dd-mm-yyyy'), 378, 'bit', 481, 250);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-07-2020', 'dd-mm-yyyy'), 379, 'bit', 158, 173);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-02-2020', 'dd-mm-yyyy'), 380, 'bit', 405, 36);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-04-2020', 'dd-mm-yyyy'), 381, 'cash', 117, 499);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-01-2021', 'dd-mm-yyyy'), 382, 'cash', 420, 375);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('08-07-2020', 'dd-mm-yyyy'), 383, 'bit', 84, 101);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('15-03-2020', 'dd-mm-yyyy'), 384, 'paybox', 151, 165);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-12-2020', 'dd-mm-yyyy'), 385, 'credit card', 85, 234);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-08-2020', 'dd-mm-yyyy'), 386, 'cash', 435, 294);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-03-2021', 'dd-mm-yyyy'), 387, 'credit card', 74, 188);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-09-2020', 'dd-mm-yyyy'), 388, 'credit card', 234, 155);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-12-2020', 'dd-mm-yyyy'), 389, 'cash', 175, 504);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-08-2021', 'dd-mm-yyyy'), 390, 'credit card', 446, 249);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-03-2020', 'dd-mm-yyyy'), 391, 'cash', 320, 168);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-10-2021', 'dd-mm-yyyy'), 392, 'credit card', 128, 270);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-03-2021', 'dd-mm-yyyy'), 393, 'cash', 303, 395);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-03-2020', 'dd-mm-yyyy'), 394, 'credit card', 126, 261);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-02-2021', 'dd-mm-yyyy'), 395, 'bit', 232, 366);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-06-2021', 'dd-mm-yyyy'), 396, 'credit card', 107, 281);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-06-2021', 'dd-mm-yyyy'), 397, 'credit card', 396, 73);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-05-2020', 'dd-mm-yyyy'), 398, 'cash', 1, 102);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('27-03-2020', 'dd-mm-yyyy'), 399, 'credit card', 31, 153);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-09-2020', 'dd-mm-yyyy'), 400, 'cash', 344, 455);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-09-2020', 'dd-mm-yyyy'), 401, 'credit card', 162, 39);
commit;
prompt 400 records committed...
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-01-2021', 'dd-mm-yyyy'), 402, 'bit', 475, 345);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-09-2021', 'dd-mm-yyyy'), 403, 'cash', 322, 3);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-12-2021', 'dd-mm-yyyy'), 404, 'paybox', 93, 332);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-07-2020', 'dd-mm-yyyy'), 405, 'credit card', 13, 248);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-09-2021', 'dd-mm-yyyy'), 406, 'bit', 140, 291);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-05-2020', 'dd-mm-yyyy'), 407, 'credit card', 325, 335);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-03-2020', 'dd-mm-yyyy'), 408, 'credit card', 181, 443);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-09-2021', 'dd-mm-yyyy'), 409, 'credit card', 75, 263);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-09-2021', 'dd-mm-yyyy'), 410, 'paybox', 242, 88);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-01-2020', 'dd-mm-yyyy'), 411, 'paybox', 270, 257);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('05-08-2020', 'dd-mm-yyyy'), 412, 'paybox', 331, 247);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-12-2020', 'dd-mm-yyyy'), 413, 'bit', 139, 449);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-12-2020', 'dd-mm-yyyy'), 414, 'credit card', 249, 143);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-10-2021', 'dd-mm-yyyy'), 415, 'cash', 459, 475);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-09-2020', 'dd-mm-yyyy'), 416, 'cash', 164, 155);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-08-2020', 'dd-mm-yyyy'), 417, 'cash', 153, 485);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-07-2021', 'dd-mm-yyyy'), 418, 'bit', 487, 134);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-06-2020', 'dd-mm-yyyy'), 419, 'credit card', 171, 43);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-05-2021', 'dd-mm-yyyy'), 420, 'cash', 14, 147);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-04-2020', 'dd-mm-yyyy'), 421, 'bit', 152, 466);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-02-2020', 'dd-mm-yyyy'), 422, 'paybox', 357, 117);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-02-2020', 'dd-mm-yyyy'), 423, 'cash', 373, 500);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-08-2020', 'dd-mm-yyyy'), 424, 'credit card', 152, 378);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-04-2021', 'dd-mm-yyyy'), 425, 'bit', 470, 493);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-02-2021', 'dd-mm-yyyy'), 426, 'paybox', 52, 117);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-05-2020', 'dd-mm-yyyy'), 427, 'bit', 445, 407);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-09-2021', 'dd-mm-yyyy'), 428, 'cash', 499, 260);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-11-2021', 'dd-mm-yyyy'), 429, 'cash', 459, 264);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-04-2021', 'dd-mm-yyyy'), 430, 'bit', 278, 217);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-01-2020', 'dd-mm-yyyy'), 431, 'cash', 396, 496);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-07-2020', 'dd-mm-yyyy'), 432, 'paybox', 351, 69);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-10-2021', 'dd-mm-yyyy'), 433, 'paybox', 214, 178);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-01-2021', 'dd-mm-yyyy'), 434, 'credit card', 472, 153);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-11-2020', 'dd-mm-yyyy'), 435, 'credit card', 82, 224);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-02-2020', 'dd-mm-yyyy'), 436, 'bit', 90, 34);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('08-07-2021', 'dd-mm-yyyy'), 437, 'paybox', 286, 418);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-08-2020', 'dd-mm-yyyy'), 438, 'paybox', 21, 419);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-11-2021', 'dd-mm-yyyy'), 439, 'bit', 427, 398);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-11-2021', 'dd-mm-yyyy'), 440, 'credit card', 411, 430);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-08-2020', 'dd-mm-yyyy'), 441, 'paybox', 399, 38);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('03-11-2021', 'dd-mm-yyyy'), 442, 'credit card', 478, 337);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('08-09-2020', 'dd-mm-yyyy'), 443, 'paybox', 141, 237);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-01-2020', 'dd-mm-yyyy'), 444, 'paybox', 34, 156);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-07-2021', 'dd-mm-yyyy'), 445, 'paybox', 178, 87);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-02-2020', 'dd-mm-yyyy'), 446, 'cash', 288, 175);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('24-08-2021', 'dd-mm-yyyy'), 447, 'bit', 438, 498);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-03-2021', 'dd-mm-yyyy'), 448, 'cash', 429, 369);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-01-2021', 'dd-mm-yyyy'), 449, 'bit', 356, 168);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-03-2020', 'dd-mm-yyyy'), 450, 'paybox', 497, 232);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('17-10-2021', 'dd-mm-yyyy'), 451, 'bit', 254, 33);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-02-2020', 'dd-mm-yyyy'), 452, 'cash', 27, 27);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-10-2020', 'dd-mm-yyyy'), 453, 'cash', 2, 50);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-02-2020', 'dd-mm-yyyy'), 454, 'paybox', 478, 425);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('07-08-2020', 'dd-mm-yyyy'), 455, 'paybox', 468, 432);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('20-12-2021', 'dd-mm-yyyy'), 456, 'cash', 446, 31);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('04-08-2020', 'dd-mm-yyyy'), 457, 'bit', 236, 263);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('12-11-2020', 'dd-mm-yyyy'), 458, 'bit', 149, 388);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-11-2021', 'dd-mm-yyyy'), 459, 'paybox', 119, 56);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-11-2021', 'dd-mm-yyyy'), 460, 'bit', 206, 285);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-09-2020', 'dd-mm-yyyy'), 461, 'bit', 446, 178);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('29-08-2020', 'dd-mm-yyyy'), 462, 'credit card', 187, 67);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-09-2021', 'dd-mm-yyyy'), 463, 'bit', 127, 192);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-10-2020', 'dd-mm-yyyy'), 464, 'cash', 448, 297);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2021', 'dd-mm-yyyy'), 465, 'paybox', 11, 118);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-06-2020', 'dd-mm-yyyy'), 466, 'paybox', 251, 323);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-02-2020', 'dd-mm-yyyy'), 467, 'credit card', 9, 96);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-10-2021', 'dd-mm-yyyy'), 468, 'bit', 156, 284);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('30-03-2021', 'dd-mm-yyyy'), 469, 'credit card', 16, 445);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-01-2020', 'dd-mm-yyyy'), 470, 'bit', 202, 500);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-05-2021', 'dd-mm-yyyy'), 471, 'cash', 99, 123);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('28-04-2021', 'dd-mm-yyyy'), 472, 'bit', 369, 256);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-05-2020', 'dd-mm-yyyy'), 473, 'credit card', 474, 137);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-10-2021', 'dd-mm-yyyy'), 474, 'cash', 317, 35);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-04-2021', 'dd-mm-yyyy'), 475, 'paybox', 265, 299);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-08-2021', 'dd-mm-yyyy'), 476, 'paybox', 407, 111);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('13-11-2020', 'dd-mm-yyyy'), 477, 'paybox', 41, 422);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('19-07-2020', 'dd-mm-yyyy'), 478, 'cash', 10, 68);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('14-08-2021', 'dd-mm-yyyy'), 479, 'cash', 133, 422);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-02-2020', 'dd-mm-yyyy'), 480, 'cash', 85, 235);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-07-2020', 'dd-mm-yyyy'), 481, 'bit', 237, 321);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-08-2021', 'dd-mm-yyyy'), 482, 'cash', 52, 2);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-08-2021', 'dd-mm-yyyy'), 483, 'cash', 298, 154);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-12-2021', 'dd-mm-yyyy'), 484, 'credit card', 434, 81);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('31-07-2020', 'dd-mm-yyyy'), 485, 'paybox', 167, 287);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-06-2020', 'dd-mm-yyyy'), 486, 'bit', 290, 123);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-12-2021', 'dd-mm-yyyy'), 487, 'cash', 51, 126);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-12-2020', 'dd-mm-yyyy'), 488, 'bit', 419, 286);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-09-2021', 'dd-mm-yyyy'), 489, 'bit', 234, 269);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-09-2020', 'dd-mm-yyyy'), 490, 'cash', 361, 177);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('09-10-2020', 'dd-mm-yyyy'), 491, 'cash', 90, 13);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('18-06-2020', 'dd-mm-yyyy'), 492, 'credit card', 158, 235);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('02-12-2021', 'dd-mm-yyyy'), 493, 'credit card', 364, 322);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('26-12-2021', 'dd-mm-yyyy'), 494, 'credit card', 417, 478);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-05-2021', 'dd-mm-yyyy'), 495, 'cash', 245, 142);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-06-2020', 'dd-mm-yyyy'), 496, 'credit card', 139, 183);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('10-04-2020', 'dd-mm-yyyy'), 497, 'paybox', 219, 187);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-11-2021', 'dd-mm-yyyy'), 498, 'paybox', 340, 487);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('06-03-2020', 'dd-mm-yyyy'), 499, 'credit card', 194, 75);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('08-12-2021', 'dd-mm-yyyy'), 500, 'paybox', 444, 335);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-02-2024', 'dd-mm-yyyy'), 501, 'bit', 1, 1);
commit;
prompt 500 records committed...
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('01-04-2024', 'dd-mm-yyyy'), 502, 'paybox', 1, 2);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-05-2024', 'dd-mm-yyyy'), 503, 'bit', 2, 3);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-08-2024', 'dd-mm-yyyy'), 504, 'paybox', 2, 4);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-09-2024', 'dd-mm-yyyy'), 505, 'paybox', 3, 4);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('25-03-2024', 'dd-mm-yyyy'), 506, 'cash', 4, 5);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('22-11-2024', 'dd-mm-yyyy'), 507, 'bit', 2, 6);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-09-2024', 'dd-mm-yyyy'), 508, 'cash', 3, 2);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('21-02-2024', 'dd-mm-yyyy'), 509, 'bit', 6, 7);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('11-01-2024', 'dd-mm-yyyy'), 510, 'cash', 8, 2);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 00:46:03', 'dd-mm-yyyy hh24:mi:ss'), 511, 'bit', 1, 1);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 00:53:32', 'dd-mm-yyyy hh24:mi:ss'), 512, 'bit', 1, 1);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 00:54:49', 'dd-mm-yyyy hh24:mi:ss'), 513, 'bit', 1, 1);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 01:17:24', 'dd-mm-yyyy hh24:mi:ss'), 514, 'bit', 1, 1);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 01:20:32', 'dd-mm-yyyy hh24:mi:ss'), 515, 'bit', 1, 1);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 01:21:00', 'dd-mm-yyyy hh24:mi:ss'), 516, 'bit', 1, 1);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 18:17:24', 'dd-mm-yyyy hh24:mi:ss'), 519, 'cash', 101, 1);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 13:39:44', 'dd-mm-yyyy hh24:mi:ss'), 517, 'bit', 32, 19);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 13:50:01', 'dd-mm-yyyy hh24:mi:ss'), 518, 'bit', 329, 193);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('23-06-2024 12:19:06', 'dd-mm-yyyy hh24:mi:ss'), 604, 'cash', 601, 5);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 21:03:58', 'dd-mm-yyyy hh24:mi:ss'), 601, 'cash', 301, 401);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 21:05:56', 'dd-mm-yyyy hh24:mi:ss'), 602, 'cash', 601, 401);
insert into ORDERS (ordate, oserialnumber, paymentmethod, cid, shipid)
values (to_date('16-06-2024 21:16:23', 'dd-mm-yyyy hh24:mi:ss'), 603, 'cash', 601, 1);
commit;
prompt 522 records loaded
prompt Loading EQUIPMENT...
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (1, to_date('08-07-2024', 'dd-mm-yyyy'), to_date('08-08-2023', 'dd-mm-yyyy'), 187, 499);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (2, to_date('22-10-2024', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 333, 260);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (3, to_date('17-11-2024', 'dd-mm-yyyy'), to_date('11-02-2023', 'dd-mm-yyyy'), 261, 166);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (4, to_date('24-10-2024', 'dd-mm-yyyy'), to_date('22-07-2023', 'dd-mm-yyyy'), 353, 314);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (5, to_date('04-11-2024', 'dd-mm-yyyy'), to_date('03-07-2023', 'dd-mm-yyyy'), 385, 56);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (6, to_date('17-10-2024', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 433, 418);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (7, to_date('15-03-2024', 'dd-mm-yyyy'), to_date('17-12-2023', 'dd-mm-yyyy'), 262, 187);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (8, to_date('14-02-2024', 'dd-mm-yyyy'), to_date('22-03-2023', 'dd-mm-yyyy'), 295, 279);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (9, to_date('08-10-2024', 'dd-mm-yyyy'), to_date('02-03-2023', 'dd-mm-yyyy'), 258, 147);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (10, to_date('19-06-2024', 'dd-mm-yyyy'), to_date('08-04-2023', 'dd-mm-yyyy'), 332, 67);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (11, to_date('12-07-2024', 'dd-mm-yyyy'), to_date('26-07-2023', 'dd-mm-yyyy'), 162, 326);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (12, to_date('11-01-2024', 'dd-mm-yyyy'), to_date('02-03-2023', 'dd-mm-yyyy'), 288, 405);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (13, to_date('01-08-2024', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 96, 416);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (14, to_date('19-08-2024', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 126, 144);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (15, to_date('06-11-2024', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 69, 204);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (16, to_date('03-08-2024', 'dd-mm-yyyy'), to_date('22-12-2023', 'dd-mm-yyyy'), 33, 414);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (17, to_date('11-08-2024', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 191, 138);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (18, to_date('25-05-2024', 'dd-mm-yyyy'), to_date('06-04-2023', 'dd-mm-yyyy'), 89, 459);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (19, to_date('12-11-2024', 'dd-mm-yyyy'), to_date('17-08-2023', 'dd-mm-yyyy'), 39, 179);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (20, to_date('01-04-2024', 'dd-mm-yyyy'), to_date('02-03-2023', 'dd-mm-yyyy'), 83, 257);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (21, to_date('25-06-2024', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 197, 434);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (22, to_date('07-05-2024', 'dd-mm-yyyy'), to_date('21-05-2023', 'dd-mm-yyyy'), 4, 412);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (23, to_date('09-03-2024', 'dd-mm-yyyy'), to_date('29-09-2023', 'dd-mm-yyyy'), 421, 67);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (24, to_date('12-01-2024', 'dd-mm-yyyy'), to_date('21-02-2023', 'dd-mm-yyyy'), 174, 337);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (25, to_date('01-05-2024', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 487, 495);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (26, to_date('24-09-2024', 'dd-mm-yyyy'), to_date('22-11-2023', 'dd-mm-yyyy'), 25, 211);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (27, to_date('07-07-2024', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 186, 361);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (28, to_date('18-09-2024', 'dd-mm-yyyy'), to_date('10-02-2023', 'dd-mm-yyyy'), 74, 224);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (29, to_date('23-12-2024', 'dd-mm-yyyy'), to_date('10-01-2023', 'dd-mm-yyyy'), 485, 296);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (30, to_date('29-08-2024', 'dd-mm-yyyy'), to_date('17-02-2023', 'dd-mm-yyyy'), 4, 95);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (31, to_date('30-10-2024', 'dd-mm-yyyy'), to_date('29-10-2023', 'dd-mm-yyyy'), 304, 449);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (32, to_date('14-01-2024', 'dd-mm-yyyy'), to_date('15-01-2023', 'dd-mm-yyyy'), 441, 377);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (33, to_date('06-02-2024', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 16, 315);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (34, to_date('16-04-2024', 'dd-mm-yyyy'), to_date('30-08-2023', 'dd-mm-yyyy'), 350, 45);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (35, to_date('28-07-2024', 'dd-mm-yyyy'), to_date('29-12-2023', 'dd-mm-yyyy'), 51, 330);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (36, to_date('11-11-2024', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 134, 359);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (37, to_date('13-06-2024', 'dd-mm-yyyy'), to_date('28-07-2023', 'dd-mm-yyyy'), 165, 256);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (38, to_date('01-01-2024', 'dd-mm-yyyy'), to_date('19-03-2023', 'dd-mm-yyyy'), 353, 12);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (39, to_date('03-11-2024', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 386, 340);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (40, to_date('24-05-2024', 'dd-mm-yyyy'), to_date('01-01-2023', 'dd-mm-yyyy'), 96, 59);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (41, to_date('09-01-2024', 'dd-mm-yyyy'), to_date('17-12-2023', 'dd-mm-yyyy'), 86, 263);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (42, to_date('08-08-2024', 'dd-mm-yyyy'), to_date('06-08-2023', 'dd-mm-yyyy'), 49, 127);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (43, to_date('27-07-2024', 'dd-mm-yyyy'), to_date('07-03-2023', 'dd-mm-yyyy'), 258, 362);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (44, to_date('03-05-2024', 'dd-mm-yyyy'), to_date('25-02-2023', 'dd-mm-yyyy'), 172, 408);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (45, to_date('30-03-2024', 'dd-mm-yyyy'), to_date('16-08-2023', 'dd-mm-yyyy'), 378, 140);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (46, to_date('03-07-2024', 'dd-mm-yyyy'), to_date('31-08-2023', 'dd-mm-yyyy'), 58, 428);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (47, to_date('24-09-2024', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 489, 52);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (48, to_date('06-02-2024', 'dd-mm-yyyy'), to_date('17-05-2023', 'dd-mm-yyyy'), 458, 101);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (49, to_date('03-03-2024', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 405, 74);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (50, to_date('27-11-2024', 'dd-mm-yyyy'), to_date('27-03-2023', 'dd-mm-yyyy'), 420, 70);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (51, to_date('03-07-2024', 'dd-mm-yyyy'), to_date('23-09-2023', 'dd-mm-yyyy'), 82, 54);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (52, to_date('25-12-2024', 'dd-mm-yyyy'), to_date('12-06-2023', 'dd-mm-yyyy'), 140, 313);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (53, to_date('27-08-2024', 'dd-mm-yyyy'), to_date('10-01-2023', 'dd-mm-yyyy'), 155, 345);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (54, to_date('30-12-2024', 'dd-mm-yyyy'), to_date('13-01-2023', 'dd-mm-yyyy'), 435, 51);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (55, to_date('23-06-2024', 'dd-mm-yyyy'), to_date('23-11-2023', 'dd-mm-yyyy'), 99, 218);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (56, to_date('09-05-2024', 'dd-mm-yyyy'), to_date('10-07-2023', 'dd-mm-yyyy'), 361, 419);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (57, to_date('23-07-2024', 'dd-mm-yyyy'), to_date('12-06-2023', 'dd-mm-yyyy'), 86, 55);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (58, to_date('17-02-2024', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 23, 429);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (59, to_date('27-10-2024', 'dd-mm-yyyy'), to_date('31-03-2023', 'dd-mm-yyyy'), 478, 323);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (60, to_date('06-11-2024', 'dd-mm-yyyy'), to_date('27-01-2023', 'dd-mm-yyyy'), 27, 211);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (61, to_date('04-12-2024', 'dd-mm-yyyy'), to_date('20-05-2023', 'dd-mm-yyyy'), 461, 337);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (63, to_date('30-06-2024', 'dd-mm-yyyy'), to_date('06-08-2023', 'dd-mm-yyyy'), 378, 291);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (64, to_date('20-07-2024', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 192, 121);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (65, to_date('01-03-2024', 'dd-mm-yyyy'), to_date('15-06-2023', 'dd-mm-yyyy'), 179, 81);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (66, to_date('02-12-2024', 'dd-mm-yyyy'), to_date('10-05-2023', 'dd-mm-yyyy'), 233, 207);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (67, to_date('02-06-2024', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 42, 408);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (68, to_date('09-03-2024', 'dd-mm-yyyy'), to_date('04-09-2023', 'dd-mm-yyyy'), 367, 434);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (69, to_date('03-04-2024', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 154, 151);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (70, to_date('25-10-2024', 'dd-mm-yyyy'), to_date('14-04-2023', 'dd-mm-yyyy'), 343, 485);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (71, to_date('31-08-2024', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 133, 42);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (72, to_date('20-04-2024', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 380, 13);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (73, to_date('30-11-2024', 'dd-mm-yyyy'), to_date('21-05-2023', 'dd-mm-yyyy'), 129, 101);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (74, to_date('12-08-2024', 'dd-mm-yyyy'), to_date('30-06-2023', 'dd-mm-yyyy'), 196, 352);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (75, to_date('24-08-2024', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 62, 365);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (76, to_date('15-06-2024', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 219, 11);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (77, to_date('18-10-2024', 'dd-mm-yyyy'), to_date('23-03-2023', 'dd-mm-yyyy'), 27, 396);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (78, to_date('29-04-2024', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 433, 441);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (79, to_date('23-04-2024', 'dd-mm-yyyy'), to_date('15-02-2023', 'dd-mm-yyyy'), 354, 66);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (80, to_date('29-05-2024', 'dd-mm-yyyy'), to_date('22-06-2023', 'dd-mm-yyyy'), 382, 95);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (81, to_date('07-09-2024', 'dd-mm-yyyy'), to_date('07-01-2023', 'dd-mm-yyyy'), 306, 131);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (82, to_date('04-04-2024', 'dd-mm-yyyy'), to_date('25-08-2023', 'dd-mm-yyyy'), 355, 258);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (83, to_date('24-04-2024', 'dd-mm-yyyy'), to_date('13-08-2023', 'dd-mm-yyyy'), 474, 75);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (84, to_date('23-04-2024', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 197, 164);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (85, to_date('29-08-2024', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 280, 248);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (86, to_date('13-03-2024', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 294, 396);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (87, to_date('20-03-2024', 'dd-mm-yyyy'), to_date('03-04-2023', 'dd-mm-yyyy'), 179, 276);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (88, to_date('19-11-2024', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 199, 64);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (89, to_date('22-04-2024', 'dd-mm-yyyy'), to_date('21-11-2023', 'dd-mm-yyyy'), 488, 257);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (90, to_date('08-08-2024', 'dd-mm-yyyy'), to_date('07-12-2023', 'dd-mm-yyyy'), 440, 261);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (91, to_date('04-09-2024', 'dd-mm-yyyy'), to_date('07-05-2023', 'dd-mm-yyyy'), 373, 234);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (92, to_date('13-08-2024', 'dd-mm-yyyy'), to_date('01-12-2023', 'dd-mm-yyyy'), 448, 311);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (93, to_date('24-11-2024', 'dd-mm-yyyy'), to_date('27-04-2023', 'dd-mm-yyyy'), 15, 454);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (94, to_date('13-10-2024', 'dd-mm-yyyy'), to_date('07-11-2023', 'dd-mm-yyyy'), 180, 286);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (95, to_date('14-08-2024', 'dd-mm-yyyy'), to_date('08-08-2023', 'dd-mm-yyyy'), 424, 406);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (96, to_date('10-12-2024', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 378, 310);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (97, to_date('28-07-2024', 'dd-mm-yyyy'), to_date('18-04-2023', 'dd-mm-yyyy'), 367, 139);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (98, to_date('05-02-2024', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 468, 147);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (99, to_date('11-06-2024', 'dd-mm-yyyy'), to_date('18-01-2023', 'dd-mm-yyyy'), 26, 363);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (100, to_date('08-06-2024', 'dd-mm-yyyy'), to_date('02-02-2023', 'dd-mm-yyyy'), 149, 67);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (101, to_date('11-07-2024', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 269, 333);
commit;
prompt 100 records committed...
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (102, to_date('18-02-2024', 'dd-mm-yyyy'), to_date('27-01-2023', 'dd-mm-yyyy'), 129, 491);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (103, to_date('14-03-2024', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 52, 9);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (104, to_date('30-12-2024', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 494, 419);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (105, to_date('19-03-2024', 'dd-mm-yyyy'), to_date('24-04-2023', 'dd-mm-yyyy'), 50, 3);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (106, to_date('24-11-2024', 'dd-mm-yyyy'), to_date('13-12-2023', 'dd-mm-yyyy'), 247, 144);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (107, to_date('13-10-2024', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 374, 300);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (108, to_date('13-01-2024', 'dd-mm-yyyy'), to_date('27-08-2023', 'dd-mm-yyyy'), 32, 241);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (109, to_date('06-07-2024', 'dd-mm-yyyy'), to_date('02-02-2023', 'dd-mm-yyyy'), 476, 273);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (110, to_date('01-01-2024', 'dd-mm-yyyy'), to_date('24-06-2023', 'dd-mm-yyyy'), 473, 338);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (111, to_date('09-02-2024', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 213, 461);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (112, to_date('31-08-2024', 'dd-mm-yyyy'), to_date('05-01-2023', 'dd-mm-yyyy'), 163, 173);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (113, to_date('04-12-2024', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 66, 148);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (114, to_date('10-11-2024', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 380, 426);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (115, to_date('23-04-2024', 'dd-mm-yyyy'), to_date('29-05-2023', 'dd-mm-yyyy'), 502, 206);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (116, to_date('21-11-2024', 'dd-mm-yyyy'), to_date('03-05-2023', 'dd-mm-yyyy'), 363, 336);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (117, to_date('08-10-2024', 'dd-mm-yyyy'), to_date('16-06-2023', 'dd-mm-yyyy'), 489, 231);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (118, to_date('08-11-2024', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 319, 100);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (119, to_date('06-12-2024', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 200, 456);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (120, to_date('11-10-2024', 'dd-mm-yyyy'), to_date('20-04-2023', 'dd-mm-yyyy'), 48, 50);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (121, to_date('08-05-2024', 'dd-mm-yyyy'), to_date('06-04-2023', 'dd-mm-yyyy'), 349, 443);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (122, to_date('18-07-2024', 'dd-mm-yyyy'), to_date('16-10-2023', 'dd-mm-yyyy'), 247, 112);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (123, to_date('06-02-2024', 'dd-mm-yyyy'), to_date('04-04-2023', 'dd-mm-yyyy'), 167, 60);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (124, to_date('01-09-2024', 'dd-mm-yyyy'), to_date('20-11-2023', 'dd-mm-yyyy'), 436, 53);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (125, to_date('03-03-2024', 'dd-mm-yyyy'), to_date('15-03-2023', 'dd-mm-yyyy'), 74, 238);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (126, to_date('06-11-2024', 'dd-mm-yyyy'), to_date('12-01-2023', 'dd-mm-yyyy'), 77, 493);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (127, to_date('20-09-2024', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 484, 9);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (128, to_date('08-05-2024', 'dd-mm-yyyy'), to_date('03-05-2023', 'dd-mm-yyyy'), 349, 221);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (129, to_date('03-02-2024', 'dd-mm-yyyy'), to_date('01-03-2023', 'dd-mm-yyyy'), 245, 326);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (130, to_date('21-03-2024', 'dd-mm-yyyy'), to_date('18-07-2023', 'dd-mm-yyyy'), 25, 269);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (131, to_date('02-09-2024', 'dd-mm-yyyy'), to_date('17-06-2023', 'dd-mm-yyyy'), 299, 162);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (132, to_date('02-04-2024', 'dd-mm-yyyy'), to_date('25-01-2023', 'dd-mm-yyyy'), 93, 286);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (133, to_date('17-07-2024', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 426, 391);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (134, to_date('07-11-2024', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 450, 181);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (135, to_date('22-12-2024', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 186, 456);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (136, to_date('15-08-2024', 'dd-mm-yyyy'), to_date('20-08-2023', 'dd-mm-yyyy'), 293, 54);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (137, to_date('11-09-2024', 'dd-mm-yyyy'), to_date('08-08-2023', 'dd-mm-yyyy'), 19, 307);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (138, to_date('06-11-2024', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 183, 405);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (139, to_date('01-01-2024', 'dd-mm-yyyy'), to_date('09-04-2023', 'dd-mm-yyyy'), 481, 133);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (140, to_date('21-09-2024', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 222, 125);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (141, to_date('29-08-2024', 'dd-mm-yyyy'), to_date('01-08-2023', 'dd-mm-yyyy'), 126, 361);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (142, to_date('06-06-2024', 'dd-mm-yyyy'), to_date('27-01-2023', 'dd-mm-yyyy'), 411, 270);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (143, to_date('24-08-2024', 'dd-mm-yyyy'), to_date('01-07-2023', 'dd-mm-yyyy'), 108, 452);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (144, to_date('07-01-2024', 'dd-mm-yyyy'), to_date('25-09-2023', 'dd-mm-yyyy'), 160, 112);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (145, to_date('01-09-2024', 'dd-mm-yyyy'), to_date('21-06-2023', 'dd-mm-yyyy'), 358, 466);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (146, to_date('07-02-2024', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 474, 476);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (147, to_date('10-07-2024', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 462, 413);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (148, to_date('12-05-2024', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 237, 357);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (149, to_date('04-04-2024', 'dd-mm-yyyy'), to_date('06-07-2023', 'dd-mm-yyyy'), 195, 386);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (150, to_date('10-11-2024', 'dd-mm-yyyy'), to_date('09-10-2023', 'dd-mm-yyyy'), 236, 314);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (151, to_date('22-02-2024', 'dd-mm-yyyy'), to_date('21-01-2023', 'dd-mm-yyyy'), 206, 473);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (152, to_date('05-03-2024', 'dd-mm-yyyy'), to_date('08-03-2023', 'dd-mm-yyyy'), 266, 153);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (153, to_date('19-06-2024', 'dd-mm-yyyy'), to_date('08-06-2023', 'dd-mm-yyyy'), 343, 451);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (154, to_date('10-05-2024', 'dd-mm-yyyy'), to_date('13-03-2023', 'dd-mm-yyyy'), 434, 384);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (155, to_date('12-02-2024', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 155, 264);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (156, to_date('27-08-2024', 'dd-mm-yyyy'), to_date('23-03-2023', 'dd-mm-yyyy'), 96, 462);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (157, to_date('06-01-2024', 'dd-mm-yyyy'), to_date('26-05-2023', 'dd-mm-yyyy'), 52, 277);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (158, to_date('10-02-2024', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'), 493, 312);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (159, to_date('29-04-2024', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 98, 316);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (160, to_date('07-12-2024', 'dd-mm-yyyy'), to_date('20-07-2023', 'dd-mm-yyyy'), 463, 131);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (161, to_date('01-07-2024', 'dd-mm-yyyy'), to_date('03-12-2023', 'dd-mm-yyyy'), 488, 484);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (162, to_date('07-09-2024', 'dd-mm-yyyy'), to_date('08-01-2023', 'dd-mm-yyyy'), 398, 474);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (163, to_date('14-02-2024', 'dd-mm-yyyy'), to_date('12-12-2023', 'dd-mm-yyyy'), 146, 268);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (164, to_date('16-04-2024', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 303, 116);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (165, to_date('28-07-2024', 'dd-mm-yyyy'), to_date('24-10-2023', 'dd-mm-yyyy'), 38, 415);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (166, to_date('13-11-2024', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 22, 207);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (167, to_date('04-07-2024', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 74, 97);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (168, to_date('01-05-2024', 'dd-mm-yyyy'), to_date('02-06-2023', 'dd-mm-yyyy'), 137, 195);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (169, to_date('18-02-2024', 'dd-mm-yyyy'), to_date('15-02-2023', 'dd-mm-yyyy'), 206, 355);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (171, to_date('28-04-2024', 'dd-mm-yyyy'), to_date('10-02-2023', 'dd-mm-yyyy'), 174, 326);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (172, to_date('02-03-2024', 'dd-mm-yyyy'), to_date('20-02-2023', 'dd-mm-yyyy'), 389, 191);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (173, to_date('08-07-2024', 'dd-mm-yyyy'), to_date('28-01-2023', 'dd-mm-yyyy'), 409, 249);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (174, to_date('03-07-2024', 'dd-mm-yyyy'), to_date('12-02-2023', 'dd-mm-yyyy'), 480, 389);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (175, to_date('13-06-2024', 'dd-mm-yyyy'), to_date('16-10-2023', 'dd-mm-yyyy'), 83, 253);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (176, to_date('13-08-2024', 'dd-mm-yyyy'), to_date('19-05-2023', 'dd-mm-yyyy'), 228, 189);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (177, to_date('07-09-2024', 'dd-mm-yyyy'), to_date('31-12-2023', 'dd-mm-yyyy'), 342, 424);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (178, to_date('22-05-2024', 'dd-mm-yyyy'), to_date('12-06-2023', 'dd-mm-yyyy'), 112, 311);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (179, to_date('21-12-2024', 'dd-mm-yyyy'), to_date('02-03-2023', 'dd-mm-yyyy'), 144, 160);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (180, to_date('18-05-2024', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 432, 254);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (181, to_date('25-05-2024', 'dd-mm-yyyy'), to_date('12-04-2023', 'dd-mm-yyyy'), 324, 301);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (182, to_date('10-02-2024', 'dd-mm-yyyy'), to_date('03-04-2023', 'dd-mm-yyyy'), 280, 192);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (183, to_date('17-05-2024', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 239, 41);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (184, to_date('26-03-2024', 'dd-mm-yyyy'), to_date('20-01-2023', 'dd-mm-yyyy'), 203, 152);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (185, to_date('03-06-2024', 'dd-mm-yyyy'), to_date('11-04-2023', 'dd-mm-yyyy'), 135, 122);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (186, to_date('07-06-2024', 'dd-mm-yyyy'), to_date('21-02-2023', 'dd-mm-yyyy'), 476, 478);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (187, to_date('02-10-2024', 'dd-mm-yyyy'), to_date('19-12-2023', 'dd-mm-yyyy'), 130, 313);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (188, to_date('21-03-2024', 'dd-mm-yyyy'), to_date('04-03-2023', 'dd-mm-yyyy'), 41, 67);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (189, to_date('15-09-2024', 'dd-mm-yyyy'), to_date('12-04-2023', 'dd-mm-yyyy'), 368, 163);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (190, to_date('22-06-2024', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 147, 395);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (191, to_date('16-12-2024', 'dd-mm-yyyy'), to_date('16-03-2023', 'dd-mm-yyyy'), 319, 40);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (192, to_date('31-10-2024', 'dd-mm-yyyy'), to_date('23-01-2023', 'dd-mm-yyyy'), 70, 319);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (193, to_date('27-07-2024', 'dd-mm-yyyy'), to_date('10-06-2023', 'dd-mm-yyyy'), 256, 452);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (194, to_date('22-11-2024', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 54, 164);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (195, to_date('27-10-2024', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 369, 148);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (196, to_date('13-03-2024', 'dd-mm-yyyy'), to_date('02-09-2023', 'dd-mm-yyyy'), 383, 87);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (197, to_date('22-11-2024', 'dd-mm-yyyy'), to_date('13-09-2023', 'dd-mm-yyyy'), 32, 494);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (198, to_date('30-01-2024', 'dd-mm-yyyy'), to_date('30-08-2023', 'dd-mm-yyyy'), 90, 223);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (199, to_date('27-04-2024', 'dd-mm-yyyy'), to_date('13-03-2023', 'dd-mm-yyyy'), 264, 146);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (200, to_date('09-04-2024', 'dd-mm-yyyy'), to_date('21-01-2023', 'dd-mm-yyyy'), 383, 121);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (201, to_date('20-04-2024', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 276, 485);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (202, to_date('09-05-2024', 'dd-mm-yyyy'), to_date('05-08-2023', 'dd-mm-yyyy'), 137, 443);
commit;
prompt 200 records committed...
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (203, to_date('11-10-2024', 'dd-mm-yyyy'), to_date('20-07-2023', 'dd-mm-yyyy'), 252, 346);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (204, to_date('07-01-2024', 'dd-mm-yyyy'), to_date('10-05-2023', 'dd-mm-yyyy'), 137, 467);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (205, to_date('11-05-2024', 'dd-mm-yyyy'), to_date('07-12-2023', 'dd-mm-yyyy'), 234, 29);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (206, to_date('17-02-2024', 'dd-mm-yyyy'), to_date('07-02-2023', 'dd-mm-yyyy'), 408, 348);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (207, to_date('16-01-2024', 'dd-mm-yyyy'), to_date('25-12-2023', 'dd-mm-yyyy'), 181, 79);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (208, to_date('09-08-2024', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 221, 182);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (209, to_date('01-10-2024', 'dd-mm-yyyy'), to_date('22-03-2023', 'dd-mm-yyyy'), 188, 362);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (210, to_date('12-02-2024', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 285, 333);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (211, to_date('05-09-2024', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 350, 413);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (212, to_date('02-08-2024', 'dd-mm-yyyy'), to_date('22-02-2023', 'dd-mm-yyyy'), 44, 55);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (213, to_date('18-06-2024', 'dd-mm-yyyy'), to_date('16-02-2023', 'dd-mm-yyyy'), 289, 68);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (214, to_date('06-07-2024', 'dd-mm-yyyy'), to_date('04-09-2023', 'dd-mm-yyyy'), 177, 384);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (215, to_date('26-02-2024', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 344, 376);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (216, to_date('04-02-2024', 'dd-mm-yyyy'), to_date('25-08-2023', 'dd-mm-yyyy'), 217, 323);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (217, to_date('29-12-2024', 'dd-mm-yyyy'), to_date('25-08-2023', 'dd-mm-yyyy'), 399, 296);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (218, to_date('06-03-2024', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 353, 297);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (219, to_date('11-01-2024', 'dd-mm-yyyy'), to_date('31-12-2023', 'dd-mm-yyyy'), 387, 171);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (220, to_date('07-01-2024', 'dd-mm-yyyy'), to_date('20-12-2023', 'dd-mm-yyyy'), 376, 394);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (221, to_date('07-07-2024', 'dd-mm-yyyy'), to_date('17-03-2023', 'dd-mm-yyyy'), 437, 484);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (222, to_date('31-10-2024', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 281, 393);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (223, to_date('21-02-2024', 'dd-mm-yyyy'), to_date('29-04-2023', 'dd-mm-yyyy'), 180, 396);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (224, to_date('14-03-2024', 'dd-mm-yyyy'), to_date('12-08-2023', 'dd-mm-yyyy'), 33, 61);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (225, to_date('27-01-2024', 'dd-mm-yyyy'), to_date('01-08-2023', 'dd-mm-yyyy'), 222, 70);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (226, to_date('28-03-2024', 'dd-mm-yyyy'), to_date('16-09-2023', 'dd-mm-yyyy'), 487, 243);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (227, to_date('17-10-2024', 'dd-mm-yyyy'), to_date('18-08-2023', 'dd-mm-yyyy'), 253, 264);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (228, to_date('16-08-2024', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 438, 224);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (229, to_date('10-10-2024', 'dd-mm-yyyy'), to_date('08-11-2023', 'dd-mm-yyyy'), 326, 220);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (230, to_date('23-05-2024', 'dd-mm-yyyy'), to_date('28-03-2023', 'dd-mm-yyyy'), 380, 381);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (231, to_date('10-12-2024', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 294, 320);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (232, to_date('04-08-2024', 'dd-mm-yyyy'), to_date('18-04-2023', 'dd-mm-yyyy'), 381, 107);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (234, to_date('15-09-2024', 'dd-mm-yyyy'), to_date('18-03-2023', 'dd-mm-yyyy'), 114, 26);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (235, to_date('20-05-2024', 'dd-mm-yyyy'), to_date('15-09-2023', 'dd-mm-yyyy'), 3, 158);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (236, to_date('03-12-2024', 'dd-mm-yyyy'), to_date('18-07-2023', 'dd-mm-yyyy'), 76, 479);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (237, to_date('15-06-2024', 'dd-mm-yyyy'), to_date('10-07-2023', 'dd-mm-yyyy'), 21, 289);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (238, to_date('13-03-2024', 'dd-mm-yyyy'), to_date('09-07-2023', 'dd-mm-yyyy'), 427, 299);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (239, to_date('12-12-2024', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 446, 145);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (240, to_date('19-02-2024', 'dd-mm-yyyy'), to_date('01-06-2023', 'dd-mm-yyyy'), 497, 368);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (241, to_date('20-08-2024', 'dd-mm-yyyy'), to_date('01-01-2023', 'dd-mm-yyyy'), 65, 120);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (242, to_date('07-09-2024', 'dd-mm-yyyy'), to_date('14-01-2023', 'dd-mm-yyyy'), 468, 444);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (243, to_date('02-09-2024', 'dd-mm-yyyy'), to_date('09-12-2023', 'dd-mm-yyyy'), 365, 135);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (244, to_date('21-08-2024', 'dd-mm-yyyy'), to_date('28-03-2023', 'dd-mm-yyyy'), 189, 286);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (245, to_date('24-09-2024', 'dd-mm-yyyy'), to_date('05-06-2023', 'dd-mm-yyyy'), 7, 274);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (246, to_date('16-12-2024', 'dd-mm-yyyy'), to_date('13-07-2023', 'dd-mm-yyyy'), 161, 45);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (247, to_date('31-12-2024', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 58, 192);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (248, to_date('28-11-2024', 'dd-mm-yyyy'), to_date('18-09-2023', 'dd-mm-yyyy'), 162, 445);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (249, to_date('15-12-2024', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 295, 312);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (250, to_date('26-12-2024', 'dd-mm-yyyy'), to_date('14-08-2023', 'dd-mm-yyyy'), 47, 243);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (251, to_date('21-12-2024', 'dd-mm-yyyy'), to_date('23-04-2023', 'dd-mm-yyyy'), 211, 302);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (252, to_date('10-09-2024', 'dd-mm-yyyy'), to_date('10-11-2023', 'dd-mm-yyyy'), 198, 472);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (253, to_date('19-09-2024', 'dd-mm-yyyy'), to_date('20-07-2023', 'dd-mm-yyyy'), 175, 330);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (254, to_date('01-02-2024', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 118, 460);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (255, to_date('25-05-2024', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 229, 101);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (256, to_date('07-03-2024', 'dd-mm-yyyy'), to_date('11-12-2023', 'dd-mm-yyyy'), 207, 135);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (257, to_date('13-10-2024', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 53, 178);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (258, to_date('16-02-2024', 'dd-mm-yyyy'), to_date('25-11-2023', 'dd-mm-yyyy'), 163, 112);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (259, to_date('23-01-2024', 'dd-mm-yyyy'), to_date('21-01-2023', 'dd-mm-yyyy'), 94, 84);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (260, to_date('18-03-2024', 'dd-mm-yyyy'), to_date('03-06-2023', 'dd-mm-yyyy'), 69, 57);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (261, to_date('28-06-2024', 'dd-mm-yyyy'), to_date('22-08-2023', 'dd-mm-yyyy'), 331, 180);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (262, to_date('12-09-2024', 'dd-mm-yyyy'), to_date('28-12-2023', 'dd-mm-yyyy'), 116, 332);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (263, to_date('22-11-2024', 'dd-mm-yyyy'), to_date('23-11-2023', 'dd-mm-yyyy'), 208, 332);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (264, to_date('09-06-2024', 'dd-mm-yyyy'), to_date('16-11-2023', 'dd-mm-yyyy'), 490, 433);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (265, to_date('02-12-2024', 'dd-mm-yyyy'), to_date('06-10-2023', 'dd-mm-yyyy'), 237, 352);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (266, to_date('27-04-2024', 'dd-mm-yyyy'), to_date('06-05-2023', 'dd-mm-yyyy'), 403, 187);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (267, to_date('01-03-2024', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 227, 225);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (268, to_date('12-07-2024', 'dd-mm-yyyy'), to_date('13-12-2023', 'dd-mm-yyyy'), 313, 254);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (269, to_date('30-01-2024', 'dd-mm-yyyy'), to_date('18-03-2023', 'dd-mm-yyyy'), 194, 119);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (270, to_date('12-08-2024', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 266, 395);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (271, to_date('08-09-2024', 'dd-mm-yyyy'), to_date('09-07-2023', 'dd-mm-yyyy'), 417, 166);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (272, to_date('10-05-2024', 'dd-mm-yyyy'), to_date('16-04-2023', 'dd-mm-yyyy'), 406, 24);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (274, to_date('28-06-2024', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 137, 47);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (275, to_date('20-12-2024', 'dd-mm-yyyy'), to_date('01-01-2023', 'dd-mm-yyyy'), 485, 293);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (276, to_date('05-03-2024', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 470, 476);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (277, to_date('20-06-2024', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 405, 11);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (278, to_date('07-05-2024', 'dd-mm-yyyy'), to_date('22-04-2023', 'dd-mm-yyyy'), 465, 325);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (279, to_date('08-06-2024', 'dd-mm-yyyy'), to_date('18-04-2023', 'dd-mm-yyyy'), 435, 204);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (280, to_date('28-10-2024', 'dd-mm-yyyy'), to_date('29-12-2023', 'dd-mm-yyyy'), 399, 293);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (281, to_date('30-01-2024', 'dd-mm-yyyy'), to_date('20-06-2023', 'dd-mm-yyyy'), 498, 10);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (282, to_date('04-04-2024', 'dd-mm-yyyy'), to_date('18-02-2023', 'dd-mm-yyyy'), 42, 219);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (283, to_date('07-08-2024', 'dd-mm-yyyy'), to_date('04-01-2023', 'dd-mm-yyyy'), 404, 172);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (284, to_date('22-11-2024', 'dd-mm-yyyy'), to_date('02-02-2023', 'dd-mm-yyyy'), 119, 328);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (285, to_date('01-08-2024', 'dd-mm-yyyy'), to_date('04-09-2023', 'dd-mm-yyyy'), 4, 292);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (286, to_date('19-02-2024', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 396, 248);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (287, to_date('01-04-2024', 'dd-mm-yyyy'), to_date('23-02-2023', 'dd-mm-yyyy'), 5, 367);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (288, to_date('05-12-2024', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 445, 318);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (289, to_date('23-06-2024', 'dd-mm-yyyy'), to_date('20-03-2023', 'dd-mm-yyyy'), 422, 115);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (290, to_date('13-12-2024', 'dd-mm-yyyy'), to_date('25-12-2023', 'dd-mm-yyyy'), 72, 174);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (291, to_date('24-08-2024', 'dd-mm-yyyy'), to_date('12-01-2023', 'dd-mm-yyyy'), 188, 71);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (292, to_date('13-08-2024', 'dd-mm-yyyy'), to_date('01-11-2023', 'dd-mm-yyyy'), 395, 111);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (293, to_date('26-04-2024', 'dd-mm-yyyy'), to_date('05-06-2023', 'dd-mm-yyyy'), 470, 466);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (294, to_date('24-11-2024', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 35, 230);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (295, to_date('11-09-2024', 'dd-mm-yyyy'), to_date('07-04-2023', 'dd-mm-yyyy'), 49, 397);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (296, to_date('17-12-2024', 'dd-mm-yyyy'), to_date('15-07-2023', 'dd-mm-yyyy'), 59, 374);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (297, to_date('01-12-2024', 'dd-mm-yyyy'), to_date('22-11-2023', 'dd-mm-yyyy'), 467, 268);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (298, to_date('06-08-2024', 'dd-mm-yyyy'), to_date('28-12-2023', 'dd-mm-yyyy'), 477, 329);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (299, to_date('24-02-2024', 'dd-mm-yyyy'), to_date('22-08-2023', 'dd-mm-yyyy'), 210, 14);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (300, to_date('27-06-2024', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 450, 321);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (301, to_date('05-07-2024', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 163, 109);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (302, to_date('08-04-2024', 'dd-mm-yyyy'), to_date('16-08-2023', 'dd-mm-yyyy'), 157, 287);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (303, to_date('14-10-2024', 'dd-mm-yyyy'), to_date('06-02-2023', 'dd-mm-yyyy'), 136, 357);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (304, to_date('01-06-2024', 'dd-mm-yyyy'), to_date('22-01-2023', 'dd-mm-yyyy'), 307, 428);
commit;
prompt 300 records committed...
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (305, to_date('18-12-2024', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 88, 455);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (306, to_date('06-12-2024', 'dd-mm-yyyy'), to_date('14-03-2023', 'dd-mm-yyyy'), 282, 44);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (307, to_date('06-08-2024', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 502, 350);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (308, to_date('09-11-2024', 'dd-mm-yyyy'), to_date('14-02-2023', 'dd-mm-yyyy'), 487, 151);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (309, to_date('14-12-2024', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 389, 368);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (310, to_date('01-08-2024', 'dd-mm-yyyy'), to_date('01-07-2023', 'dd-mm-yyyy'), 310, 378);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (311, to_date('27-12-2024', 'dd-mm-yyyy'), to_date('18-05-2023', 'dd-mm-yyyy'), 3, 127);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (312, to_date('28-12-2024', 'dd-mm-yyyy'), to_date('23-03-2023', 'dd-mm-yyyy'), 274, 146);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (313, to_date('22-02-2024', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 167, 231);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (314, to_date('22-05-2024', 'dd-mm-yyyy'), to_date('28-02-2023', 'dd-mm-yyyy'), 318, 128);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (315, to_date('10-12-2024', 'dd-mm-yyyy'), to_date('22-03-2023', 'dd-mm-yyyy'), 251, 246);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (316, to_date('08-04-2024', 'dd-mm-yyyy'), to_date('23-11-2023', 'dd-mm-yyyy'), 245, 488);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (317, to_date('23-05-2024', 'dd-mm-yyyy'), to_date('14-12-2023', 'dd-mm-yyyy'), 346, 458);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (318, to_date('16-11-2024', 'dd-mm-yyyy'), to_date('06-08-2023', 'dd-mm-yyyy'), 337, 408);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (319, to_date('23-03-2024', 'dd-mm-yyyy'), to_date('31-01-2023', 'dd-mm-yyyy'), 57, 411);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (320, to_date('02-08-2024', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 98, 388);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (321, to_date('04-12-2024', 'dd-mm-yyyy'), to_date('09-06-2023', 'dd-mm-yyyy'), 489, 222);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (322, to_date('09-02-2024', 'dd-mm-yyyy'), to_date('11-12-2023', 'dd-mm-yyyy'), 195, 332);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (323, to_date('29-07-2024', 'dd-mm-yyyy'), to_date('02-09-2023', 'dd-mm-yyyy'), 327, 189);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (324, to_date('24-06-2024', 'dd-mm-yyyy'), to_date('05-04-2023', 'dd-mm-yyyy'), 5, 414);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (325, to_date('12-07-2024', 'dd-mm-yyyy'), to_date('31-07-2023', 'dd-mm-yyyy'), 154, 167);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (326, to_date('21-11-2024', 'dd-mm-yyyy'), to_date('31-12-2023', 'dd-mm-yyyy'), 371, 226);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (327, to_date('16-11-2024', 'dd-mm-yyyy'), to_date('20-06-2023', 'dd-mm-yyyy'), 366, 231);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (328, to_date('22-04-2024', 'dd-mm-yyyy'), to_date('09-01-2023', 'dd-mm-yyyy'), 457, 208);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (329, to_date('26-09-2024', 'dd-mm-yyyy'), to_date('04-08-2023', 'dd-mm-yyyy'), 249, 127);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (330, to_date('07-12-2024', 'dd-mm-yyyy'), to_date('21-02-2023', 'dd-mm-yyyy'), 319, 354);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (331, to_date('09-05-2024', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 248, 489);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (332, to_date('11-06-2024', 'dd-mm-yyyy'), to_date('16-05-2023', 'dd-mm-yyyy'), 87, 207);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (333, to_date('06-01-2024', 'dd-mm-yyyy'), to_date('10-05-2023', 'dd-mm-yyyy'), 352, 350);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (334, to_date('25-01-2024', 'dd-mm-yyyy'), to_date('18-04-2023', 'dd-mm-yyyy'), 333, 129);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (335, to_date('07-10-2024', 'dd-mm-yyyy'), to_date('17-01-2023', 'dd-mm-yyyy'), 152, 432);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (336, to_date('17-06-2024', 'dd-mm-yyyy'), to_date('18-06-2023', 'dd-mm-yyyy'), 53, 357);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (337, to_date('15-12-2024', 'dd-mm-yyyy'), to_date('17-05-2023', 'dd-mm-yyyy'), 68, 211);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (338, to_date('29-05-2024', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 377, 337);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (339, to_date('31-07-2024', 'dd-mm-yyyy'), to_date('21-01-2023', 'dd-mm-yyyy'), 205, 272);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (340, to_date('26-04-2024', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 348, 339);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (341, to_date('15-06-2024', 'dd-mm-yyyy'), to_date('09-09-2023', 'dd-mm-yyyy'), 384, 435);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (342, to_date('22-07-2024', 'dd-mm-yyyy'), to_date('07-08-2023', 'dd-mm-yyyy'), 435, 356);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (343, to_date('05-03-2024', 'dd-mm-yyyy'), to_date('09-08-2023', 'dd-mm-yyyy'), 321, 176);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (344, to_date('22-07-2024', 'dd-mm-yyyy'), to_date('25-02-2023', 'dd-mm-yyyy'), 148, 281);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (345, to_date('30-11-2024', 'dd-mm-yyyy'), to_date('30-10-2023', 'dd-mm-yyyy'), 482, 313);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (346, to_date('12-10-2024', 'dd-mm-yyyy'), to_date('07-09-2023', 'dd-mm-yyyy'), 351, 370);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (347, to_date('06-01-2024', 'dd-mm-yyyy'), to_date('23-01-2023', 'dd-mm-yyyy'), 49, 488);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (348, to_date('20-06-2024', 'dd-mm-yyyy'), to_date('09-07-2023', 'dd-mm-yyyy'), 178, 481);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (349, to_date('30-05-2024', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 109, 420);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (350, to_date('16-03-2024', 'dd-mm-yyyy'), to_date('13-07-2023', 'dd-mm-yyyy'), 174, 94);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (351, to_date('04-11-2024', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 428, 447);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (352, to_date('21-04-2024', 'dd-mm-yyyy'), to_date('15-01-2023', 'dd-mm-yyyy'), 28, 121);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (353, to_date('25-11-2024', 'dd-mm-yyyy'), to_date('03-10-2023', 'dd-mm-yyyy'), 424, 339);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (354, to_date('01-01-2024', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 6, 487);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (355, to_date('14-11-2024', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 300, 405);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (356, to_date('15-06-2024', 'dd-mm-yyyy'), to_date('10-12-2023', 'dd-mm-yyyy'), 16, 494);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (357, to_date('24-05-2024', 'dd-mm-yyyy'), to_date('19-06-2023', 'dd-mm-yyyy'), 311, 373);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (358, to_date('27-07-2024', 'dd-mm-yyyy'), to_date('27-03-2023', 'dd-mm-yyyy'), 344, 474);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (359, to_date('15-12-2024', 'dd-mm-yyyy'), to_date('14-02-2023', 'dd-mm-yyyy'), 191, 49);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (360, to_date('17-08-2024', 'dd-mm-yyyy'), to_date('29-01-2023', 'dd-mm-yyyy'), 24, 213);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (361, to_date('25-02-2024', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 256, 268);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (362, to_date('23-09-2024', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 412, 165);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (363, to_date('21-10-2024', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 132, 114);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (364, to_date('18-01-2024', 'dd-mm-yyyy'), to_date('15-11-2023', 'dd-mm-yyyy'), 342, 438);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (365, to_date('13-11-2024', 'dd-mm-yyyy'), to_date('19-07-2023', 'dd-mm-yyyy'), 173, 430);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (366, to_date('27-11-2024', 'dd-mm-yyyy'), to_date('14-05-2023', 'dd-mm-yyyy'), 16, 72);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (367, to_date('25-02-2024', 'dd-mm-yyyy'), to_date('22-12-2023', 'dd-mm-yyyy'), 4, 107);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (368, to_date('22-08-2024', 'dd-mm-yyyy'), to_date('30-03-2023', 'dd-mm-yyyy'), 4, 89);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (369, to_date('10-11-2024', 'dd-mm-yyyy'), to_date('24-01-2023', 'dd-mm-yyyy'), 253, 147);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (370, to_date('26-04-2024', 'dd-mm-yyyy'), to_date('14-11-2023', 'dd-mm-yyyy'), 404, 329);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (371, to_date('10-12-2024', 'dd-mm-yyyy'), to_date('15-04-2023', 'dd-mm-yyyy'), 396, 23);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (372, to_date('20-03-2024', 'dd-mm-yyyy'), to_date('19-07-2023', 'dd-mm-yyyy'), 159, 68);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (373, to_date('02-04-2024', 'dd-mm-yyyy'), to_date('15-06-2023', 'dd-mm-yyyy'), 304, 302);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (374, to_date('02-03-2024', 'dd-mm-yyyy'), to_date('05-02-2023', 'dd-mm-yyyy'), 64, 411);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (375, to_date('11-07-2024', 'dd-mm-yyyy'), to_date('05-08-2023', 'dd-mm-yyyy'), 423, 65);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (376, to_date('01-09-2024', 'dd-mm-yyyy'), to_date('09-07-2023', 'dd-mm-yyyy'), 380, 476);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (377, to_date('02-03-2024', 'dd-mm-yyyy'), to_date('18-11-2023', 'dd-mm-yyyy'), 98, 97);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (378, to_date('30-10-2024', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 120, 350);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (379, to_date('06-11-2024', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 93, 363);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (380, to_date('21-02-2024', 'dd-mm-yyyy'), to_date('18-03-2023', 'dd-mm-yyyy'), 24, 333);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (381, to_date('01-12-2024', 'dd-mm-yyyy'), to_date('04-06-2023', 'dd-mm-yyyy'), 219, 267);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (382, to_date('10-01-2024', 'dd-mm-yyyy'), to_date('11-02-2023', 'dd-mm-yyyy'), 140, 457);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (383, to_date('18-08-2024', 'dd-mm-yyyy'), to_date('03-02-2023', 'dd-mm-yyyy'), 150, 189);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (384, to_date('26-03-2024', 'dd-mm-yyyy'), to_date('30-11-2023', 'dd-mm-yyyy'), 89, 296);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (385, to_date('06-03-2024', 'dd-mm-yyyy'), to_date('13-01-2023', 'dd-mm-yyyy'), 396, 304);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (386, to_date('11-01-2024', 'dd-mm-yyyy'), to_date('26-06-2023', 'dd-mm-yyyy'), 496, 41);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (387, to_date('21-07-2024', 'dd-mm-yyyy'), to_date('30-05-2023', 'dd-mm-yyyy'), 404, 183);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (388, to_date('10-03-2024', 'dd-mm-yyyy'), to_date('13-02-2023', 'dd-mm-yyyy'), 31, 377);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (389, to_date('10-03-2024', 'dd-mm-yyyy'), to_date('15-06-2023', 'dd-mm-yyyy'), 353, 173);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (390, to_date('03-11-2024', 'dd-mm-yyyy'), to_date('15-08-2023', 'dd-mm-yyyy'), 190, 124);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (391, to_date('16-06-2024', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 74, 64);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (392, to_date('26-01-2024', 'dd-mm-yyyy'), to_date('11-06-2023', 'dd-mm-yyyy'), 127, 166);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (393, to_date('09-12-2024', 'dd-mm-yyyy'), to_date('28-02-2023', 'dd-mm-yyyy'), 154, 30);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (394, to_date('19-05-2024', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 232, 163);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (395, to_date('11-07-2024', 'dd-mm-yyyy'), to_date('07-05-2023', 'dd-mm-yyyy'), 157, 355);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (396, to_date('13-12-2024', 'dd-mm-yyyy'), to_date('23-07-2023', 'dd-mm-yyyy'), 311, 43);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (397, to_date('06-05-2024', 'dd-mm-yyyy'), to_date('21-04-2023', 'dd-mm-yyyy'), 47, 441);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (398, to_date('06-09-2024', 'dd-mm-yyyy'), to_date('02-05-2023', 'dd-mm-yyyy'), 449, 269);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (399, to_date('19-06-2024', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 240, 96);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (400, to_date('08-02-2024', 'dd-mm-yyyy'), to_date('22-02-2023', 'dd-mm-yyyy'), 13, 400);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (401, to_date('14-06-2024', 'dd-mm-yyyy'), to_date('26-08-2023', 'dd-mm-yyyy'), 308, 102);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (402, to_date('22-01-2024', 'dd-mm-yyyy'), to_date('02-04-2023', 'dd-mm-yyyy'), 342, 422);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (403, to_date('14-09-2024', 'dd-mm-yyyy'), to_date('23-06-2023', 'dd-mm-yyyy'), 361, 68);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (404, to_date('14-03-2024', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 25, 364);
commit;
prompt 400 records committed...
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (405, to_date('13-08-2024', 'dd-mm-yyyy'), to_date('04-07-2023', 'dd-mm-yyyy'), 68, 59);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (406, to_date('27-04-2024', 'dd-mm-yyyy'), to_date('28-06-2023', 'dd-mm-yyyy'), 437, 195);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (407, to_date('25-07-2024', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 351, 10);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (408, to_date('23-06-2024', 'dd-mm-yyyy'), to_date('25-01-2023', 'dd-mm-yyyy'), 319, 7);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (409, to_date('06-09-2024', 'dd-mm-yyyy'), to_date('01-09-2023', 'dd-mm-yyyy'), 193, 422);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (410, to_date('08-12-2024', 'dd-mm-yyyy'), to_date('16-03-2023', 'dd-mm-yyyy'), 112, 468);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (411, to_date('19-06-2024', 'dd-mm-yyyy'), to_date('02-02-2023', 'dd-mm-yyyy'), 173, 335);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (412, to_date('06-12-2024', 'dd-mm-yyyy'), to_date('15-03-2023', 'dd-mm-yyyy'), 395, 72);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (413, to_date('08-03-2024', 'dd-mm-yyyy'), to_date('10-05-2023', 'dd-mm-yyyy'), 89, 88);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (414, to_date('26-03-2024', 'dd-mm-yyyy'), to_date('02-11-2023', 'dd-mm-yyyy'), 468, 151);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (415, to_date('08-02-2024', 'dd-mm-yyyy'), to_date('26-05-2023', 'dd-mm-yyyy'), 278, 353);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (416, to_date('09-07-2024', 'dd-mm-yyyy'), to_date('12-04-2023', 'dd-mm-yyyy'), 137, 188);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (417, to_date('13-07-2024', 'dd-mm-yyyy'), to_date('22-02-2023', 'dd-mm-yyyy'), 71, 459);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (418, to_date('02-08-2024', 'dd-mm-yyyy'), to_date('17-01-2023', 'dd-mm-yyyy'), 130, 398);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (419, to_date('25-08-2024', 'dd-mm-yyyy'), to_date('30-09-2023', 'dd-mm-yyyy'), 431, 487);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (420, to_date('01-05-2024', 'dd-mm-yyyy'), to_date('15-01-2023', 'dd-mm-yyyy'), 155, 92);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (421, to_date('09-03-2024', 'dd-mm-yyyy'), to_date('29-11-2023', 'dd-mm-yyyy'), 197, 158);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (422, to_date('06-08-2024', 'dd-mm-yyyy'), to_date('23-08-2023', 'dd-mm-yyyy'), 140, 330);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (423, to_date('28-11-2024', 'dd-mm-yyyy'), to_date('05-04-2023', 'dd-mm-yyyy'), 58, 492);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (424, to_date('12-10-2024', 'dd-mm-yyyy'), to_date('10-11-2023', 'dd-mm-yyyy'), 116, 344);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (425, to_date('13-11-2024', 'dd-mm-yyyy'), to_date('07-10-2023', 'dd-mm-yyyy'), 112, 253);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (426, to_date('15-04-2024', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 264, 252);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (427, to_date('17-07-2024', 'dd-mm-yyyy'), to_date('07-04-2023', 'dd-mm-yyyy'), 115, 176);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (428, to_date('17-10-2024', 'dd-mm-yyyy'), to_date('02-09-2023', 'dd-mm-yyyy'), 100, 48);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (429, to_date('20-09-2024', 'dd-mm-yyyy'), to_date('31-12-2023', 'dd-mm-yyyy'), 397, 471);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (430, to_date('17-04-2024', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 351, 372);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (431, to_date('27-03-2024', 'dd-mm-yyyy'), to_date('30-03-2023', 'dd-mm-yyyy'), 398, 114);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (432, to_date('31-12-2024', 'dd-mm-yyyy'), to_date('28-11-2023', 'dd-mm-yyyy'), 441, 69);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (433, to_date('05-07-2024', 'dd-mm-yyyy'), to_date('31-12-2023', 'dd-mm-yyyy'), 401, 416);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (434, to_date('12-01-2024', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 172, 19);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (435, to_date('21-11-2024', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 396, 373);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (436, to_date('30-11-2024', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 55, 255);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (437, to_date('26-10-2024', 'dd-mm-yyyy'), to_date('18-03-2023', 'dd-mm-yyyy'), 98, 295);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (438, to_date('27-11-2024', 'dd-mm-yyyy'), to_date('07-04-2023', 'dd-mm-yyyy'), 274, 361);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (439, to_date('22-10-2024', 'dd-mm-yyyy'), to_date('27-04-2023', 'dd-mm-yyyy'), 149, 225);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (440, to_date('16-02-2024', 'dd-mm-yyyy'), to_date('16-07-2023', 'dd-mm-yyyy'), 323, 151);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (441, to_date('22-03-2024', 'dd-mm-yyyy'), to_date('23-01-2023', 'dd-mm-yyyy'), 434, 129);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (442, to_date('30-06-2024', 'dd-mm-yyyy'), to_date('09-03-2023', 'dd-mm-yyyy'), 307, 128);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (443, to_date('20-11-2024', 'dd-mm-yyyy'), to_date('07-07-2023', 'dd-mm-yyyy'), 83, 371);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (444, to_date('29-06-2024', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 387, 225);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (445, to_date('25-06-2024', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 141, 474);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (446, to_date('22-09-2024', 'dd-mm-yyyy'), to_date('12-03-2023', 'dd-mm-yyyy'), 381, 327);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (447, to_date('18-10-2024', 'dd-mm-yyyy'), to_date('24-09-2023', 'dd-mm-yyyy'), 350, 154);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (448, to_date('24-04-2024', 'dd-mm-yyyy'), to_date('16-11-2023', 'dd-mm-yyyy'), 24, 77);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (449, to_date('25-09-2024', 'dd-mm-yyyy'), to_date('12-12-2023', 'dd-mm-yyyy'), 122, 142);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (450, to_date('27-01-2024', 'dd-mm-yyyy'), to_date('15-06-2023', 'dd-mm-yyyy'), 403, 459);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (451, to_date('06-03-2024', 'dd-mm-yyyy'), to_date('20-03-2023', 'dd-mm-yyyy'), 169, 283);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (452, to_date('12-07-2024', 'dd-mm-yyyy'), to_date('10-12-2023', 'dd-mm-yyyy'), 495, 166);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (453, to_date('30-08-2024', 'dd-mm-yyyy'), to_date('15-03-2023', 'dd-mm-yyyy'), 266, 418);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (454, to_date('27-09-2024', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 427, 244);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (455, to_date('29-10-2024', 'dd-mm-yyyy'), to_date('22-12-2023', 'dd-mm-yyyy'), 186, 48);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (456, to_date('28-11-2024', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 351, 25);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (457, to_date('18-09-2024', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 299, 278);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (458, to_date('07-11-2024', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 489, 334);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (459, to_date('15-11-2024', 'dd-mm-yyyy'), to_date('21-09-2023', 'dd-mm-yyyy'), 302, 42);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (460, to_date('25-03-2024', 'dd-mm-yyyy'), to_date('13-06-2023', 'dd-mm-yyyy'), 322, 481);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (461, to_date('05-04-2024', 'dd-mm-yyyy'), to_date('29-12-2023', 'dd-mm-yyyy'), 130, 110);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (462, to_date('22-08-2024', 'dd-mm-yyyy'), to_date('01-12-2023', 'dd-mm-yyyy'), 459, 34);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (463, to_date('24-12-2024', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 16, 376);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (464, to_date('23-06-2024', 'dd-mm-yyyy'), to_date('11-04-2023', 'dd-mm-yyyy'), 130, 372);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (465, to_date('19-10-2024', 'dd-mm-yyyy'), to_date('23-12-2023', 'dd-mm-yyyy'), 199, 429);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (466, to_date('19-08-2024', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 379, 21);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (467, to_date('10-07-2024', 'dd-mm-yyyy'), to_date('11-03-2023', 'dd-mm-yyyy'), 292, 401);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (468, to_date('03-01-2024', 'dd-mm-yyyy'), to_date('06-09-2023', 'dd-mm-yyyy'), 353, 268);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (469, to_date('19-02-2024', 'dd-mm-yyyy'), to_date('07-12-2023', 'dd-mm-yyyy'), 311, 101);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (470, to_date('30-10-2024', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 312, 61);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (471, to_date('13-10-2024', 'dd-mm-yyyy'), to_date('18-04-2023', 'dd-mm-yyyy'), 365, 426);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (472, to_date('09-10-2024', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 246, 188);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (473, to_date('26-07-2024', 'dd-mm-yyyy'), to_date('04-12-2023', 'dd-mm-yyyy'), 485, 57);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (474, to_date('28-11-2024', 'dd-mm-yyyy'), to_date('20-08-2023', 'dd-mm-yyyy'), 179, 232);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (475, to_date('19-02-2024', 'dd-mm-yyyy'), to_date('13-01-2023', 'dd-mm-yyyy'), 116, 434);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (476, to_date('20-06-2024', 'dd-mm-yyyy'), to_date('27-01-2023', 'dd-mm-yyyy'), 107, 320);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (477, to_date('02-02-2024', 'dd-mm-yyyy'), to_date('10-06-2023', 'dd-mm-yyyy'), 292, 14);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (478, to_date('27-05-2024', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 110, 137);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (479, to_date('23-03-2024', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 410, 306);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (480, to_date('04-10-2024', 'dd-mm-yyyy'), to_date('14-06-2023', 'dd-mm-yyyy'), 110, 239);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (481, to_date('22-07-2024', 'dd-mm-yyyy'), to_date('26-04-2023', 'dd-mm-yyyy'), 214, 194);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (482, to_date('20-11-2024', 'dd-mm-yyyy'), to_date('16-09-2023', 'dd-mm-yyyy'), 286, 128);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (483, to_date('03-03-2024', 'dd-mm-yyyy'), to_date('07-12-2023', 'dd-mm-yyyy'), 421, 35);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (484, to_date('06-06-2024', 'dd-mm-yyyy'), to_date('26-01-2023', 'dd-mm-yyyy'), 148, 126);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (485, to_date('21-11-2024', 'dd-mm-yyyy'), to_date('12-09-2023', 'dd-mm-yyyy'), 476, 42);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (486, to_date('01-03-2024', 'dd-mm-yyyy'), to_date('28-07-2023', 'dd-mm-yyyy'), 273, 19);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (487, to_date('28-09-2024', 'dd-mm-yyyy'), to_date('11-08-2023', 'dd-mm-yyyy'), 502, 447);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (488, to_date('09-08-2024', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 180, 486);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (489, to_date('02-04-2024', 'dd-mm-yyyy'), to_date('18-12-2023', 'dd-mm-yyyy'), 381, 445);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (490, to_date('19-06-2024', 'dd-mm-yyyy'), to_date('10-03-2023', 'dd-mm-yyyy'), 382, 311);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (491, to_date('18-07-2024', 'dd-mm-yyyy'), to_date('01-11-2023', 'dd-mm-yyyy'), 3, 419);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (492, to_date('29-11-2024', 'dd-mm-yyyy'), to_date('20-02-2023', 'dd-mm-yyyy'), 72, 369);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (493, to_date('01-04-2024', 'dd-mm-yyyy'), to_date('29-08-2023', 'dd-mm-yyyy'), 173, 448);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (494, to_date('15-08-2024', 'dd-mm-yyyy'), to_date('09-07-2023', 'dd-mm-yyyy'), 500, 406);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (495, to_date('22-03-2024', 'dd-mm-yyyy'), to_date('04-11-2023', 'dd-mm-yyyy'), 148, 97);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (496, to_date('05-09-2024', 'dd-mm-yyyy'), to_date('28-12-2023', 'dd-mm-yyyy'), 450, 87);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (497, to_date('06-02-2024', 'dd-mm-yyyy'), to_date('14-06-2023', 'dd-mm-yyyy'), 376, 481);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (498, to_date('04-04-2024', 'dd-mm-yyyy'), to_date('29-06-2023', 'dd-mm-yyyy'), 439, 331);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (499, to_date('17-08-2024', 'dd-mm-yyyy'), to_date('14-12-2023', 'dd-mm-yyyy'), 343, 119);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (500, to_date('17-02-2024', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 18, 513);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (501, to_date('11-01-2027', 'dd-mm-yyyy'), to_date('11-01-2024', 'dd-mm-yyyy'), 506, 1);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (502, to_date('11-11-2027', 'dd-mm-yyyy'), to_date('11-01-2024', 'dd-mm-yyyy'), 507, 1);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (503, to_date('03-01-2027', 'dd-mm-yyyy'), to_date('11-01-2024', 'dd-mm-yyyy'), 2, 3);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (504, to_date('07-11-2027', 'dd-mm-yyyy'), to_date('11-01-2024', 'dd-mm-yyyy'), 3, 2);
commit;
prompt 500 records committed...
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (505, to_date('09-09-2027', 'dd-mm-yyyy'), to_date('11-01-2027', 'dd-mm-yyyy'), 4, 6);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (506, to_date('08-03-2027', 'dd-mm-yyyy'), to_date('11-01-2027', 'dd-mm-yyyy'), 5, 1);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (507, to_date('06-02-2027', 'dd-mm-yyyy'), to_date('11-03-2027', 'dd-mm-yyyy'), 6, 8);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (508, to_date('04-01-2027', 'dd-mm-yyyy'), to_date('11-05-2027', 'dd-mm-yyyy'), 7, 1);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (509, to_date('01-11-2027', 'dd-mm-yyyy'), to_date('11-07-2027', 'dd-mm-yyyy'), 8, 2);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (510, to_date('02-11-2027', 'dd-mm-yyyy'), to_date('11-08-2027', 'dd-mm-yyyy'), 9, 1);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (601, to_date('16-06-2025 21:04:42', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-06-2024 21:04:42', 'dd-mm-yyyy hh24:mi:ss'), 101, 501);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (530, to_date('01-07-2024', 'dd-mm-yyyy'), to_date('01-07-2022', 'dd-mm-yyyy'), 165, 604);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (531, to_date('01-07-2024', 'dd-mm-yyyy'), to_date('01-07-2022', 'dd-mm-yyyy'), 165, null);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (604, to_date('16-06-2025 21:06:07', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-06-2024 21:06:07', 'dd-mm-yyyy hh24:mi:ss'), 101, 602);
insert into EQUIPMENT (eqserialnumber, validity, lastuse, catserialnumber, oserialnumber)
values (520, to_date('01-07-2024', 'dd-mm-yyyy'), to_date('01-07-2022', 'dd-mm-yyyy'), 165, 603);
commit;
prompt 511 records loaded
prompt Loading LOANS...
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (1, to_date('11-08-2022', 'dd-mm-yyyy'), 2, to_date('04-08-2023', 'dd-mm-yyyy'), 323, 357);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (2, to_date('10-08-2022', 'dd-mm-yyyy'), 1, to_date('03-01-2023', 'dd-mm-yyyy'), 56, 66);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (4, to_date('18-09-2022', 'dd-mm-yyyy'), 3, to_date('30-05-2023', 'dd-mm-yyyy'), 344, 119);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (5, to_date('10-05-2022', 'dd-mm-yyyy'), 3, to_date('27-10-2023', 'dd-mm-yyyy'), 123, 370);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (6, to_date('11-08-2022', 'dd-mm-yyyy'), 1, to_date('14-08-2023', 'dd-mm-yyyy'), 492, 133);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (7, to_date('14-12-2022', 'dd-mm-yyyy'), 1, to_date('13-08-2023', 'dd-mm-yyyy'), 30, 443);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (9, to_date('21-06-2022', 'dd-mm-yyyy'), 1, to_date('27-05-2023', 'dd-mm-yyyy'), 13, 77);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (11, to_date('28-07-2022', 'dd-mm-yyyy'), 3, to_date('30-08-2023', 'dd-mm-yyyy'), 313, 330);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (12, to_date('16-08-2022', 'dd-mm-yyyy'), 1, to_date('24-10-2023', 'dd-mm-yyyy'), 18, 171);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (13, to_date('16-12-2022', 'dd-mm-yyyy'), 2, to_date('13-04-2023', 'dd-mm-yyyy'), 236, 95);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (14, to_date('09-11-2022', 'dd-mm-yyyy'), 1, to_date('10-09-2023', 'dd-mm-yyyy'), 237, 98);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (18, to_date('13-10-2022', 'dd-mm-yyyy'), 2, to_date('09-07-2023', 'dd-mm-yyyy'), 489, 155);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (20, to_date('24-04-2022', 'dd-mm-yyyy'), 1, to_date('12-03-2023', 'dd-mm-yyyy'), 416, 371);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (22, to_date('31-01-2022', 'dd-mm-yyyy'), 3, to_date('07-07-2023', 'dd-mm-yyyy'), 105, 372);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (23, to_date('06-05-2022', 'dd-mm-yyyy'), 2, to_date('18-01-2023', 'dd-mm-yyyy'), 144, 488);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (24, to_date('20-11-2022', 'dd-mm-yyyy'), 1, to_date('23-11-2023', 'dd-mm-yyyy'), 390, 61);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (26, to_date('23-12-2022', 'dd-mm-yyyy'), 3, to_date('29-05-2023', 'dd-mm-yyyy'), 113, 262);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (28, to_date('15-11-2022', 'dd-mm-yyyy'), 1, to_date('13-08-2023', 'dd-mm-yyyy'), 124, 291);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (29, to_date('22-04-2022', 'dd-mm-yyyy'), 1, to_date('12-03-2023', 'dd-mm-yyyy'), 77, 105);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (30, to_date('18-03-2022', 'dd-mm-yyyy'), 2, to_date('30-04-2023', 'dd-mm-yyyy'), 459, 16);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (31, to_date('02-04-2022', 'dd-mm-yyyy'), 3, to_date('01-06-2023', 'dd-mm-yyyy'), 144, 334);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (34, to_date('12-11-2022', 'dd-mm-yyyy'), 2, to_date('30-03-2023', 'dd-mm-yyyy'), 54, 65);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (35, to_date('04-11-2022', 'dd-mm-yyyy'), 2, to_date('12-06-2023', 'dd-mm-yyyy'), 184, 389);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (37, to_date('30-07-2022', 'dd-mm-yyyy'), 3, to_date('26-11-2023', 'dd-mm-yyyy'), 416, 317);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (38, to_date('26-04-2022', 'dd-mm-yyyy'), 3, to_date('28-05-2023', 'dd-mm-yyyy'), 385, 487);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (39, to_date('24-02-2022', 'dd-mm-yyyy'), 2, to_date('06-08-2023', 'dd-mm-yyyy'), 264, 245);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (40, to_date('22-02-2022', 'dd-mm-yyyy'), 2, to_date('14-05-2023', 'dd-mm-yyyy'), 270, 301);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (41, to_date('14-08-2022', 'dd-mm-yyyy'), 3, to_date('13-04-2023', 'dd-mm-yyyy'), 164, 182);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (42, to_date('07-08-2022', 'dd-mm-yyyy'), 1, to_date('13-09-2023', 'dd-mm-yyyy'), 347, 19);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (44, to_date('18-12-2022', 'dd-mm-yyyy'), 1, to_date('30-09-2023', 'dd-mm-yyyy'), 106, 216);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (45, to_date('06-03-2022', 'dd-mm-yyyy'), 1, to_date('31-10-2023', 'dd-mm-yyyy'), 369, 183);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (46, to_date('20-08-2022', 'dd-mm-yyyy'), 1, to_date('30-12-2023', 'dd-mm-yyyy'), 70, 27);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (48, to_date('11-01-2022', 'dd-mm-yyyy'), 1, to_date('18-06-2023', 'dd-mm-yyyy'), 215, 217);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (49, to_date('11-03-2022', 'dd-mm-yyyy'), 2, to_date('23-12-2023', 'dd-mm-yyyy'), 117, 275);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (51, to_date('02-04-2022', 'dd-mm-yyyy'), 1, to_date('26-10-2023', 'dd-mm-yyyy'), 487, 6);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (52, to_date('04-07-2022', 'dd-mm-yyyy'), 2, to_date('10-08-2023', 'dd-mm-yyyy'), 145, 486);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (53, to_date('16-09-2022', 'dd-mm-yyyy'), 1, to_date('16-11-2023', 'dd-mm-yyyy'), 479, 496);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (55, to_date('22-01-2022', 'dd-mm-yyyy'), 1, to_date('19-07-2023', 'dd-mm-yyyy'), 66, 395);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (56, to_date('03-06-2022', 'dd-mm-yyyy'), 2, to_date('07-02-2023', 'dd-mm-yyyy'), 428, 138);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (57, to_date('06-02-2022', 'dd-mm-yyyy'), 1, to_date('17-11-2023', 'dd-mm-yyyy'), 198, 332);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (58, to_date('10-04-2022', 'dd-mm-yyyy'), 2, to_date('30-06-2023', 'dd-mm-yyyy'), 235, 209);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (60, to_date('11-02-2022', 'dd-mm-yyyy'), 2, to_date('13-08-2023', 'dd-mm-yyyy'), 44, 116);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (61, to_date('27-12-2022', 'dd-mm-yyyy'), 3, to_date('17-07-2023', 'dd-mm-yyyy'), 368, 101);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (64, to_date('01-04-2022', 'dd-mm-yyyy'), 1, to_date('20-08-2023', 'dd-mm-yyyy'), 401, 191);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (66, to_date('19-07-2022', 'dd-mm-yyyy'), 2, to_date('30-07-2023', 'dd-mm-yyyy'), 196, 265);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (69, to_date('25-02-2022', 'dd-mm-yyyy'), 2, to_date('25-03-2023', 'dd-mm-yyyy'), 417, 290);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (70, to_date('11-03-2022', 'dd-mm-yyyy'), 1, to_date('02-10-2023', 'dd-mm-yyyy'), 374, 327);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (71, to_date('20-04-2022', 'dd-mm-yyyy'), 3, to_date('30-06-2023', 'dd-mm-yyyy'), 488, 437);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (74, to_date('15-09-2022', 'dd-mm-yyyy'), 2, to_date('20-01-2023', 'dd-mm-yyyy'), 434, 80);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (75, to_date('23-08-2022', 'dd-mm-yyyy'), 3, to_date('07-10-2023', 'dd-mm-yyyy'), 394, 352);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (77, to_date('12-11-2022', 'dd-mm-yyyy'), 3, to_date('25-01-2023', 'dd-mm-yyyy'), 348, 223);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (78, to_date('10-03-2022', 'dd-mm-yyyy'), 3, to_date('01-04-2023', 'dd-mm-yyyy'), 460, 168);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (79, to_date('20-04-2022', 'dd-mm-yyyy'), 2, to_date('31-08-2023', 'dd-mm-yyyy'), 422, 455);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (80, to_date('18-06-2022', 'dd-mm-yyyy'), 2, to_date('11-01-2023', 'dd-mm-yyyy'), 238, 60);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (81, to_date('16-01-2022', 'dd-mm-yyyy'), 3, to_date('31-10-2023', 'dd-mm-yyyy'), 361, 420);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (83, to_date('14-08-2022', 'dd-mm-yyyy'), 1, to_date('03-03-2023', 'dd-mm-yyyy'), 65, 131);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (84, to_date('28-07-2022', 'dd-mm-yyyy'), 2, to_date('20-04-2023', 'dd-mm-yyyy'), 219, 391);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (85, to_date('03-09-2022', 'dd-mm-yyyy'), 3, to_date('07-05-2023', 'dd-mm-yyyy'), 167, 149);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (89, to_date('02-11-2022', 'dd-mm-yyyy'), 2, to_date('06-06-2023', 'dd-mm-yyyy'), 67, 207);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (90, to_date('27-05-2022', 'dd-mm-yyyy'), 1, to_date('09-09-2023', 'dd-mm-yyyy'), 319, 84);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (93, to_date('28-06-2022', 'dd-mm-yyyy'), 3, to_date('10-06-2023', 'dd-mm-yyyy'), 191, 472);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (95, to_date('13-02-2022', 'dd-mm-yyyy'), 2, to_date('14-06-2023', 'dd-mm-yyyy'), 22, 58);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (96, to_date('14-08-2022', 'dd-mm-yyyy'), 3, to_date('06-04-2023', 'dd-mm-yyyy'), 124, 347);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (99, to_date('20-12-2022', 'dd-mm-yyyy'), 3, to_date('15-06-2023', 'dd-mm-yyyy'), 405, 197);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (100, to_date('02-03-2022', 'dd-mm-yyyy'), 3, to_date('27-06-2023', 'dd-mm-yyyy'), 5, 68);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (102, to_date('29-11-2022', 'dd-mm-yyyy'), 1, to_date('10-10-2023', 'dd-mm-yyyy'), 205, 448);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (103, to_date('19-08-2022', 'dd-mm-yyyy'), 3, to_date('18-01-2023', 'dd-mm-yyyy'), 228, 185);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (104, to_date('16-11-2022', 'dd-mm-yyyy'), 1, to_date('12-03-2023', 'dd-mm-yyyy'), 106, 5);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (105, to_date('12-02-2022', 'dd-mm-yyyy'), 2, to_date('27-11-2023', 'dd-mm-yyyy'), 331, 368);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (109, to_date('03-07-2022', 'dd-mm-yyyy'), 1, to_date('10-12-2023', 'dd-mm-yyyy'), 38, 122);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (110, to_date('07-11-2022', 'dd-mm-yyyy'), 1, to_date('19-12-2023', 'dd-mm-yyyy'), 57, 139);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (111, to_date('07-11-2022', 'dd-mm-yyyy'), 3, to_date('26-04-2023', 'dd-mm-yyyy'), 312, 214);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (113, to_date('28-02-2022', 'dd-mm-yyyy'), 2, to_date('23-06-2023', 'dd-mm-yyyy'), 359, 435);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (114, to_date('14-05-2022', 'dd-mm-yyyy'), 1, to_date('16-10-2023', 'dd-mm-yyyy'), 348, 174);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (116, to_date('30-06-2022', 'dd-mm-yyyy'), 3, to_date('25-06-2023', 'dd-mm-yyyy'), 430, 302);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (117, to_date('18-11-2022', 'dd-mm-yyyy'), 3, to_date('24-08-2023', 'dd-mm-yyyy'), 260, 303);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (119, to_date('16-07-2022', 'dd-mm-yyyy'), 3, to_date('22-06-2023', 'dd-mm-yyyy'), 220, 107);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (120, to_date('23-02-2022', 'dd-mm-yyyy'), 1, to_date('03-04-2023', 'dd-mm-yyyy'), 201, 193);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (121, to_date('15-07-2022', 'dd-mm-yyyy'), 2, to_date('10-01-2023', 'dd-mm-yyyy'), 317, 114);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (122, to_date('11-07-2022', 'dd-mm-yyyy'), 2, to_date('28-05-2023', 'dd-mm-yyyy'), 368, 294);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (123, to_date('13-12-2022', 'dd-mm-yyyy'), 2, to_date('23-04-2023', 'dd-mm-yyyy'), 316, 343);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (124, to_date('17-08-2022', 'dd-mm-yyyy'), 1, to_date('06-03-2023', 'dd-mm-yyyy'), 488, 129);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (125, to_date('26-02-2022', 'dd-mm-yyyy'), 2, to_date('18-12-2023', 'dd-mm-yyyy'), 177, 478);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (128, to_date('20-11-2022', 'dd-mm-yyyy'), 3, to_date('08-09-2023', 'dd-mm-yyyy'), 481, 124);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (129, to_date('22-07-2022', 'dd-mm-yyyy'), 2, to_date('17-06-2023', 'dd-mm-yyyy'), 470, 422);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (130, to_date('27-02-2022', 'dd-mm-yyyy'), 3, to_date('25-01-2023', 'dd-mm-yyyy'), 473, 218);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (131, to_date('08-02-2022', 'dd-mm-yyyy'), 1, to_date('24-04-2023', 'dd-mm-yyyy'), 252, 440);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (134, to_date('20-11-2022', 'dd-mm-yyyy'), 1, to_date('11-03-2023', 'dd-mm-yyyy'), 59, 436);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (135, to_date('01-03-2022', 'dd-mm-yyyy'), 2, to_date('20-05-2023', 'dd-mm-yyyy'), 214, 21);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (136, to_date('11-11-2022', 'dd-mm-yyyy'), 3, to_date('17-11-2023', 'dd-mm-yyyy'), 344, 25);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (137, to_date('19-03-2022', 'dd-mm-yyyy'), 1, to_date('17-03-2023', 'dd-mm-yyyy'), 214, 190);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (139, to_date('09-03-2022', 'dd-mm-yyyy'), 1, to_date('11-05-2023', 'dd-mm-yyyy'), 344, 258);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (140, to_date('20-05-2022', 'dd-mm-yyyy'), 3, to_date('23-05-2023', 'dd-mm-yyyy'), 75, 311);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (141, to_date('27-08-2022', 'dd-mm-yyyy'), 3, to_date('28-11-2023', 'dd-mm-yyyy'), 251, 153);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (142, to_date('07-07-2022', 'dd-mm-yyyy'), 2, to_date('28-10-2023', 'dd-mm-yyyy'), 387, 489);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (143, to_date('13-09-2022', 'dd-mm-yyyy'), 2, to_date('12-11-2023', 'dd-mm-yyyy'), 70, 315);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (144, to_date('19-01-2022', 'dd-mm-yyyy'), 2, to_date('24-07-2023', 'dd-mm-yyyy'), 484, 474);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (145, to_date('02-02-2022', 'dd-mm-yyyy'), 3, to_date('25-02-2023', 'dd-mm-yyyy'), 91, 414);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (146, to_date('26-07-2022', 'dd-mm-yyyy'), 3, to_date('20-06-2023', 'dd-mm-yyyy'), 266, 196);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (149, to_date('11-05-2022', 'dd-mm-yyyy'), 1, to_date('06-04-2023', 'dd-mm-yyyy'), 463, 494);
commit;
prompt 100 records committed...
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (150, to_date('19-11-2022', 'dd-mm-yyyy'), 1, to_date('28-11-2023', 'dd-mm-yyyy'), 449, 384);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (152, to_date('27-05-2022', 'dd-mm-yyyy'), 3, to_date('18-11-2023', 'dd-mm-yyyy'), 270, 313);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (153, to_date('18-03-2022', 'dd-mm-yyyy'), 1, to_date('29-06-2023', 'dd-mm-yyyy'), 435, 83);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (154, to_date('04-09-2022', 'dd-mm-yyyy'), 2, to_date('22-08-2023', 'dd-mm-yyyy'), 110, 134);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (155, to_date('12-09-2022', 'dd-mm-yyyy'), 1, to_date('27-06-2023', 'dd-mm-yyyy'), 165, 233);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (157, to_date('20-08-2022', 'dd-mm-yyyy'), 2, to_date('19-12-2023', 'dd-mm-yyyy'), 374, 274);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (158, to_date('07-05-2022', 'dd-mm-yyyy'), 2, to_date('07-11-2023', 'dd-mm-yyyy'), 279, 417);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (159, to_date('29-12-2022', 'dd-mm-yyyy'), 1, to_date('14-05-2023', 'dd-mm-yyyy'), 72, 482);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (160, to_date('01-12-2022', 'dd-mm-yyyy'), 1, to_date('14-07-2023', 'dd-mm-yyyy'), 268, 252);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (161, to_date('18-02-2022', 'dd-mm-yyyy'), 1, to_date('27-11-2023', 'dd-mm-yyyy'), 380, 450);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (162, to_date('18-11-2022', 'dd-mm-yyyy'), 1, to_date('21-06-2023', 'dd-mm-yyyy'), 321, 309);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (163, to_date('27-10-2022', 'dd-mm-yyyy'), 3, to_date('20-03-2023', 'dd-mm-yyyy'), 54, 250);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (164, to_date('17-02-2022', 'dd-mm-yyyy'), 1, to_date('20-03-2023', 'dd-mm-yyyy'), 333, 421);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (166, to_date('12-08-2022', 'dd-mm-yyyy'), 3, to_date('13-05-2023', 'dd-mm-yyyy'), 230, 92);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (167, to_date('27-02-2022', 'dd-mm-yyyy'), 3, to_date('23-06-2023', 'dd-mm-yyyy'), 297, 251);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (168, to_date('28-09-2022', 'dd-mm-yyyy'), 1, to_date('01-02-2023', 'dd-mm-yyyy'), 216, 203);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (169, to_date('08-02-2022', 'dd-mm-yyyy'), 2, to_date('21-11-2023', 'dd-mm-yyyy'), 481, 160);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (171, to_date('04-03-2022', 'dd-mm-yyyy'), 2, to_date('19-05-2023', 'dd-mm-yyyy'), 425, 53);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (172, to_date('28-05-2022', 'dd-mm-yyyy'), 3, to_date('20-07-2023', 'dd-mm-yyyy'), 159, 393);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (174, to_date('15-08-2022', 'dd-mm-yyyy'), 1, to_date('28-08-2023', 'dd-mm-yyyy'), 115, 390);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (175, to_date('23-09-2022', 'dd-mm-yyyy'), 2, to_date('03-06-2023', 'dd-mm-yyyy'), 444, 64);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (178, to_date('06-03-2022', 'dd-mm-yyyy'), 3, to_date('10-11-2023', 'dd-mm-yyyy'), 308, 110);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (179, to_date('17-09-2022', 'dd-mm-yyyy'), 2, to_date('22-02-2023', 'dd-mm-yyyy'), 423, 473);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (180, to_date('27-09-2022', 'dd-mm-yyyy'), 1, to_date('18-09-2023', 'dd-mm-yyyy'), 221, 39);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (182, to_date('01-03-2022', 'dd-mm-yyyy'), 3, to_date('27-03-2023', 'dd-mm-yyyy'), 484, 62);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (183, to_date('05-03-2022', 'dd-mm-yyyy'), 2, to_date('13-04-2023', 'dd-mm-yyyy'), 419, 113);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (185, to_date('20-04-2022', 'dd-mm-yyyy'), 3, to_date('05-09-2023', 'dd-mm-yyyy'), 66, 47);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (186, to_date('15-01-2022', 'dd-mm-yyyy'), 2, to_date('30-04-2023', 'dd-mm-yyyy'), 408, 136);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (189, to_date('15-05-2022', 'dd-mm-yyyy'), 3, to_date('21-07-2023', 'dd-mm-yyyy'), 389, 24);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (190, to_date('16-02-2022', 'dd-mm-yyyy'), 2, to_date('20-11-2023', 'dd-mm-yyyy'), 160, 256);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (192, to_date('16-12-2022', 'dd-mm-yyyy'), 1, to_date('01-10-2023', 'dd-mm-yyyy'), 252, 10);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (193, to_date('05-07-2022', 'dd-mm-yyyy'), 2, to_date('14-01-2023', 'dd-mm-yyyy'), 337, 293);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (194, to_date('03-03-2022', 'dd-mm-yyyy'), 1, to_date('20-05-2023', 'dd-mm-yyyy'), 269, 186);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (195, to_date('20-02-2022', 'dd-mm-yyyy'), 3, to_date('08-04-2023', 'dd-mm-yyyy'), 97, 468);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (196, to_date('14-05-2022', 'dd-mm-yyyy'), 1, to_date('25-08-2023', 'dd-mm-yyyy'), 79, 310);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (197, to_date('22-03-2022', 'dd-mm-yyyy'), 1, to_date('14-02-2023', 'dd-mm-yyyy'), 14, 325);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (198, to_date('07-12-2022', 'dd-mm-yyyy'), 3, to_date('28-02-2023', 'dd-mm-yyyy'), 347, 154);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (199, to_date('12-11-2022', 'dd-mm-yyyy'), 3, to_date('05-01-2023', 'dd-mm-yyyy'), 135, 87);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (200, to_date('26-03-2022', 'dd-mm-yyyy'), 3, to_date('25-04-2023', 'dd-mm-yyyy'), 267, 11);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (201, to_date('28-04-2022', 'dd-mm-yyyy'), 2, to_date('02-02-2023', 'dd-mm-yyyy'), 461, 56);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (203, to_date('31-01-2022', 'dd-mm-yyyy'), 1, to_date('03-07-2023', 'dd-mm-yyyy'), 173, 354);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (205, to_date('26-12-2022', 'dd-mm-yyyy'), 1, to_date('06-05-2023', 'dd-mm-yyyy'), 127, 466);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (206, to_date('14-11-2022', 'dd-mm-yyyy'), 3, to_date('21-06-2023', 'dd-mm-yyyy'), 268, 253);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (207, to_date('24-05-2022', 'dd-mm-yyyy'), 2, to_date('07-05-2023', 'dd-mm-yyyy'), 84, 188);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (208, to_date('15-09-2022', 'dd-mm-yyyy'), 3, to_date('26-12-2023', 'dd-mm-yyyy'), 196, 35);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (209, to_date('29-06-2022', 'dd-mm-yyyy'), 1, to_date('16-11-2023', 'dd-mm-yyyy'), 63, 425);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (211, to_date('04-05-2022', 'dd-mm-yyyy'), 1, to_date('20-11-2023', 'dd-mm-yyyy'), 304, 236);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (212, to_date('06-10-2022', 'dd-mm-yyyy'), 3, to_date('11-01-2023', 'dd-mm-yyyy'), 174, 54);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (216, to_date('05-02-2022', 'dd-mm-yyyy'), 1, to_date('15-07-2023', 'dd-mm-yyyy'), 108, 284);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (217, to_date('17-11-2022', 'dd-mm-yyyy'), 1, to_date('09-10-2023', 'dd-mm-yyyy'), 1, 481);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (218, to_date('05-08-2022', 'dd-mm-yyyy'), 1, to_date('23-11-2023', 'dd-mm-yyyy'), 1, 173);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (219, to_date('18-01-2022', 'dd-mm-yyyy'), 2, to_date('30-04-2023', 'dd-mm-yyyy'), 282, 145);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (221, to_date('24-04-2022', 'dd-mm-yyyy'), 2, to_date('15-02-2023', 'dd-mm-yyyy'), 65, 321);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (222, to_date('12-10-2022', 'dd-mm-yyyy'), 2, to_date('05-02-2023', 'dd-mm-yyyy'), 453, 416);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (223, to_date('31-05-2022', 'dd-mm-yyyy'), 3, to_date('16-02-2023', 'dd-mm-yyyy'), 198, 454);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (224, to_date('09-12-2022', 'dd-mm-yyyy'), 2, to_date('22-11-2023', 'dd-mm-yyyy'), 216, 361);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (225, to_date('07-09-2022', 'dd-mm-yyyy'), 2, to_date('04-01-2023', 'dd-mm-yyyy'), 230, 412);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (226, to_date('01-07-2022', 'dd-mm-yyyy'), 1, to_date('21-11-2023', 'dd-mm-yyyy'), 121, 281);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (227, to_date('12-04-2022', 'dd-mm-yyyy'), 2, to_date('25-09-2023', 'dd-mm-yyyy'), 475, 382);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (228, to_date('30-04-2022', 'dd-mm-yyyy'), 3, to_date('15-02-2023', 'dd-mm-yyyy'), 430, 493);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (229, to_date('07-06-2022', 'dd-mm-yyyy'), 3, to_date('05-04-2023', 'dd-mm-yyyy'), 263, 42);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (230, to_date('12-02-2022', 'dd-mm-yyyy'), 1, to_date('08-12-2023', 'dd-mm-yyyy'), 199, 71);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (231, to_date('14-02-2022', 'dd-mm-yyyy'), 3, to_date('02-10-2023', 'dd-mm-yyyy'), 497, 75);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (232, to_date('18-01-2022', 'dd-mm-yyyy'), 3, to_date('07-02-2023', 'dd-mm-yyyy'), 418, 457);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (235, to_date('27-08-2022', 'dd-mm-yyyy'), 1, to_date('25-05-2023', 'dd-mm-yyyy'), 453, 59);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (238, to_date('19-05-2022', 'dd-mm-yyyy'), 1, to_date('21-10-2023', 'dd-mm-yyyy'), 349, 337);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (239, to_date('04-10-2022', 'dd-mm-yyyy'), 1, to_date('12-06-2023', 'dd-mm-yyyy'), 97, 490);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (240, to_date('09-01-2022', 'dd-mm-yyyy'), 2, to_date('01-04-2023', 'dd-mm-yyyy'), 199, 156);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (243, to_date('02-12-2022', 'dd-mm-yyyy'), 3, to_date('04-06-2023', 'dd-mm-yyyy'), 65, 78);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (244, to_date('04-03-2022', 'dd-mm-yyyy'), 1, to_date('04-05-2023', 'dd-mm-yyyy'), 69, 269);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (245, to_date('30-06-2022', 'dd-mm-yyyy'), 3, to_date('28-06-2023', 'dd-mm-yyyy'), 38, 461);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (246, to_date('26-07-2022', 'dd-mm-yyyy'), 1, to_date('10-02-2023', 'dd-mm-yyyy'), 221, 349);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (247, to_date('23-08-2022', 'dd-mm-yyyy'), 1, to_date('13-11-2023', 'dd-mm-yyyy'), 409, 20);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (249, to_date('17-05-2022', 'dd-mm-yyyy'), 1, to_date('18-06-2023', 'dd-mm-yyyy'), 473, 278);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (250, to_date('05-12-2022', 'dd-mm-yyyy'), 2, to_date('07-09-2023', 'dd-mm-yyyy'), 258, 305);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (251, to_date('01-04-2022', 'dd-mm-yyyy'), 3, to_date('20-09-2023', 'dd-mm-yyyy'), 420, 447);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (252, to_date('27-10-2022', 'dd-mm-yyyy'), 2, to_date('13-06-2023', 'dd-mm-yyyy'), 104, 91);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (253, to_date('01-04-2022', 'dd-mm-yyyy'), 2, to_date('24-08-2023', 'dd-mm-yyyy'), 337, 40);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (254, to_date('15-10-2022', 'dd-mm-yyyy'), 3, to_date('11-03-2023', 'dd-mm-yyyy'), 222, 199);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (256, to_date('12-02-2022', 'dd-mm-yyyy'), 2, to_date('13-09-2023', 'dd-mm-yyyy'), 495, 312);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (259, to_date('01-01-2022', 'dd-mm-yyyy'), 3, to_date('30-06-2023', 'dd-mm-yyyy'), 188, 166);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (260, to_date('08-03-2022', 'dd-mm-yyyy'), 3, to_date('30-08-2023', 'dd-mm-yyyy'), 368, 88);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (261, to_date('04-05-2022', 'dd-mm-yyyy'), 2, to_date('11-05-2023', 'dd-mm-yyyy'), 337, 246);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (262, to_date('01-02-2022', 'dd-mm-yyyy'), 1, to_date('10-08-2023', 'dd-mm-yyyy'), 390, 378);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (263, to_date('24-04-2022', 'dd-mm-yyyy'), 2, to_date('02-11-2023', 'dd-mm-yyyy'), 65, 272);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (264, to_date('13-02-2022', 'dd-mm-yyyy'), 1, to_date('07-03-2023', 'dd-mm-yyyy'), 282, 241);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (265, to_date('04-08-2022', 'dd-mm-yyyy'), 3, to_date('26-10-2023', 'dd-mm-yyyy'), 368, 377);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (267, to_date('06-04-2022', 'dd-mm-yyyy'), 1, to_date('20-02-2023', 'dd-mm-yyyy'), 325, 340);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (268, to_date('22-04-2022', 'dd-mm-yyyy'), 2, to_date('26-07-2023', 'dd-mm-yyyy'), 402, 44);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (269, to_date('11-09-2022', 'dd-mm-yyyy'), 2, to_date('10-10-2023', 'dd-mm-yyyy'), 1, 152);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (270, to_date('23-11-2022', 'dd-mm-yyyy'), 2, to_date('19-12-2023', 'dd-mm-yyyy'), 394, 441);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (271, to_date('13-06-2022', 'dd-mm-yyyy'), 1, to_date('20-02-2023', 'dd-mm-yyyy'), 316, 276);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (272, to_date('19-04-2022', 'dd-mm-yyyy'), 2, to_date('07-12-2023', 'dd-mm-yyyy'), 270, 117);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (274, to_date('24-11-2022', 'dd-mm-yyyy'), 3, to_date('07-10-2023', 'dd-mm-yyyy'), 470, 120);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (275, to_date('02-03-2022', 'dd-mm-yyyy'), 2, to_date('10-03-2023', 'dd-mm-yyyy'), 317, 483);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (276, to_date('14-11-2022', 'dd-mm-yyyy'), 1, to_date('15-10-2023', 'dd-mm-yyyy'), 155, 232);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (277, to_date('24-11-2022', 'dd-mm-yyyy'), 1, to_date('25-09-2023', 'dd-mm-yyyy'), 360, 130);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (279, to_date('02-10-2022', 'dd-mm-yyyy'), 2, to_date('01-06-2023', 'dd-mm-yyyy'), 484, 423);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (280, to_date('08-03-2022', 'dd-mm-yyyy'), 1, to_date('25-03-2023', 'dd-mm-yyyy'), 87, 331);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (281, to_date('13-04-2022', 'dd-mm-yyyy'), 1, to_date('19-12-2023', 'dd-mm-yyyy'), 105, 409);
commit;
prompt 200 records committed...
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (282, to_date('18-06-2022', 'dd-mm-yyyy'), 2, to_date('28-04-2023', 'dd-mm-yyyy'), 379, 9);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (283, to_date('01-10-2022', 'dd-mm-yyyy'), 3, to_date('21-03-2023', 'dd-mm-yyyy'), 204, 222);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (284, to_date('12-09-2022', 'dd-mm-yyyy'), 2, to_date('11-02-2023', 'dd-mm-yyyy'), 343, 109);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (285, to_date('02-06-2022', 'dd-mm-yyyy'), 1, to_date('08-08-2023', 'dd-mm-yyyy'), 421, 366);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (287, to_date('09-03-2022', 'dd-mm-yyyy'), 1, to_date('03-06-2023', 'dd-mm-yyyy'), 500, 329);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (288, to_date('30-08-2022', 'dd-mm-yyyy'), 2, to_date('25-02-2023', 'dd-mm-yyyy'), 454, 396);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (289, to_date('26-05-2022', 'dd-mm-yyyy'), 2, to_date('06-05-2023', 'dd-mm-yyyy'), 11, 147);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (291, to_date('22-09-2022', 'dd-mm-yyyy'), 1, to_date('13-04-2023', 'dd-mm-yyyy'), 64, 398);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (292, to_date('15-08-2022', 'dd-mm-yyyy'), 3, to_date('30-06-2023', 'dd-mm-yyyy'), 66, 187);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (296, to_date('24-05-2022', 'dd-mm-yyyy'), 2, to_date('02-09-2023', 'dd-mm-yyyy'), 171, 74);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (297, to_date('13-06-2022', 'dd-mm-yyyy'), 3, to_date('28-01-2023', 'dd-mm-yyyy'), 490, 410);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (298, to_date('28-12-2022', 'dd-mm-yyyy'), 3, to_date('30-05-2023', 'dd-mm-yyyy'), 145, 418);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (299, to_date('18-09-2022', 'dd-mm-yyyy'), 2, to_date('06-03-2023', 'dd-mm-yyyy'), 293, 428);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (300, to_date('01-03-2022', 'dd-mm-yyyy'), 3, to_date('27-12-2023', 'dd-mm-yyyy'), 427, 180);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (302, to_date('06-05-2022', 'dd-mm-yyyy'), 2, to_date('31-01-2023', 'dd-mm-yyyy'), 91, 306);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (304, to_date('26-04-2022', 'dd-mm-yyyy'), 1, to_date('17-10-2023', 'dd-mm-yyyy'), 205, 227);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (305, to_date('23-07-2022', 'dd-mm-yyyy'), 3, to_date('24-06-2023', 'dd-mm-yyyy'), 414, 328);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (308, to_date('12-04-2022', 'dd-mm-yyyy'), 3, to_date('30-10-2023', 'dd-mm-yyyy'), 1, 163);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (309, to_date('25-02-2022', 'dd-mm-yyyy'), 2, to_date('01-01-2023', 'dd-mm-yyyy'), 10, 404);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (312, to_date('18-12-2022', 'dd-mm-yyyy'), 1, to_date('23-03-2023', 'dd-mm-yyyy'), 381, 424);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (313, to_date('21-03-2022', 'dd-mm-yyyy'), 3, to_date('13-09-2023', 'dd-mm-yyyy'), 19, 322);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (314, to_date('28-04-2022', 'dd-mm-yyyy'), 1, to_date('06-02-2023', 'dd-mm-yyyy'), 414, 162);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (315, to_date('22-06-2022', 'dd-mm-yyyy'), 1, to_date('27-06-2023', 'dd-mm-yyyy'), 188, 220);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (316, to_date('23-07-2022', 'dd-mm-yyyy'), 2, to_date('02-08-2023', 'dd-mm-yyyy'), 161, 470);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (317, to_date('26-10-2022', 'dd-mm-yyyy'), 3, to_date('09-01-2023', 'dd-mm-yyyy'), 314, 319);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (318, to_date('15-07-2022', 'dd-mm-yyyy'), 2, to_date('24-08-2023', 'dd-mm-yyyy'), 381, 445);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (319, to_date('16-08-2022', 'dd-mm-yyyy'), 3, to_date('28-10-2023', 'dd-mm-yyyy'), 252, 239);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (322, to_date('24-01-2022', 'dd-mm-yyyy'), 2, to_date('23-08-2023', 'dd-mm-yyyy'), 343, 260);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (323, to_date('14-02-2022', 'dd-mm-yyyy'), 1, to_date('23-08-2023', 'dd-mm-yyyy'), 95, 121);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (324, to_date('02-08-2022', 'dd-mm-yyyy'), 2, to_date('06-01-2023', 'dd-mm-yyyy'), 160, 444);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (325, to_date('19-11-2022', 'dd-mm-yyyy'), 3, to_date('13-08-2023', 'dd-mm-yyyy'), 149, 36);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (326, to_date('17-01-2022', 'dd-mm-yyyy'), 3, to_date('01-11-2023', 'dd-mm-yyyy'), 444, 469);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (328, to_date('04-02-2022', 'dd-mm-yyyy'), 3, to_date('22-03-2023', 'dd-mm-yyyy'), 216, 298);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (329, to_date('27-05-2022', 'dd-mm-yyyy'), 1, to_date('06-08-2023', 'dd-mm-yyyy'), 244, 358);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (330, to_date('18-09-2022', 'dd-mm-yyyy'), 3, to_date('20-12-2023', 'dd-mm-yyyy'), 260, 127);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (331, to_date('30-04-2022', 'dd-mm-yyyy'), 2, to_date('20-03-2023', 'dd-mm-yyyy'), 75, 177);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (333, to_date('11-11-2022', 'dd-mm-yyyy'), 3, to_date('19-09-2023', 'dd-mm-yyyy'), 101, 200);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (335, to_date('05-05-2022', 'dd-mm-yyyy'), 3, to_date('20-06-2023', 'dd-mm-yyyy'), 220, 360);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (336, to_date('25-07-2022', 'dd-mm-yyyy'), 2, to_date('18-06-2023', 'dd-mm-yyyy'), 59, 350);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (339, to_date('26-02-2022', 'dd-mm-yyyy'), 2, to_date('13-03-2023', 'dd-mm-yyyy'), 285, 406);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (340, to_date('29-04-2022', 'dd-mm-yyyy'), 3, to_date('04-11-2023', 'dd-mm-yyyy'), 300, 146);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (341, to_date('11-07-2022', 'dd-mm-yyyy'), 3, to_date('26-08-2023', 'dd-mm-yyyy'), 278, 351);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (343, to_date('09-09-2022', 'dd-mm-yyyy'), 2, to_date('19-05-2023', 'dd-mm-yyyy'), 89, 38);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (344, to_date('21-09-2022', 'dd-mm-yyyy'), 3, to_date('15-02-2023', 'dd-mm-yyyy'), 252, 4);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (345, to_date('27-11-2022', 'dd-mm-yyyy'), 1, to_date('08-08-2023', 'dd-mm-yyyy'), 243, 126);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (346, to_date('09-08-2022', 'dd-mm-yyyy'), 1, to_date('10-10-2023', 'dd-mm-yyyy'), 438, 206);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (348, to_date('26-10-2022', 'dd-mm-yyyy'), 3, to_date('06-04-2023', 'dd-mm-yyyy'), 85, 287);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (349, to_date('09-09-2022', 'dd-mm-yyyy'), 2, to_date('30-03-2023', 'dd-mm-yyyy'), 367, 226);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (351, to_date('29-01-2022', 'dd-mm-yyyy'), 3, to_date('19-02-2023', 'dd-mm-yyyy'), 398, 231);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (352, to_date('04-05-2022', 'dd-mm-yyyy'), 2, to_date('14-06-2023', 'dd-mm-yyyy'), 424, 344);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (353, to_date('17-05-2022', 'dd-mm-yyyy'), 2, to_date('26-10-2023', 'dd-mm-yyyy'), 464, 267);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (355, to_date('10-08-2022', 'dd-mm-yyyy'), 2, to_date('27-01-2023', 'dd-mm-yyyy'), 98, 144);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (356, to_date('15-04-2022', 'dd-mm-yyyy'), 2, to_date('04-02-2023', 'dd-mm-yyyy'), 97, 499);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (357, to_date('09-08-2022', 'dd-mm-yyyy'), 1, to_date('14-05-2023', 'dd-mm-yyyy'), 425, 297);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (359, to_date('28-10-2022', 'dd-mm-yyyy'), 1, to_date('04-10-2023', 'dd-mm-yyyy'), 173, 407);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (361, to_date('01-09-2022', 'dd-mm-yyyy'), 1, to_date('16-05-2023', 'dd-mm-yyyy'), 121, 213);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (363, to_date('31-08-2022', 'dd-mm-yyyy'), 2, to_date('07-08-2023', 'dd-mm-yyyy'), 202, 99);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (364, to_date('09-12-2022', 'dd-mm-yyyy'), 1, to_date('18-12-2023', 'dd-mm-yyyy'), 438, 179);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (365, to_date('20-12-2022', 'dd-mm-yyyy'), 3, to_date('26-01-2023', 'dd-mm-yyyy'), 432, 403);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (366, to_date('21-09-2022', 'dd-mm-yyyy'), 1, to_date('19-01-2023', 'dd-mm-yyyy'), 375, 433);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (367, to_date('15-01-2022', 'dd-mm-yyyy'), 2, to_date('27-05-2023', 'dd-mm-yyyy'), 242, 264);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (371, to_date('01-04-2022', 'dd-mm-yyyy'), 2, to_date('08-05-2023', 'dd-mm-yyyy'), 197, 151);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (372, to_date('07-07-2022', 'dd-mm-yyyy'), 2, to_date('14-10-2023', 'dd-mm-yyyy'), 191, 296);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (373, to_date('14-02-2022', 'dd-mm-yyyy'), 1, to_date('19-12-2023', 'dd-mm-yyyy'), 269, 285);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (374, to_date('24-02-2022', 'dd-mm-yyyy'), 2, to_date('12-03-2023', 'dd-mm-yyyy'), 428, 102);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (375, to_date('31-05-2022', 'dd-mm-yyyy'), 1, to_date('04-02-2023', 'dd-mm-yyyy'), 443, 363);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (376, to_date('06-05-2022', 'dd-mm-yyyy'), 3, to_date('25-08-2023', 'dd-mm-yyyy'), 300, 172);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (377, to_date('10-01-2022', 'dd-mm-yyyy'), 3, to_date('15-09-2023', 'dd-mm-yyyy'), 437, 240);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (378, to_date('30-12-2022', 'dd-mm-yyyy'), 2, to_date('13-12-2023', 'dd-mm-yyyy'), 77, 15);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (379, to_date('02-11-2022', 'dd-mm-yyyy'), 1, to_date('12-02-2023', 'dd-mm-yyyy'), 67, 324);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (382, to_date('17-01-2022', 'dd-mm-yyyy'), 3, to_date('15-04-2023', 'dd-mm-yyyy'), 259, 248);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (383, to_date('26-02-2022', 'dd-mm-yyyy'), 3, to_date('08-10-2023', 'dd-mm-yyyy'), 185, 165);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (387, to_date('04-09-2022', 'dd-mm-yyyy'), 1, to_date('10-04-2023', 'dd-mm-yyyy'), 167, 208);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (388, to_date('25-06-2022', 'dd-mm-yyyy'), 3, to_date('30-08-2023', 'dd-mm-yyyy'), 286, 348);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (389, to_date('24-10-2022', 'dd-mm-yyyy'), 1, to_date('31-12-2023', 'dd-mm-yyyy'), 11, 198);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (390, to_date('19-08-2022', 'dd-mm-yyyy'), 2, to_date('13-12-2023', 'dd-mm-yyyy'), 229, 307);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (392, to_date('10-04-2022', 'dd-mm-yyyy'), 3, to_date('18-10-2023', 'dd-mm-yyyy'), 252, 401);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (393, to_date('20-11-2022', 'dd-mm-yyyy'), 3, to_date('28-08-2023', 'dd-mm-yyyy'), 79, 427);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (394, to_date('14-03-2022', 'dd-mm-yyyy'), 1, to_date('28-07-2023', 'dd-mm-yyyy'), 202, 135);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (395, to_date('06-03-2022', 'dd-mm-yyyy'), 1, to_date('12-10-2023', 'dd-mm-yyyy'), 202, 259);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (396, to_date('05-12-2022', 'dd-mm-yyyy'), 2, to_date('02-03-2023', 'dd-mm-yyyy'), 144, 419);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (399, to_date('20-05-2022', 'dd-mm-yyyy'), 1, to_date('31-07-2023', 'dd-mm-yyyy'), 306, 280);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (400, to_date('11-02-2022', 'dd-mm-yyyy'), 2, to_date('17-10-2023', 'dd-mm-yyyy'), 369, 141);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (401, to_date('24-03-2022', 'dd-mm-yyyy'), 1, to_date('23-09-2023', 'dd-mm-yyyy'), 240, 288);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (402, to_date('29-03-2022', 'dd-mm-yyyy'), 3, to_date('13-10-2023', 'dd-mm-yyyy'), 73, 364);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (405, to_date('21-10-2022', 'dd-mm-yyyy'), 2, to_date('25-02-2023', 'dd-mm-yyyy'), 436, 374);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (407, to_date('12-08-2022', 'dd-mm-yyyy'), 1, to_date('15-03-2023', 'dd-mm-yyyy'), 481, 376);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (408, to_date('15-08-2022', 'dd-mm-yyyy'), 3, to_date('17-10-2023', 'dd-mm-yyyy'), 385, 362);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (409, to_date('22-03-2022', 'dd-mm-yyyy'), 3, to_date('22-04-2023', 'dd-mm-yyyy'), 160, 432);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (410, to_date('01-01-2022', 'dd-mm-yyyy'), 1, to_date('21-06-2023', 'dd-mm-yyyy'), 382, 18);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (411, to_date('16-07-2022', 'dd-mm-yyyy'), 1, to_date('08-10-2023', 'dd-mm-yyyy'), 41, 292);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (412, to_date('21-08-2022', 'dd-mm-yyyy'), 2, to_date('27-09-2023', 'dd-mm-yyyy'), 272, 277);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (413, to_date('02-02-2022', 'dd-mm-yyyy'), 2, to_date('17-04-2023', 'dd-mm-yyyy'), 174, 150);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (414, to_date('19-08-2022', 'dd-mm-yyyy'), 1, to_date('27-02-2023', 'dd-mm-yyyy'), 423, 453);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (415, to_date('11-08-2022', 'dd-mm-yyyy'), 1, to_date('09-04-2023', 'dd-mm-yyyy'), 349, 2);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (416, to_date('17-01-2022', 'dd-mm-yyyy'), 1, to_date('12-07-2023', 'dd-mm-yyyy'), 117, 244);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (417, to_date('17-01-2022', 'dd-mm-yyyy'), 2, to_date('07-06-2023', 'dd-mm-yyyy'), 234, 128);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (420, to_date('05-09-2022', 'dd-mm-yyyy'), 3, to_date('28-03-2023', 'dd-mm-yyyy'), 481, 161);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (421, to_date('26-05-2022', 'dd-mm-yyyy'), 3, to_date('28-04-2023', 'dd-mm-yyyy'), 286, 132);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (422, to_date('10-07-2022', 'dd-mm-yyyy'), 2, to_date('21-01-2023', 'dd-mm-yyyy'), 171, 346);
commit;
prompt 300 records committed...
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (423, to_date('20-12-2022', 'dd-mm-yyyy'), 3, to_date('27-01-2023', 'dd-mm-yyyy'), 77, 491);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (425, to_date('29-07-2022', 'dd-mm-yyyy'), 1, to_date('03-12-2023', 'dd-mm-yyyy'), 165, 181);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (426, to_date('16-04-2022', 'dd-mm-yyyy'), 2, to_date('24-08-2023', 'dd-mm-yyyy'), 427, 335);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (427, to_date('24-03-2022', 'dd-mm-yyyy'), 2, to_date('12-07-2023', 'dd-mm-yyyy'), 373, 385);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (429, to_date('01-07-2022', 'dd-mm-yyyy'), 2, to_date('15-09-2023', 'dd-mm-yyyy'), 339, 353);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (430, to_date('09-11-2022', 'dd-mm-yyyy'), 2, to_date('03-06-2023', 'dd-mm-yyyy'), 499, 405);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (431, to_date('27-01-2022', 'dd-mm-yyyy'), 2, to_date('14-08-2023', 'dd-mm-yyyy'), 291, 495);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (432, to_date('04-02-2022', 'dd-mm-yyyy'), 1, to_date('10-11-2023', 'dd-mm-yyyy'), 135, 273);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (433, to_date('29-10-2022', 'dd-mm-yyyy'), 1, to_date('13-05-2023', 'dd-mm-yyyy'), 413, 194);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (436, to_date('09-10-2022', 'dd-mm-yyyy'), 3, to_date('04-09-2023', 'dd-mm-yyyy'), 339, 402);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (438, to_date('26-02-2022', 'dd-mm-yyyy'), 3, to_date('17-08-2023', 'dd-mm-yyyy'), 226, 12);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (439, to_date('02-02-2022', 'dd-mm-yyyy'), 1, to_date('16-11-2023', 'dd-mm-yyyy'), 18, 184);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (440, to_date('16-06-2022', 'dd-mm-yyyy'), 2, to_date('20-12-2023', 'dd-mm-yyyy'), 18, 224);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (442, to_date('31-05-2022', 'dd-mm-yyyy'), 1, to_date('26-10-2023', 'dd-mm-yyyy'), 97, 79);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (443, to_date('22-03-2022', 'dd-mm-yyyy'), 2, to_date('29-04-2023', 'dd-mm-yyyy'), 454, 397);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (445, to_date('20-05-2022', 'dd-mm-yyyy'), 3, to_date('13-11-2023', 'dd-mm-yyyy'), 105, 238);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (447, to_date('07-09-2022', 'dd-mm-yyyy'), 2, to_date('18-12-2023', 'dd-mm-yyyy'), 415, 408);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (448, to_date('14-06-2022', 'dd-mm-yyyy'), 2, to_date('28-11-2023', 'dd-mm-yyyy'), 352, 176);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (450, to_date('19-05-2022', 'dd-mm-yyyy'), 3, to_date('19-06-2023', 'dd-mm-yyyy'), 394, 228);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (451, to_date('28-08-2022', 'dd-mm-yyyy'), 2, to_date('04-11-2023', 'dd-mm-yyyy'), 63, 355);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (452, to_date('11-04-2022', 'dd-mm-yyyy'), 3, to_date('07-05-2023', 'dd-mm-yyyy'), 261, 254);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (453, to_date('19-12-2022', 'dd-mm-yyyy'), 3, to_date('09-02-2023', 'dd-mm-yyyy'), 497, 429);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (457, to_date('11-04-2022', 'dd-mm-yyyy'), 3, to_date('05-11-2023', 'dd-mm-yyyy'), 91, 316);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (459, to_date('09-01-2022', 'dd-mm-yyyy'), 3, to_date('11-03-2023', 'dd-mm-yyyy'), 286, 394);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (460, to_date('01-09-2022', 'dd-mm-yyyy'), 3, to_date('15-11-2023', 'dd-mm-yyyy'), 14, 318);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (461, to_date('12-11-2022', 'dd-mm-yyyy'), 3, to_date('19-01-2023', 'dd-mm-yyyy'), 183, 467);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (463, to_date('18-03-2022', 'dd-mm-yyyy'), 1, to_date('30-10-2023', 'dd-mm-yyyy'), 251, 479);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (467, to_date('31-10-2022', 'dd-mm-yyyy'), 3, to_date('29-05-2023', 'dd-mm-yyyy'), 407, 279);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (468, to_date('12-08-2022', 'dd-mm-yyyy'), 3, to_date('13-03-2023', 'dd-mm-yyyy'), 214, 271);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (469, to_date('10-08-2022', 'dd-mm-yyyy'), 1, to_date('22-02-2023', 'dd-mm-yyyy'), 240, 167);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (470, to_date('27-11-2022', 'dd-mm-yyyy'), 2, to_date('10-09-2023', 'dd-mm-yyyy'), 349, 1);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (473, to_date('22-08-2022', 'dd-mm-yyyy'), 1, to_date('12-09-2023', 'dd-mm-yyyy'), 69, 373);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (474, to_date('15-09-2022', 'dd-mm-yyyy'), 3, to_date('05-08-2023', 'dd-mm-yyyy'), 291, 76);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (476, to_date('03-04-2022', 'dd-mm-yyyy'), 2, to_date('06-12-2023', 'dd-mm-yyyy'), 313, 82);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (477, to_date('01-12-2022', 'dd-mm-yyyy'), 2, to_date('10-03-2023', 'dd-mm-yyyy'), 75, 477);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (478, to_date('23-10-2022', 'dd-mm-yyyy'), 2, to_date('27-06-2023', 'dd-mm-yyyy'), 72, 14);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (480, to_date('12-07-2022', 'dd-mm-yyyy'), 2, to_date('21-08-2023', 'dd-mm-yyyy'), 272, 225);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (481, to_date('25-07-2022', 'dd-mm-yyyy'), 3, to_date('27-08-2023', 'dd-mm-yyyy'), 223, 221);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (482, to_date('11-02-2022', 'dd-mm-yyyy'), 2, to_date('21-08-2023', 'dd-mm-yyyy'), 387, 41);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (483, to_date('10-12-2022', 'dd-mm-yyyy'), 3, to_date('25-10-2023', 'dd-mm-yyyy'), 57, 93);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (484, to_date('27-06-2022', 'dd-mm-yyyy'), 2, to_date('10-10-2023', 'dd-mm-yyyy'), 352, 342);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (485, to_date('20-10-2022', 'dd-mm-yyyy'), 2, to_date('16-01-2023', 'dd-mm-yyyy'), 435, 108);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (486, to_date('14-11-2022', 'dd-mm-yyyy'), 1, to_date('12-05-2023', 'dd-mm-yyyy'), 324, 215);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (487, to_date('06-04-2022', 'dd-mm-yyyy'), 3, to_date('06-03-2023', 'dd-mm-yyyy'), 362, 164);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (491, to_date('13-07-2022', 'dd-mm-yyyy'), 1, to_date('02-11-2023', 'dd-mm-yyyy'), 444, 386);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (492, to_date('05-03-2022', 'dd-mm-yyyy'), 2, to_date('07-03-2023', 'dd-mm-yyyy'), 157, 430);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (494, to_date('20-11-2022', 'dd-mm-yyyy'), 2, to_date('24-12-2023', 'dd-mm-yyyy'), 344, 356);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (495, to_date('31-08-2022', 'dd-mm-yyyy'), 1, to_date('22-09-2023', 'dd-mm-yyyy'), 56, 375);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (498, to_date('30-06-2022', 'dd-mm-yyyy'), 3, to_date('01-01-2023', 'dd-mm-yyyy'), 58, 314);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (500, to_date('29-10-2022', 'dd-mm-yyyy'), 2, to_date('15-08-2023', 'dd-mm-yyyy'), 136, 243);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (601, to_date('01-09-2024', 'dd-mm-yyyy'), 1, to_date('01-09-2027', 'dd-mm-yyyy'), 499, 501);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (503, to_date('22-11-2024', 'dd-mm-yyyy'), 3, to_date('01-11-2027', 'dd-mm-yyyy'), 3, 503);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (505, to_date('17-03-2024', 'dd-mm-yyyy'), 1, to_date('01-03-2027', 'dd-mm-yyyy'), 5, 505);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (506, to_date('11-01-2024', 'dd-mm-yyyy'), 2, to_date('01-01-2027', 'dd-mm-yyyy'), 6, 506);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (507, to_date('11-03-2024', 'dd-mm-yyyy'), 3, to_date('01-03-2027', 'dd-mm-yyyy'), 7, 507);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (509, to_date('11-09-2024', 'dd-mm-yyyy'), 2, to_date('01-09-2027', 'dd-mm-yyyy'), 9, 509);
insert into LOANS (lserialnumber, lodate, urgency, returndate, eid, oserialnumber)
values (510, to_date('14-01-2024', 'dd-mm-yyyy'), 1, to_date('01-01-2027', 'dd-mm-yyyy'), 10, 510);
commit;
prompt 357 records loaded
prompt Loading MEDICINIES...
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (143, 400, 'Posaconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (23, 401, 'Amikacin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (111, 402, 'Dapsone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (94, 403, 'Pomalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (149, 404, 'Brexucabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (168, 405, 'Elotuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (151, 406, 'Azithromycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (167, 407, 'Carboplatin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (166, 408, 'Copanlisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (42, 409, 'Mebendazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (47, 410, 'Minocycline');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (55, 411, 'Ceftriaxone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (31, 412, 'Umbralisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (135, 413, 'Sulfamethoxazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (131, 414, 'Tacrolimus');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (54, 415, 'Atenolol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (96, 416, 'Adalimumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (5, 417, 'Lisocabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (178, 418, 'Odronextamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (12, 419, 'Permethrin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (117, 420, 'Idarubicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (52, 421, 'Ifosfamide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (102, 422, 'Umbralisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (37, 423, 'Sildenafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (32, 424, 'Ibrutinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (33, 425, 'Belatacept');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (108, 426, 'Tocilizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (146, 427, 'Levothyroxine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (200, 428, 'Vinblastine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (162, 429, 'Loratadine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (110, 430, 'Copanlisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (86, 431, 'Praziquantel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (90, 432, 'Trimethoprim');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (149, 433, 'Teclistamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (8, 434, 'Nitrofurantoin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (122, 435, 'Tetracycline');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (49, 436, 'Pomalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (26, 437, 'Cyclophosphamide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (33, 438, 'Clarithromycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (174, 439, 'Ivermectin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (125, 440, 'Lenalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (115, 441, 'Daratumumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (148, 442, 'Adalimumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (132, 443, 'Ethambutol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (146, 444, 'Cisplatin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (168, 445, 'Cetirizine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (117, 446, 'Carfilzomib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (119, 447, 'Abatacept');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (73, 448, 'Voriconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (71, 449, 'Finasteride');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (34, 450, 'Moxifloxacin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (129, 451, 'Copanlisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (14, 452, 'Streptomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (106, 453, 'Lindane');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (116, 454, 'Tacrolimus');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (19, 455, 'Isavuconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (88, 456, 'Fidaxomicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (175, 457, 'Ceftriaxone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (153, 458, 'Ibuprofen');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (67, 459, 'Lisocabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (168, 460, 'Isavuconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (192, 461, 'Voclosporin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (29, 462, 'Copanlisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (92, 463, 'Bedaquiline');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (76, 464, 'Voriconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (32, 465, 'Voclosporin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (101, 466, 'Cyclophosphamide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (135, 467, 'Venetoclax');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (42, 468, 'Belantamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (49, 469, 'Aspirin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (38, 470, 'Odronextamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (108, 471, 'Venetoclax');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (34, 472, 'Venetoclax');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (144, 473, 'Metformin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (128, 474, 'Rituximab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (198, 475, 'Cabazitaxel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (133, 476, 'Cyclosporine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (10, 477, 'Sarilumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (43, 478, 'Tadalafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (34, 479, 'Zanubrutinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (191, 480, 'Albuterol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (134, 481, 'Cefepime');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (71, 482, 'Cefotaxime');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (29, 483, 'Etanercept');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (133, 484, 'Alemtuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (154, 485, 'Linezolid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (13, 486, 'Tofacitinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (66, 487, 'Pyrazinamide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (139, 488, 'Ustekinumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (194, 489, 'Basiliximab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (93, 490, 'Ruxolitinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (157, 491, 'Sildenafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (71, 492, 'Rifampin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (143, 493, 'Cefepime');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (70, 494, 'Atorvastatin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (67, 495, 'Colchicine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (177, 496, 'Belantamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (116, 497, 'Epirubicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (20, 498, 'Acalabrutinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (92, 499, 'Spironolactone');
commit;
prompt 100 records committed...
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (48, 500, 'Azithromycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (59, 501, 'Guselkumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (129, 502, 'Clofazimine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (7, 503, 'Alemtuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (44, 504, 'Posaconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (134, 505, 'Natalizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (82, 506, 'Guselkumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (173, 507, 'Gentamicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (178, 508, 'Finasteride');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (47, 509, 'Natalizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (135, 510, 'Mebendazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (10, 511, 'Bedaquiline');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (61, 512, 'Golimumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (160, 513, 'Praziquantel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (43, 514, 'Pentostatin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (196, 515, 'Busulfan');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (119, 516, 'Belantamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (145, 517, 'Cyclophosphamide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (50, 518, 'Tigecycline');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (140, 519, 'Carboplatin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (60, 520, 'Aztreonam');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (18, 521, 'Voclosporin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (146, 522, 'Metformin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (59, 523, 'Finasteride');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (16, 524, 'Erythromycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (125, 525, 'Umbralisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (181, 526, 'Nitrofurantoin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (137, 527, 'Finasteride');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (133, 528, 'Amlodipine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (88, 529, 'Pentostatin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (46, 530, 'Decitabine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (200, 531, 'Delamanid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (38, 532, 'Fedratinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (130, 533, 'Hydroxyurea');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (116, 534, 'Fluconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (160, 535, 'Ciprofloxacin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (160, 536, 'Daunorubicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (139, 537, 'Tildrakizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (151, 538, 'Mitoxantrone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (25, 539, 'Pyrazinamide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (113, 540, 'Ustekinumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (114, 541, 'Inotuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (65, 542, 'Rituximab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (69, 543, 'Idelalisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (150, 544, 'Mebendazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (165, 545, 'Losartan');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (155, 546, 'Famotidine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (159, 547, 'Allopurinol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (67, 548, 'Terbinafine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (75, 549, 'Streptomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (193, 550, 'Axicabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (55, 551, 'Mycophenolate');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (182, 552, 'Elotuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (28, 553, 'Furosemide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (180, 554, 'Teclistamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (69, 555, 'Allopurinol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (163, 556, 'Mycophenolate');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (97, 557, 'Aspirin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (161, 558, 'Ixazomib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (78, 559, 'Secukinumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (134, 560, 'Brexucabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (93, 561, 'Atenolol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (109, 562, 'Natalizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (114, 563, 'Axicabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (32, 564, 'Gentamicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (183, 565, 'Lenalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (61, 566, 'Pomalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (104, 567, 'Tadalafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (30, 568, 'Certolizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (62, 569, 'Belantamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (129, 570, 'Pomalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (177, 571, 'Zanubrutinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (22, 572, 'Vinorelbine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (95, 573, 'Thalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (158, 574, 'Amphotericin B');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (139, 575, 'Itraconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (173, 576, 'Avacopan');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (16, 577, 'Copanlisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (62, 578, 'Thalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (101, 579, 'Sirolimus');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (125, 580, 'Methotrexate');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (194, 581, 'Acalabrutinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (18, 582, 'Bleomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (74, 583, 'Ixazomib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (78, 584, 'Mesalamine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (52, 585, 'Sirolimus');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (111, 586, 'Daunorubicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (130, 587, 'Venetoclax');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (118, 588, 'Vinblastine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (70, 589, 'Delamanid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (59, 590, 'Gentamicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (116, 591, 'Etanercept');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (19, 592, 'Adalimumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (120, 593, 'Methotrexate');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (188, 594, 'Amikacin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (143, 595, 'Vancomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (103, 596, 'Basiliximab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (190, 597, 'Voclosporin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (76, 598, 'Digoxin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (26, 599, 'Atenolol');
commit;
prompt 200 records committed...
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (160, 600, 'Cladribine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (56, 601, 'Vinorelbine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (57, 602, 'Metformin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (96, 603, 'Digoxin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (39, 604, 'Belatacept');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (125, 605, 'Belantamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (187, 606, 'Tacrolimus');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (163, 607, 'Spironolactone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (93, 608, 'Vancomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (29, 609, 'Trimethoprim');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (71, 610, 'Ethambutol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (54, 611, 'Gemtuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (88, 612, 'Selinexor');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (196, 613, 'Ocrelizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (163, 614, 'Secukinumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (110, 615, 'Cefotaxime');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (179, 616, 'Hydroxyurea');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (170, 617, 'Mitoxantrone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (110, 618, 'Belatacept');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (36, 619, 'Atenolol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (142, 620, 'Moxifloxacin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (104, 621, 'Clindamycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (175, 622, 'Mycophenolate');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (125, 623, 'Idecabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (79, 624, 'Erythromycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (10, 625, 'Pretomanid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (115, 626, 'Ifosfamide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (42, 627, 'Certolizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (170, 628, 'Sarilumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (175, 629, 'Axicabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (122, 630, 'Venetoclax');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (167, 631, 'Decitabine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (100, 632, 'Baricitinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (127, 633, 'Levofloxacin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (29, 634, 'Vardenafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (101, 635, 'Tocilizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (147, 636, 'Vardenafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (190, 637, 'Belatacept');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (176, 638, 'Dapsone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (139, 639, 'Paclitaxel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (126, 640, 'Tocilizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (171, 641, 'Vardenafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (136, 642, 'Tisagenlecleucel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (101, 643, 'Bleomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (11, 644, 'Tildrakizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (30, 645, 'Albendazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (113, 646, 'Bendamustine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (127, 647, 'Sulfamethoxazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (159, 648, 'Azathioprine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (107, 649, 'Secukinumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (192, 650, 'Rifampin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (32, 651, 'Idecabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (142, 652, 'Etoposide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (108, 653, 'Griseofulvin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (56, 654, 'Etanercept');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (31, 655, 'Upadacitinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (51, 656, 'Brexucabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (56, 657, 'Axicabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (169, 658, 'Isoniazid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (19, 659, 'Bleomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (13, 660, 'Ixazomib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (8, 661, 'Aspirin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (10, 662, 'Pretomanid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (12, 663, 'Mosunetuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (52, 664, 'Doxorubicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (128, 665, 'Fludarabine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (189, 666, 'Rifampin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (162, 667, 'Pretomanid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (179, 668, 'Delamanid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (124, 669, 'Copanlisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (200, 670, 'Pentostatin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (120, 671, 'Vardenafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (137, 672, 'Sulfamethoxazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (56, 673, 'Anidulafungin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (62, 674, 'Paracetamol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (173, 675, 'Trimethoprim');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (161, 676, 'Cladribine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (94, 677, 'Caspofungin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (5, 678, 'Gentamicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (137, 679, 'Cefotaxime');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (146, 680, 'Pomalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (45, 681, 'Ifosfamide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (26, 682, 'Ixazomib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (13, 683, 'Risankizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (76, 684, 'Tadalafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (43, 685, 'Docetaxel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (104, 686, 'Imipenem');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (11, 687, 'Atenolol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (128, 688, 'Ethambutol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (199, 689, 'Tamsulosin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (81, 690, 'Ciltacabtagene');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (131, 691, 'Odronextamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (25, 692, 'Amikacin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (14, 693, 'Aztreonam');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (13, 694, 'Risankizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (102, 695, 'Streptomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (69, 696, 'Simvastatin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (161, 697, 'Sirolimus');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (127, 698, 'Sulfamethoxazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (98, 699, 'Axicabtagene');
commit;
prompt 300 records committed...
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (18, 700, 'Streptomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (12, 701, 'Tobramycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (183, 702, 'Ranitidine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (5, 703, 'Clopidogrel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (38, 704, 'Dapsone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (153, 705, 'Daunorubicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (105, 706, 'Doxycycline');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (51, 707, 'Golimumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (114, 708, 'Ceftriaxone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (35, 709, 'Tofacitinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (26, 710, 'Clarithromycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (12, 711, 'Ixekizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (118, 712, 'Tocilizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (12, 713, 'Risankizumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (130, 714, 'Elotuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (122, 715, 'Etoposide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (155, 716, 'Vinorelbine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (119, 717, 'Furosemide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (166, 718, 'Paracetamol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (90, 719, 'Sarilumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (147, 720, 'Fludarabine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (28, 721, 'Atorvastatin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (30, 722, 'Mitoxantrone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (83, 723, 'Odronextamab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (107, 724, 'Minocycline');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (166, 725, 'Aspirin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (11, 726, 'Ceftriaxone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (22, 727, 'Ranitidine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (53, 728, 'Rituximab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (181, 729, 'Metformin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (88, 730, 'Clofazimine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (180, 731, 'Inotuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (199, 732, 'Thalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (190, 733, 'Alemtuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (98, 734, 'Amphotericin B');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (146, 735, 'Loncastuximab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (198, 736, 'Inotuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (176, 737, 'Rituximab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (170, 738, 'Clopidogrel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (168, 739, 'Delamanid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (54, 740, 'Duvelisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (152, 741, 'Hydroxyurea');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (12, 742, 'Loratadine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (37, 743, 'Tamsulosin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (102, 744, 'Selinexor');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (86, 745, 'Leflunomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (71, 746, 'Rituximab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (155, 747, 'Lenalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (33, 748, 'Idarubicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (195, 749, 'Clindamycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (141, 750, 'Tisagenlecleucel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (143, 751, 'Cefepime');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (199, 752, 'Thalidomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (187, 753, 'Brodalumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (49, 754, 'Fluconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (34, 755, 'Azacitidine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (169, 756, 'Hydroxyurea');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (83, 757, 'Daratumumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (198, 758, 'Fluconazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (13, 759, 'Tadalafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (157, 760, 'Levofloxacin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (192, 761, 'Terbinafine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (164, 762, 'Avacopan');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (124, 763, 'Colchicine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (104, 764, 'Spironolactone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (41, 765, 'Tobramycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (170, 766, 'Micafungin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (142, 767, 'Omeprazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (26, 768, 'Cladribine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (92, 769, 'Dapsone');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (11, 770, 'Fedratinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (14, 771, 'Copanlisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (29, 772, 'Sulfamethoxazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (190, 773, 'Ibrutinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (50, 774, 'Leflunomide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (5, 775, 'Bleomycin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (176, 776, 'Docetaxel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (197, 777, 'Isoniazid');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (67, 778, 'Upadacitinib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (155, 779, 'Furosemide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (22, 780, 'Idelalisib');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (181, 781, 'Mesalamine');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (178, 782, 'Mebendazole');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (95, 783, 'Ciprofloxacin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (22, 784, 'Gentamicin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (165, 785, 'Hydrochlorothiazide');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (16, 786, 'Minocycline');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (191, 787, 'Digoxin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (182, 788, 'Nitrofurantoin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (40, 789, 'Allopurinol');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (172, 790, 'Meropenem');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (162, 791, 'Guselkumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (182, 792, 'Sildenafil');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (46, 793, 'Adalimumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (97, 794, 'Polatuzumab');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (102, 795, 'Imipenem');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (167, 796, 'Griseofulvin');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (12, 797, 'Tetracycline');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (73, 798, 'Paclitaxel');
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (45, 799, 'Ciprofloxacin');
commit;
prompt 400 records committed...
insert into MEDICINIES (qualitity_available_in_stock, m_id, n_name)
values (0, 399, 'Acamol');
commit;
prompt 401 records loaded
prompt Loading MEDICATION_VISIT...
insert into MEDICATION_VISIT (v_id, m_id)
values (100, 423);
insert into MEDICATION_VISIT (v_id, m_id)
values (100, 442);
insert into MEDICATION_VISIT (v_id, m_id)
values (100, 485);
insert into MEDICATION_VISIT (v_id, m_id)
values (100, 536);
insert into MEDICATION_VISIT (v_id, m_id)
values (100, 713);
insert into MEDICATION_VISIT (v_id, m_id)
values (100, 723);
insert into MEDICATION_VISIT (v_id, m_id)
values (100, 725);
insert into MEDICATION_VISIT (v_id, m_id)
values (100, 753);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 430);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 460);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 464);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 513);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 552);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 568);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 618);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 621);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 650);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 753);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 765);
insert into MEDICATION_VISIT (v_id, m_id)
values (101, 774);
insert into MEDICATION_VISIT (v_id, m_id)
values (102, 409);
insert into MEDICATION_VISIT (v_id, m_id)
values (102, 439);
insert into MEDICATION_VISIT (v_id, m_id)
values (102, 441);
insert into MEDICATION_VISIT (v_id, m_id)
values (102, 472);
insert into MEDICATION_VISIT (v_id, m_id)
values (102, 538);
insert into MEDICATION_VISIT (v_id, m_id)
values (102, 631);
insert into MEDICATION_VISIT (v_id, m_id)
values (102, 649);
insert into MEDICATION_VISIT (v_id, m_id)
values (102, 702);
insert into MEDICATION_VISIT (v_id, m_id)
values (102, 780);
insert into MEDICATION_VISIT (v_id, m_id)
values (103, 635);
insert into MEDICATION_VISIT (v_id, m_id)
values (103, 637);
insert into MEDICATION_VISIT (v_id, m_id)
values (103, 644);
insert into MEDICATION_VISIT (v_id, m_id)
values (103, 686);
insert into MEDICATION_VISIT (v_id, m_id)
values (103, 696);
insert into MEDICATION_VISIT (v_id, m_id)
values (103, 726);
insert into MEDICATION_VISIT (v_id, m_id)
values (104, 461);
insert into MEDICATION_VISIT (v_id, m_id)
values (104, 482);
insert into MEDICATION_VISIT (v_id, m_id)
values (104, 632);
insert into MEDICATION_VISIT (v_id, m_id)
values (104, 670);
insert into MEDICATION_VISIT (v_id, m_id)
values (104, 692);
insert into MEDICATION_VISIT (v_id, m_id)
values (104, 715);
insert into MEDICATION_VISIT (v_id, m_id)
values (104, 789);
insert into MEDICATION_VISIT (v_id, m_id)
values (105, 467);
insert into MEDICATION_VISIT (v_id, m_id)
values (105, 534);
insert into MEDICATION_VISIT (v_id, m_id)
values (105, 563);
insert into MEDICATION_VISIT (v_id, m_id)
values (105, 595);
insert into MEDICATION_VISIT (v_id, m_id)
values (105, 752);
insert into MEDICATION_VISIT (v_id, m_id)
values (106, 408);
insert into MEDICATION_VISIT (v_id, m_id)
values (106, 471);
insert into MEDICATION_VISIT (v_id, m_id)
values (106, 482);
insert into MEDICATION_VISIT (v_id, m_id)
values (106, 687);
insert into MEDICATION_VISIT (v_id, m_id)
values (106, 695);
insert into MEDICATION_VISIT (v_id, m_id)
values (106, 726);
insert into MEDICATION_VISIT (v_id, m_id)
values (107, 556);
insert into MEDICATION_VISIT (v_id, m_id)
values (107, 638);
insert into MEDICATION_VISIT (v_id, m_id)
values (107, 661);
insert into MEDICATION_VISIT (v_id, m_id)
values (107, 692);
insert into MEDICATION_VISIT (v_id, m_id)
values (107, 742);
insert into MEDICATION_VISIT (v_id, m_id)
values (107, 754);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 436);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 439);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 470);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 510);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 520);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 614);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 624);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 669);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 731);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 733);
insert into MEDICATION_VISIT (v_id, m_id)
values (108, 751);
insert into MEDICATION_VISIT (v_id, m_id)
values (109, 443);
insert into MEDICATION_VISIT (v_id, m_id)
values (109, 512);
insert into MEDICATION_VISIT (v_id, m_id)
values (109, 521);
insert into MEDICATION_VISIT (v_id, m_id)
values (109, 596);
insert into MEDICATION_VISIT (v_id, m_id)
values (109, 722);
insert into MEDICATION_VISIT (v_id, m_id)
values (110, 414);
insert into MEDICATION_VISIT (v_id, m_id)
values (110, 470);
insert into MEDICATION_VISIT (v_id, m_id)
values (111, 425);
insert into MEDICATION_VISIT (v_id, m_id)
values (111, 528);
insert into MEDICATION_VISIT (v_id, m_id)
values (111, 621);
insert into MEDICATION_VISIT (v_id, m_id)
values (111, 689);
insert into MEDICATION_VISIT (v_id, m_id)
values (111, 792);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 423);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 482);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 488);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 602);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 626);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 671);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 676);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 693);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 708);
insert into MEDICATION_VISIT (v_id, m_id)
values (112, 778);
insert into MEDICATION_VISIT (v_id, m_id)
values (113, 422);
insert into MEDICATION_VISIT (v_id, m_id)
values (113, 506);
insert into MEDICATION_VISIT (v_id, m_id)
values (113, 628);
insert into MEDICATION_VISIT (v_id, m_id)
values (113, 635);
insert into MEDICATION_VISIT (v_id, m_id)
values (113, 785);
insert into MEDICATION_VISIT (v_id, m_id)
values (114, 432);
insert into MEDICATION_VISIT (v_id, m_id)
values (114, 477);
insert into MEDICATION_VISIT (v_id, m_id)
values (114, 505);
commit;
prompt 100 records committed...
insert into MEDICATION_VISIT (v_id, m_id)
values (114, 563);
insert into MEDICATION_VISIT (v_id, m_id)
values (114, 619);
insert into MEDICATION_VISIT (v_id, m_id)
values (114, 632);
insert into MEDICATION_VISIT (v_id, m_id)
values (114, 636);
insert into MEDICATION_VISIT (v_id, m_id)
values (114, 702);
insert into MEDICATION_VISIT (v_id, m_id)
values (115, 646);
insert into MEDICATION_VISIT (v_id, m_id)
values (115, 648);
insert into MEDICATION_VISIT (v_id, m_id)
values (115, 701);
insert into MEDICATION_VISIT (v_id, m_id)
values (116, 450);
insert into MEDICATION_VISIT (v_id, m_id)
values (116, 591);
insert into MEDICATION_VISIT (v_id, m_id)
values (117, 562);
insert into MEDICATION_VISIT (v_id, m_id)
values (117, 584);
insert into MEDICATION_VISIT (v_id, m_id)
values (117, 593);
insert into MEDICATION_VISIT (v_id, m_id)
values (117, 636);
insert into MEDICATION_VISIT (v_id, m_id)
values (117, 650);
insert into MEDICATION_VISIT (v_id, m_id)
values (117, 770);
insert into MEDICATION_VISIT (v_id, m_id)
values (118, 408);
insert into MEDICATION_VISIT (v_id, m_id)
values (118, 428);
insert into MEDICATION_VISIT (v_id, m_id)
values (118, 513);
insert into MEDICATION_VISIT (v_id, m_id)
values (118, 545);
insert into MEDICATION_VISIT (v_id, m_id)
values (118, 599);
insert into MEDICATION_VISIT (v_id, m_id)
values (119, 415);
insert into MEDICATION_VISIT (v_id, m_id)
values (119, 430);
insert into MEDICATION_VISIT (v_id, m_id)
values (119, 457);
insert into MEDICATION_VISIT (v_id, m_id)
values (119, 523);
insert into MEDICATION_VISIT (v_id, m_id)
values (119, 614);
insert into MEDICATION_VISIT (v_id, m_id)
values (119, 661);
insert into MEDICATION_VISIT (v_id, m_id)
values (119, 714);
insert into MEDICATION_VISIT (v_id, m_id)
values (120, 468);
insert into MEDICATION_VISIT (v_id, m_id)
values (120, 473);
insert into MEDICATION_VISIT (v_id, m_id)
values (120, 535);
insert into MEDICATION_VISIT (v_id, m_id)
values (120, 550);
insert into MEDICATION_VISIT (v_id, m_id)
values (120, 573);
insert into MEDICATION_VISIT (v_id, m_id)
values (120, 616);
insert into MEDICATION_VISIT (v_id, m_id)
values (120, 757);
insert into MEDICATION_VISIT (v_id, m_id)
values (120, 769);
insert into MEDICATION_VISIT (v_id, m_id)
values (120, 781);
insert into MEDICATION_VISIT (v_id, m_id)
values (121, 444);
insert into MEDICATION_VISIT (v_id, m_id)
values (121, 447);
insert into MEDICATION_VISIT (v_id, m_id)
values (121, 451);
insert into MEDICATION_VISIT (v_id, m_id)
values (121, 467);
insert into MEDICATION_VISIT (v_id, m_id)
values (121, 794);
insert into MEDICATION_VISIT (v_id, m_id)
values (122, 458);
insert into MEDICATION_VISIT (v_id, m_id)
values (122, 506);
insert into MEDICATION_VISIT (v_id, m_id)
values (122, 672);
insert into MEDICATION_VISIT (v_id, m_id)
values (122, 773);
insert into MEDICATION_VISIT (v_id, m_id)
values (122, 795);
insert into MEDICATION_VISIT (v_id, m_id)
values (123, 420);
insert into MEDICATION_VISIT (v_id, m_id)
values (123, 438);
insert into MEDICATION_VISIT (v_id, m_id)
values (123, 532);
insert into MEDICATION_VISIT (v_id, m_id)
values (123, 544);
insert into MEDICATION_VISIT (v_id, m_id)
values (123, 548);
insert into MEDICATION_VISIT (v_id, m_id)
values (123, 632);
insert into MEDICATION_VISIT (v_id, m_id)
values (123, 686);
insert into MEDICATION_VISIT (v_id, m_id)
values (123, 718);
insert into MEDICATION_VISIT (v_id, m_id)
values (123, 768);
insert into MEDICATION_VISIT (v_id, m_id)
values (124, 431);
insert into MEDICATION_VISIT (v_id, m_id)
values (124, 504);
insert into MEDICATION_VISIT (v_id, m_id)
values (124, 538);
insert into MEDICATION_VISIT (v_id, m_id)
values (124, 553);
insert into MEDICATION_VISIT (v_id, m_id)
values (124, 675);
insert into MEDICATION_VISIT (v_id, m_id)
values (124, 794);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 430);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 501);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 522);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 538);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 545);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 569);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 600);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 630);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 650);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 668);
insert into MEDICATION_VISIT (v_id, m_id)
values (125, 757);
insert into MEDICATION_VISIT (v_id, m_id)
values (126, 481);
insert into MEDICATION_VISIT (v_id, m_id)
values (126, 516);
insert into MEDICATION_VISIT (v_id, m_id)
values (126, 694);
insert into MEDICATION_VISIT (v_id, m_id)
values (126, 721);
insert into MEDICATION_VISIT (v_id, m_id)
values (126, 765);
insert into MEDICATION_VISIT (v_id, m_id)
values (126, 786);
insert into MEDICATION_VISIT (v_id, m_id)
values (127, 409);
insert into MEDICATION_VISIT (v_id, m_id)
values (127, 470);
insert into MEDICATION_VISIT (v_id, m_id)
values (127, 487);
insert into MEDICATION_VISIT (v_id, m_id)
values (127, 498);
insert into MEDICATION_VISIT (v_id, m_id)
values (127, 514);
insert into MEDICATION_VISIT (v_id, m_id)
values (127, 650);
insert into MEDICATION_VISIT (v_id, m_id)
values (127, 679);
insert into MEDICATION_VISIT (v_id, m_id)
values (127, 742);
insert into MEDICATION_VISIT (v_id, m_id)
values (127, 786);
insert into MEDICATION_VISIT (v_id, m_id)
values (128, 505);
insert into MEDICATION_VISIT (v_id, m_id)
values (128, 553);
insert into MEDICATION_VISIT (v_id, m_id)
values (128, 596);
insert into MEDICATION_VISIT (v_id, m_id)
values (128, 642);
insert into MEDICATION_VISIT (v_id, m_id)
values (128, 790);
insert into MEDICATION_VISIT (v_id, m_id)
values (129, 506);
insert into MEDICATION_VISIT (v_id, m_id)
values (129, 511);
insert into MEDICATION_VISIT (v_id, m_id)
values (129, 538);
insert into MEDICATION_VISIT (v_id, m_id)
values (129, 789);
commit;
prompt 197 records loaded
prompt Enabling foreign key constraints for SHIPMENTADDRESS...
alter table SHIPMENTADDRESS enable constraint SYS_C008190;
prompt Enabling foreign key constraints for PATIENT...
alter table PATIENT enable constraint SYS_C008191;
prompt Enabling foreign key constraints for VISIT...
alter table VISIT enable constraint SYS_C008175;
prompt Enabling foreign key constraints for DOCTOR_VISIT...
alter table DOCTOR_VISIT enable constraint SYS_C008179;
alter table DOCTOR_VISIT enable constraint SYS_C008192;
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint SYS_C008128;
alter table ORDERS enable constraint SYS_C008129;
prompt Enabling foreign key constraints for EQUIPMENT...
alter table EQUIPMENT enable constraint SYS_C008135;
alter table EQUIPMENT enable constraint SYS_C008136;
prompt Enabling foreign key constraints for LOANS...
alter table LOANS enable constraint SYS_C008144;
alter table LOANS enable constraint SYS_C008145;
prompt Enabling foreign key constraints for MEDICATION_VISIT...
alter table MEDICATION_VISIT enable constraint SYS_C008188;
alter table MEDICATION_VISIT enable constraint SYS_C008189;
prompt Enabling triggers for CATALOG...
alter table CATALOG enable all triggers;
prompt Enabling triggers for CLIENTS...
alter table CLIENTS enable all triggers;
prompt Enabling triggers for DEPARTMENT...
alter table DEPARTMENT enable all triggers;
prompt Enabling triggers for SHIPMENTADDRESS...
alter table SHIPMENTADDRESS enable all triggers;
prompt Enabling triggers for PATIENT...
alter table PATIENT enable all triggers;
prompt Enabling triggers for VISIT...
alter table VISIT enable all triggers;
prompt Enabling triggers for DOCTOR_VISIT...
alter table DOCTOR_VISIT enable all triggers;
prompt Enabling triggers for EMPLOYEES...
alter table EMPLOYEES enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for EQUIPMENT...
alter table EQUIPMENT enable all triggers;
prompt Enabling triggers for LOANS...
alter table LOANS enable all triggers;
prompt Enabling triggers for MEDICINIES...
alter table MEDICINIES enable all triggers;
prompt Enabling triggers for MEDICATION_VISIT...
alter table MEDICATION_VISIT enable all triggers;
set feedback on
set define on
prompt Done.
