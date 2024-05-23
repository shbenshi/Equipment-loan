
[General]
Version=1

[Preferences]
Username=
Password=2979
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SHIRA
Name=EMPLOYEES
Count=100

[Record]
Name=EID
Type=NUMBER
Size=3
Data=Sequence(501)
Master=

[Record]
Name=ENAME
Type=VARCHAR2
Size=15
Data=FirstName' 'LastName
Master=

[Record]
Name=SALARY
Type=NUMBER
Size=7
Data=Random(100, 999999)
Master=

[Record]
Name=EPHONENUMBER
Type=VARCHAR2
Size=10
Data='05'[00000000]
Master=

