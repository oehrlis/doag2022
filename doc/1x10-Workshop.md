<!-- markdownlint-disable MD025 -->
<!-- markdownlint-disable MD051 -->
<!-- markdownlint-configure-file { "MD013": { "tables": false } } -->
# Übungen

Die Übungen sind in einzelnen Verzeichnissen gruppiert und können Teilweise
unabhängig voneinander durchgeführt werden. Jede Übung enthält mindestens eine kurze
Beschreibung der Aufgaben sowie eine Lösung. Darüber hinaus sind Skripte, etc.
Bestandteil jeder Übung. Für Übungen, bei denen Software (Oracle Binaries, Patch)
oder Code aus anderen Git-Repositories benötigt wird, verweisen wir entsprechend
darauf. Alle Übungen stehen auch via GitHub Repository
[oehrlis/doag2022](https://github.com/oehrlis/doag2022) zur Verfügung.

## Einführung

| ID | Thema                                    | Beschreibung                                             | Dauer |
|----|------------------------------------------|----------------------------------------------------------|-------|
| 01 | [Architektur](#architektur)              | Übersicht der OCI Architektur für den Walkthrough.       | 10    |
| 02 | [OCI Login](#oci-konsole-login)          | Erstes Login in Oracle Cloud Infrastructure (OCI)        | 15    |

Table: Workshop Übungen zum Thema Einführung

## OCI Walkthrough

| ID | Thema                                                      | Beschreibung                                                | Dauer |
|----|------------------------------------------------------------|-------------------------------------------------------------|-------|
| 03 | [Netzwerk](#vcn-basics)                          | Konfiguration von Virtual Cloud Networks                    | 15    |
| 04 | [Compute](#simple-compute-instance)                       | Konfiguration einer Compute Instance                        | 15    |
| 04 | [Compute Load Balancer](#compute-instances-mit-load-balancer) | Konfiguration von Compute Instances mit einem Load Balancer | 20    |
| 04 | [Compute Block Volume](#compute-instance-mit-block-volume)   | Konfiguration von Block Volumes für eine Compute Instance   | 20    |
| 05 | [DB System](ex01/1x05-Database.md)                         | Konfiguration eines DB Systems                              | 30    |
| 06 | [Autonomous](ex01/1x05-Database.md)                        | Konfiguration einer Autonomous Databases                    | 30    |
| 07 | [Object Store](ex01/0x06-Autonomous.md)                    | Konfiguration von Object Storages                           | 15    |
| 08 | [OCI Command line](ex01/0x08-OCI-CLI.md)                   | Konfiguration und Einsatz des OCI Command Line Utilities    | 15    |

Table: Workshop Übungen zum Thema OCI Walkthrough

## Terraform Kickstart

| ID | Thema                                    | Beschreibung                                             | Dauer |
|----|------------------------------------------|----------------------------------------------------------|-------|
| 03 | [Netzwerk](ex02/1x03-Network.md)         | Konfiguration von Virtual Cloud Networks                 | 20    |
| 04 | [Compute](ex02/0x04-Compute.md)          | Konfiguration von Compute Instances                      | 20    |

Table: Workshop Übungen zum Thema Terraform Kickstart