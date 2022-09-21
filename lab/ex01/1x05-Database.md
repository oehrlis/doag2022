---
title: "DB System"
permalink: /lab/oci-db-system/
excerpt: "Erstellen eines DB Systems"
---
<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD025 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD041 -->
## Database System

### Übungsziele {.unlisted .unnumbered}

Ziel ist die Bereitstellung einer Oracle Datenbank in der Availability Domain 2 Region Frankfurt.

### Aufgaben {.unlisted .unnumbered}

- Übersicht zu den DB Systemen finden
- Einfaches DB System erstellen
- Zugriff via SSH / Cloud Shell sicherstellen

### DB system in OCI

to be documented

_Oracle Database_ -> _Oracle Base Database (VM, BM)_ -> um eine Datenbank bereit zu stellen.
_Create DB system_ anklicken.

![OCI DB System Overview](../../images/1x01-05-database-01.png)

### DB System Informationen

| Item                                | Value                                    | Bemerkungen  |
|:------------------------------------|:-----------------------------------------|:-------------|
| Name                                | dbsys-doag-student-01                    | keine        |
| Placement                           | AD2                                      | keine        |
| Storage management software         | Logical Volume Manager                   | keine        |
| Storage volume performance          | Balanced                                 | keine        |
| Shape Type                          | Virtual Machine                          | keine        |
| Shape                               | VM.Standard.E4.Flex - 2 core OCPU        | keine        |
| Storage                             | Logical Volume Manager                   | keine        |
| Total Node Count                    | 1                                        | keine        |
| Oracle Database software edition    | Standard Edition                         | keine        |
| Add SSH keys                        | <Public Key>                             | keine        |
| License type                        | License included                         | keine        |
| Virtual cloud network               | vcn-doag-student-01                      | keine        |
| Client subnet                       | sn-doag-student-01-private-db            | keine        |
| Hostname prefix                     | dbsys01                                  | keine        |
| Private IP address                  | 10.0.3.50                                | keine        |

![OCI Create DB System Dialog part I](../../images/1x01-05-database-02.png)
![OCI Create DB System Dialog part II](../../images/1x01-05-database-03.png)
![OCI Create DB System Dialog part III](../../images/1x01-05-database-04.png)
![OCI Create DB System Dialog part IV](../../images/1x01-05-database-05.png)
![OCI Create DB System Dialog part V](../../images/1x01-05-database-06.png)

Die restlichen Einstellungen belassen, _Next_.

### Database Informationen

| Item                                | Value                                    | Bemerkungen  |
|:------------------------------------|:-----------------------------------------|:-------------|
| Database name                       | DBDOAG01                                 | keine        |
| PDB name                            | pdbdoag01                                | keine        |
| Password                            | SYS-Password                             | keine        |
| Confirm password                    | SYS-Password                             | keine        |

![OCI Create DB System Admin Password](../../images/1x01-05-database-07.png)

Die restlichen Einstellungen belassen, mit Klick auf _Create DB system_ wird die Resource erstellt und anschliessend angezeigt. Die Erstellung dauert ca. 30 Minuten.

![OCI DB System Details](../../images/1x01-05-database-08.png)

### SSH-Verbindung von der Cloud Console zur Database Private IP

Stellen Sie sicher das die Cloud Console das Netzwerk auf _Private_ und das Subnetz der Datenbank eingestellt hat. Der OS User für die Database Instance heisst _opc_ und hat sudo-Berechtigungen. Es wird der private SSH Key und die Private IP benötigt.

```bash
[oracle@dbsys01 ~]$ ssh -i ~/.ssh/id_rsa_student01 opc@10.0.3.50
```

![OCI DB System Shell Access](../../images/1x01-05-database-09.png)

Wechseln Sie um OS User oracle and setzen Sie die Umgebungsvariablen. Prüfen Sie, ob der PMON-Prozess
läuft.

```bash
[oracle@dbsys01 ~]$ sudo su - oracle
[oracle@dbsys01 ~]$ ps -ef | grep pmon
```

Verbinden Sie als SYSDBA zur Pluggable Database. Der Service-Name ist mit _lsnrctl_ zu sehen.

```bash
# Service Name der Pluggable Database anzeigen
[oracle@dbsys01 ~]$ lsnrctl status | grep pdbdoag01
Service "pdbdoag01.snstudentprv02.vcndoagstudent0.oraclevcn.com" has 1 instance(s).

# Easy Connect
[oracle@dbsys01 ~]$ sqlplus sys@//dbsys01/pdbdoag01.snstudentprv02.vcndoagstudent0.oraclevcn.com as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Wed Sep 14 12:58:56 2022
Version 19.16.0.0.0

Copyright (c) 1982, 2022, Oracle.  All rights reserved.

Enter password: 

Connected to:
Oracle Database 19c Standard Edition 2 Release 19.0.0.0.0 - Production
Version 19.16.0.0.0

SQL> SELECT * FROM global_name;

GLOBAL_NAME
--------------------------------------------------------------------------------
PDBDOAG01.SNSTUDENTPRV02.VCNDOAGSTUDENT0.ORACLEVCN.COM

SQL> show pdbs

    CON_ID CON_NAME                       OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
         3 PDBDOAG01                      READ WRITE NO

SQL> exit
``

Beenden Sie die Konsolenverbindung zur Datenbank sod das Sie wieder in der lokalen CLoud Shell sind.

```bash
[oracle@dbsys01 ~]$ exit
[opc@dbsys01 ~]$ exit
````

### SQL*Net Verbindung von der Private Compute Instance zur Database Private IP

Stellen Sie sicher das die Cloud Console das Netzwerk auf das Subnet der Applikation eingestellt hat.

<img src="../../images/0x01-05-database-10.png" width="900">

Der OS User für die Compute Instance heisst _opc_ und hat sudo-Berechtigungen. Es wird der private SSH Key und die Private IP benötigt. Die  IP-Adresse ist auf Stufe Datenbanke unter der Resource _Nodes_ zu finden.

```bash
ssh -i ~/.ssh/id_rsa_student01 opc@10.0.2.10
```

<img src="../../images/0x01-05-database-11.png" width="900">

Bleiben Sie zur Installation vom Oracle Instant Client mit der Compute Instance als User _opc_ verbunden.

```bash
sudo dnf list installed | grep instantclient
sudo dnf -y install oracle-instantclient-release-el8
sudo dnf -y install oracle-instantclient-basic
sudo dnf -y install oracle-instantclient-sqlplus
```

# Easy Connect vom Applikationsserver

Da der DNS-Name aktuell nicht bekannt ist, verwenden wir die IP vom Datenbankserver.

```bash
[oracle@dbsys01 ~]$ sqlplus sys@//10.0.3.50/pdbdoag01.snstudentprv02.vcndoagstudent0.oraclevcn.com as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Wed Sep 14 12:58:56 2022
Version 19.16.0.0.0

Copyright (c) 1982, 2022, Oracle.  All rights reserved.

Enter password:

Connected to:
Oracle Database 19c Standard Edition 2 Release 19.0.0.0.0 - Production
Version 19.16.0.0.0

SQL> SELECT * FROM global_name;

GLOBAL_NAME
--------------------------------------------------------------------------------
PDBDOAG01.SNSTUDENTPRV02.VCNDOAGSTUDENT0.ORACLEVCN.COM

SQL> SELECT host_name FROM v$instance;

HOST_NAME
----------------------------------------------------------------
dbsys01
```

Beenden Sie die Konsolenverbindung zur Datenbank sod das Sie wieder in der lokalen CLoud Shell sind.

```bash
[opc@ci-doag-student-01-lb-1 ~]$ exit
```
