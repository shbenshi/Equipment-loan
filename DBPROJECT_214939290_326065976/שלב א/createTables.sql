CREATE TABLE Catalog
(
  CatSerialNumber number(3),
  TypeCat VARCHAR2(15) NOT NULL,
  Amount number(5) NOT NULL,
  PRIMARY KEY (CatSerialNumber)
);
CREATE TABLE Employees
(
  EID number(3),
  eName VARCHAR2(15) NOT NULL,
  Salary number(7) NOT NULL,
  EPhoneNumber varchar2(10) NOT NULL,
  PRIMARY KEY (EID)
);


CREATE TABLE Clients
(
  CID number(3),
  cName varchar2(15) NOT NULL,
  cRole varchar2(15) CHECK(cRole='doctor' or cRole='nurse' or cRole='assistant'),
  cPhoneNumber varchar2(10) NOT NULL,
  PRIMARY KEY (CID)
);

CREATE TABLE ShipmentAddress
(
  HospitalName varchar2(20) check(hospitalname='soroka' or hospitalname='hadsa' or hospitalname='shaarey tzedek'),
  hFloor number(2) NOT NULL,
  hRoom number(3) NOT NULL,
  shipID number(3),
  PRIMARY KEY (shipID)
);

CREATE TABLE Orders
(
  OrDate date NOT NULL,
  OserialNumber number(3),
  PaymentMethod varchar2(15) check(paymentmethod='bit' or paymentmethod='paybox' or paymentmethod='cash' or paymentmethod='credit card'),
  CID number(3) NOT NULL,
  shipID number(3) NOT NULL,
  PRIMARY KEY (OserialNumber),
  FOREIGN KEY (CID) REFERENCES Clients(CID),
  FOREIGN KEY (shipID) REFERENCES ShipmentAddress(shipID)
);
CREATE TABLE Loans
(
  LserialNumber number(3),
  LoDate DATE NOT NULL,
  Urgency number(1) check(urgency=1 or urgency=2 or urgency=3),
  returnDate DATE NOT NULL,
  EID number(3) NOT NULL,
  oserialnumber number(3) not null unique,
  PRIMARY KEY (LserialNumber),
  FOREIGN KEY (EID) REFERENCES Employees(EID),
  FOREIGN KEY (oserialnumber) REFERENCES orders(oserialnumber)
);

CREATE TABLE Equipment
(
  EqSerialNumber number(3),
  Validity date NOT NULL,
  LastUse date,
  CatSerialNumber number(3) not null,
  OserialNumber number(3),
  PRIMARY KEY (EqSerialNumber),
  FOREIGN KEY (CatSerialNumber) REFERENCES Catalog(CatSerialNumber),
  FOREIGN KEY (OserialNumber) REFERENCES Orders(OserialNumber)
);
