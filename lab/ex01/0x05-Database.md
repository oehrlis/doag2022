<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD013 -->
# Database

Ziel ist die Bereitstellung einer Oracle Datenbank in der Availability Domain 2 Region Frankfurt.

_Oracle Database_ -> _Oracle Base Database (VM, BM)_ -> um eine Datenbank bereit zu stellen.
_Create DB system_ anklicken.

<img src="./../../images/0x01-05-database-01.png" width="900">

## DB system information

| Item                                | Value                                    | Bemerkungen  |
|:------------------------------------|:-----------------------------------------|:-------------|
| Name                                | dbsys-doag-student-01                    | keine        |
| Placement                           | AD2                                      | keine        |
| Storage management software         | Logical Volume Manager                   | keine        |
| Storage volume performance          | Balanced                                 | keine        |
| Shape Type                          | Virtual Machine                          | keine        |
| Shape                               | VM.Standard.E4.Flex - 2 core OCPU, 32    | keine        |
| Oracle Database software edition    | Standard Edition                         | keine        |
| Add SSH keys                        | <Public Key>                             | keine        |
| License type                        | License included                         | keine        |
| Virtual cloud network               | vcn-doag-student-01                      | keine        |
| Client subnet                       | sn-doag-student-01-private-db            | keine        |
| Hostname prefix                     | dbsys01                                  | keine        |
| Private IP address                  | 10.0.3.50                                | keine        |

<img src="./../../images/0x01-05-database-02.png" width="900">
<img src="./../../images/0x01-05-database-03.png" width="900">
<img src="./../../images/0x01-05-database-04.png" width="900">
<img src="./../../images/0x01-05-database-05.png" width="900">
<img src="./../../images/0x01-05-database-06.png" width="900">

Die restlichen Einstellungen belassen, _Next_.

## Database information

| Item                                | Value                                    | Bemerkungen  |
|:------------------------------------|:-----------------------------------------|:-------------|
| Database name                       | DBDOAG01                                 | keine        |
| PDB name                            | pdbdoag01                                | keine        |
| Password                            | SYS-Password                             | keine        |
| Confirm password                    | SYS-Password                             | keine        |

<img src="./../../images/0x01-05-database-07.png" width="900">

Die restlichen Einstellungen belassen, mit Klick auf _Create DB system_ wird die Resource erstellt und anschliessend angezeigt. Die Erstellung dauert ca. 30 Minuten.

<img src="./../../images/0x01-05-database-08.png" width="900">
