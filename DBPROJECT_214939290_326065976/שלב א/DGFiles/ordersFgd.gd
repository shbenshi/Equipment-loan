
[General]
Version=1

[Preferences]
Username=
Password=2618
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SHIRA
Name=ORDERS
Count=100

[Record]
Name=ORDATE
Type=DATE
Size=
Data=Random(01/01/2020, 01/01/2022)
Master=

[Record]
Name=OSERIALNUMBER
Type=NUMBER
Size=3
Data=Sequence(1)
Master=

[Record]
Name=PAYMENTMETHOD
Type=VARCHAR2
Size=15
Data=List('bit', 'cash', 'paybox', 'credit card')
Master=

[Record]
Name=CID
Type=NUMBER
Size=3
Data=List(select CID from clients)
Master=

[Record]
Name=SHIPID
Type=NUMBER
Size=3
Data=List(select shipID from ShipmentAddress)
Master=

