
[General]
Version=1

[Preferences]
Username=
Password=2359
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SHIRA
Name=EQUIPMENT
Count=100

[Record]
Name=EQSERIALNUMBER
Type=NUMBER
Size=3
Data=Sequence(1)
Master=

[Record]
Name=VALIDITY
Type=DATE
Size=
Data=Random(01/01/2024, 01/01/2025)
Master=

[Record]
Name=LASTUSE
Type=DATE
Size=
Data=Random(01/01/2023, 01/01/2024)
Master=

[Record]
Name=CATSERIALNUMBER
Type=NUMBER
Size=3
Data=List(select catSerialNumber from Catalog)
Master=

[Record]
Name=OSERIALNUMBER
Type=NUMBER
Size=3
Data=List(select OserialNumber from Orders)
Master=

