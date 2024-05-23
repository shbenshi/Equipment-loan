
[General]
Version=1

[Preferences]
Username=
Password=2526
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SHIRA
Name=LOANS
Count=100

[Record]
Name=LSERIALNUMBER
Type=NUMBER
Size=3
Data=Sequence(501)
Master=

[Record]
Name=LODATE
Type=DATE
Size=
Data=Random(01/01/2022, 01/01/2023)
Master=

[Record]
Name=URGENCY
Type=NUMBER
Size=1
Data=List('1', '2', '3')
Master=

[Record]
Name=RETURNDATE
Type=DATE
Size=
Data=Random(01/01/2023,01/01/2024 )
Master=

[Record]
Name=EID
Type=NUMBER
Size=3
Data=List(select EID from employees)
Master=

[Record]
Name=OSERIALNUMBER
Type=NUMBER
Size=3
Data=List(select OSerialNumber from Orders)
Master=

