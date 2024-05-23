
[General]
Version=1

[Preferences]
Username=
Password=2581
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SHIRA
Name=CLIENTS
Count=100

[Record]
Name=CID
Type=NUMBER
Size=3
Data=Sequence(401)
Master=

[Record]
Name=CNAME
Type=VARCHAR2
Size=15
Data=FirstName' 'LastName
Master=

[Record]
Name=CROLE
Type=VARCHAR2
Size=15
Data=List('doctor','nurse','assistant')
Master=

[Record]
Name=CPHONENUMBER
Type=VARCHAR2
Size=10
Data='05'[00000000]
Master=

