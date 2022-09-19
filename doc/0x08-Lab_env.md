---
title: "Lab Umgebung"
permalink: /doc/lab/
excerpt: "Einführung in den OCI Workshop (O-OCI-WS)"
---
<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD025 -->
<!-- markdownlint-configure-file { "MD024":{"allow_different_nesting": true }} -->

# OCI Walkthrough
<!-- markdownlint-disable MD041 -->
<!-- markdownlint-disable MD051 -->
## Architektur

Gemeinsam bauen wir folgende Infrastruktur in der *Region Germany Central (Frankfurt)*:

- Virtual Cloud Network VCN
- Compute Instances mit Public Load Balancer
- Database Service
- Eine Verbindung von der Compute Instance zur Oracle Datenbank
- Eine Autonomous Database ATP
- Upload zum OCI Object Storage

![DOAG 2022 Architektur](../../images/1x01-01-architecture.png)

# Oracle Unified Directory Workshop

## Architecture

For the practical work in the context of the O-OUD workshop, a simple test
environment is available to each participant. The environment runs for the
duration of the training in the Oracle Cloud Infrastructure
[OCI](https://www.oracle.com/cloud/) and consists of the following servers or
compute instances, as shown in the following figure:

- ***ooud-bastionNN.trivadislabs.com*** Bastion Host for access to the environment.
- ***oud1.trivadislabs.com*** Oracle Unified Directory Server 1 with an OUD EUS
  instance and OUDSM console.
- ***oud2.trivadislabs.com*** Oracle Unified Directory Server 2 with an OUD EUS
  instance and OUDSM console.
- ***db19.trivadislabs.com*** Oracle Database 19c Server with two DBs.
- ***win.trivadislabs.com*** MS Windows Server 2019 as workstation.

!["O-OUD Lab Environment"](../images/O-OUD-LAB_env.png)

## Logins and Information

| User DN                                                           | Password      |
|-------------------------------------------------------------------|---------------|
| cn=Directory Manager                                              | LAB01Schulung |
| cn=eusadmin,cn=oraclecontext                                      | LAB01Schulung |
| cn=Ben King,ou=Senior Management,ou=People,dc=trivadislabs,dc=com | LAB01Schulung |

Table: Access information OUD instance *oud_tvdlab*

| ORACLE_SID | CDB or PDB                        | User   | Password       |
|------------|-----------------------------------|--------|----------------|
| TCPU19C    | Oracle 19c container database     | SYS    | LAB42-Schulung |
| TCPU19C    | Oracle 19c container database     | SYSTEM | LAB42-Schulung |
| PDB1       | Oracle 19c pluggable database     | TVD_HR | tvd_hr         |
| PDB1       | Oracle 19c pluggable database     | SCOTT  | tiger          |
| TCPU19S    | Oracle 19c single tenant database | SYS    | LAB42-Schulung |
| TCPU19S    | Oracle 19c single tenant database | SYSTEM | LAB42-Schulung |
| TCPU19S    | Oracle 19c single tenant database | TVD_HR | tvd_hr         |
| TCPU19S    | Oracle 19c single tenant database | SCOTT  | tiger          |

Table: Access information databases

## Oracle Unified Directory Server

### General Server Configuration

The latest version of OUD and OUDBase is installed on the OUD servers. Access is
exclusively via SSH as user *opc* and *oracle* respectively. Both users are
authorized to run `sudo`.

- **Host name :** oud1.trivadislabs.com
- **internal IP address :** 10.0.1.41
- **Host name :** oud2.trivadislabs.com
- **Internal IP address :** 10.0.1.42
- **Operating system :** Oracle Enterprise Linux Server Release 7.9
- **Java :** Oracle JAVA Server JRE 1.8 u271
- **Oracle Fusion Middleware Software :**
  - Oracle Unified Directory (12.2.1.4) with the August 2020 Bundle Patch
  - Oracle Fusion Middleware Infrastructure Directory (12.2.1.4) with the Bundle
    January 2021 patch
- **Oracle Home oud12.2.1.4 :** Oracle Unified Directory *standalone* installation.
- **Oracle Home fmw12.2.1.4 :** Oracle Unified Directory *collocated*
  installation with Oracle Fusion Middleware Infrastructure.
- **Betriebsystem Benutzer :**
  - oracle / SSH
  - opc / SSH

### Oracle Unified Directory OUD

One OUD instance *oud_tvdlab* is created on each of the three OUD servers.
Replication has been configured for the two instances.

- **OUD admin** cn=Directory Manager
- **Password** LAB01Schulung
- **Base DN** dc=trivadislabs,dc=com
- **LDAP port** 1389
- **LDAPS port** 1636
- **Admin port** 4444
- **Replication port** 8989

### Oracle Unified Directory Services Manager (OUDSM)

An OUDSM console is also running on all OUD servers.

- **WLS admin** weblogic
- **Password** LAB01Schulung
- **Base DN** dc=trivadislabs,dc=com
- **HTTP port** 7001
- **HTTPS port** 7002

### Domain trivadislab.com

To enable a more or less practical connection to the directory, a simple
directory structure was created for the fictitious company *Trivadis LAB*.
The following figure shows the organization chart including departments and
employees for *Trivadis LAB*. All listed users can be used as test users. The
login name corresponds to the last name in lower case. Password for all users is
*LAB01training*.

!["Trivadis LAB Company"](../images/Trivadislabs_Company.png)

The fictitious company has the following departments:

| ID | Department             | Distinguished Name (DN)                                        | Description          |
|----|------------------------|----------------------------------------------------------------|----------------------|
| 10 | Senior Management      | ``ou=Senior Management,ou=People,dc=trivadislabs,dc=com``      | Management           |
| 20 | Accounting             | ``ou=Accounting,ou=People,dc=trivadislabs,dc=com``             | Finance department   |
| 30 | Research               | ``ou=Research,ou=People,dc=trivadislabs,dc=com``               | R&D department       |
| 40 | Sales                  | ``ou=Sales,ou=People,dc=trivadislabs,dc=com``                  | Sales department     |
| 50 | Operations             | ``ou=Operations,ou=People,dc=trivadislabs,dc=com``             | Operation department |
| 60 | Information Technology | ``ou=Information Technology,ou=People,dc=trivadislabs,dc=com`` | IT department        |
| 70 | Human Resources        | ``ou=Human Resources,ou=People,dc=trivadislabs,dc=com``        | HR department        |

Table: Trivadis LAB Company departments

In addition, the following groups have been defined:

| Group                      | Distinguished Name (DN)                                            | Description                             |
|----------------------------|--------------------------------------------------------------------|-----------------------------------------|
| Trivadis LAB APP Admins    | ``ou=Trivadis LAB APP Admins,ou=Groups,dc=trivadislabs,dc=com``    | Application Administrators              |
| Trivadis LAB DB Admins     | ``ou=Trivadis LAB DB Admins,ou=Groups,dc=trivadislabs,dc=com``     | DB Admins from IT department            |
| Trivadis LAB Developers    | ``ou=Trivadis LAB Developers,ou=Groups,dc=trivadislabs,dc=com``    | Developers from the Research Department |
| Trivadis LAB Management    | ``ou=Trivadis LAB Management,ou=Groups,dc=trivadislabs,dc=com``    | Management and Managers                 |
| Trivadis LAB System Admins | ``ou=Trivadis LAB System Admins,ou=Groups,dc=trivadislabs,dc=com`` | System Admins from IT Department        |
| Trivadis LAB Users         | ``ou=Trivadis LAB Users,ou=Groups,dc=trivadislabs,dc=com``         | All Users                               |

Table: Trivadis LAB Company groups

## Oracle Database Server

### General server configuration

The Oracle Database Server is configured as follows:

- **Host name :** db19.trivadislabs.com
- **internal IP address :** 10.0.0.19
- **Operating system :** Oracle Enterprise Linux Server Release 7.59
- **Oracle database binaries :**
  - Oracle 19c Enterprise Edition (19.10.0.0) with Release Update from
    January 2021
- **Oracle databases :**
  - **TCPU19C** Oracle 19c Enterprise Edition container database with one
    pluggable databases PDB1.
  - **TCPU19S** Oracle 18c Enterprise Edition single tenant database
- **OS user :**
  - oracle / n/a
  - root / n/a
- **Database user :**
  - sys / LAB42-Schulung
  - system / LAB42-Schulung
  - scott / tiger
  - tvd_hr / tvd_hr

### Trivadis BasEnv

The Trivadis Base Environment (TVD-BasenvTM) allows easy navigation in the
directory structure and between the different databases. The following table
lists the aliases for the OS user *oracle* which are used most frequently.

| Alias Name | Description                                                              |
|------------|--------------------------------------------------------------------------|
| cda        | to the admin directory of the currently set database                     |
| cdh        | to the Oracle Home                                                       |
| cdob       | to Oracle Base                                                           |
| cdt        | to TNS_ADMIN                                                             |
| sqh        | starts SQLPlus with "sqlplus / as sysdba" including command history      |
| sta        | status display for the currently set database                            |
| taa        | opens the alert log of the currently set database with ``tail -f``       |
| TDB122A    | sets the environment in the terminal for the database *TDB122A*          |
| TDB184A    | sets the environment in the terminal for the database *TDB184A*          |
| u          | status display for all Oracle databases and listeners (e.g. open, mount) |
| via        | opens the alertlog of the currently set database in vi                   |

Table: TVD-BasenvTM aliases

The installation has been done according to the OFA (Optimal Flexible Architecture)
standard - example of installation on the database VM for the database - *TCPU19C*:

| Mount Point / Directory                   | Description                             |
|-------------------------------------------|-----------------------------------------|
| ``/u00/app/oracle/admin/TCPU19C/adump``   | Oracle Audit Files                      |
| ``/u00/app/oracle/admin/TCPU19C/backup``  | Oracle Backup                           |
| ``/u00/app/oracle/admin/TCPU19C/dpdump``  | Data Pump Files                         |
| ``/u00/app/oracle/admin/TCPU19C/etc``     | Oracle Backup Config Files              |
| ``/u00/app/oracle/admin/TCPU19C/log``     | Log files (e.g. backup, export, etc.)   |
| ``/u00/app/oracle/admin/TCPU19C/pfile``   | parameter and password file             |
| ``/u00/app/oracle/admin/TCPU19C/wallet``  | Oracle Wallet                           |
| ``/u00/app/oracle/etc``                   | oratab and various configuration files  |
| ``/u00/app/oracle/local/dba``             | Environment Tools (TVD-Basenv)          |
| ``/u00/app/oracle/network/admin``         | Oracle Net configuration files          |
| ``/u00/app/oracle/product/12.2.0.1``      | Oracle 12.2.0.1 Home                    |
| ``/u00/app/oracle/product/18.4.0.0``      | Oracle 18.4.0.0 Home                    |
| ``/u01/oradata/TCPU19C``                  | Database Files, Redo Log Files, CTL     |
| ``/u02/fast_recovery_area/TCPU19C``       | Fast Recovery Area                      |
| ``/u02/oradata/TCPU19C``                  | Redo Log Files, CTL                     |

Table: TVD-BasenvTM DB path

### Exercise scheme TVD_HR

In addition to the Scott demo schema, the databases also contain the *TVD_HR*
example schema. The *TVD_HR* schema is based on the well-known Oracle *HR*
example schema. The main difference to the regular *HR* schema is that the
departments as well as employees correspond to the employees in the Active
Directory.

Explanation of the tables based on the comments from the *HR* schema:

- **REGIONS** table, which contains region numbers and names. References to the
  *LOCATION* table.
- **LOCATIONS** Tablle containing the specific address of a particular office,
  warehouse, and/or manufacturing location of a company. Does not store
  addresses of customer locations.
- **DEPARTMENTS** Table showing details of the departments in which employees
  work. References to locations, employees, and job history tables.
- **JOB_HISTORY** Table that stores the employment history of employees. When an
  employee changes departments within the job or changes jobs within the
  department, new rows are added to this table with old job information for the
  employee. References to tables with jobs, employees and departments.
- **COUNTRIES** table. References with the locations table.
- **JOBS** table with job titles and pay grades. References to employees and
  job history table.
- **EMPLOYEES** Table. References with departments, jobs, job history tables.
  Contains a self-reference.

TVD_HR does also include additionally VPD policies which match the EUS configuration.

## Windows Server 2019

The Windows server is configured as a workstation. Additionally, tools like
Putty, WinSCP, Visual Studio Code etc. are installed.

- **Host name :** win.trivadislabs.com
- **Interne IP Adresse :** 10.0.0.50
- **Operating system :** MS Windows Server 2019
- **Zusatz Software :**
  - Putty for SSH connections with the OUD and DB Server
  - MobaXTerm for SSH connections with OUD and DB Server
  - WinSCP for file transfer DB server <=> AD server
  - MS Visual Studio Code as a universal text editor
  - Softterra LDAP Browser
  - Oracle SQL Developer
  - Predefined SSH keys for the OUD and DB servers
- **Operating system user :**
  - Administrator / LAB42-Schulung
