<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD013 -->
# Autonomous Database

Ziel ist die Bereitstellung einer Autonomous Database Autonomous Transaction Processing [ATP].

_Oracle Database_ -> _Autonomous Database_ -> _Create Autonomous Database_. Stellen Sie sicher,
dass Sie sich im korrekten Compartment befinden.

<img src="./../../images/0x06-01-adb-01.png" width="900">

## Provide basic information for the Autonomous Database

| Item                                | Value                                    | Bemerkungen  |
|:------------------------------------|:-----------------------------------------|:-------------|
| Display name                        | adb-student-01                           | keine        |
| Database name                       | adbst01                                  | keine        |
| Workload type                       | Transaction Processing                   | keine        |
| Deployment type                     | Shared Infrastructure                    | keine        |
| Password                            | ADMIN Passwort                           | keine        |
| Confirm Password                    | ADMIN Passwort                           | keine        |
| Access type                         | Secure access from everywhere            | keine        |
| License type                        | BYOL                                     | keine        |
| Oracle Database Edition             | Oracle Database Standard Edition (SE)    | keine        |
| Contact Email                       | Eine gültige Mailadresse                 | keine        |

<img src="./../../images/0x06-01-adb-02.png" width="900">
<img src="./../../images/0x06-01-adb-03.png" width="900">
<img src="./../../images/0x06-01-adb-04.png" width="900">

Die restlichen Einstellungen belassen, _Create Autonomous Database_. Sie erhalten ein E-Mail
wenn die ATP bereit ist.

<img src="./../../images/0x06-01-adb-05.png" width="900">

## SQL Developer Connect

Verbinden Sie ihren lokalen SQL Developer mit der ATP. Dazu muss das File mit den Connection-Informationen runtergeladen
werden. Wichtig: Das File muss nicht entpackt werden.

_ADB_ -> _DB Connection_ -> _Download Wallet_

<img src="./../../images/0x06-01-adb-06.png" width="900">

### SQL Developer einrichten

 Starten Sie ihren lokalen SQL Developer and legen Sie eine neue Verbindung an.

| Item                                | Value                                    | Bemerkungen  |
|:------------------------------------|:-----------------------------------------|:-------------|
| Benutzername                        | ADMIN                                    | keine        |
| Kennwort                            | ADMIN Passwort                           | keine        |
| Verbindungstyp                      | Cloud Wallet                             | keine        |
| Konfigurationsdatei                 | Die Wallet-Zip Datei                     | keine        |
| Password                            | ADMIN Passwort                           | keine        |

Testen Sie die Verbindung und Speichern Sie sie.

<img src="./../../images/0x06-01-adb-07.png" width="900">

Die Autonomous Database steht zur Verwendung bereit. Testen Sie das Demo Dataset im Schema _SSB_.

```bash
select /* low */ c_city,c_region,count(*)
from ssb.customer c_low
group by c_region, c_city
order by count(*);
```

<img src="./../../images/0x06-01-adb-08.png" width="900">
