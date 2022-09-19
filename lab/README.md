---
title: "Workshop Übersicht"
permalink: /lab/
excerpt: "Einführung in den OCI Workshop (O-OCI-WS)"
---
<!-- markdownlint-disable MD025 -->
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
| 01 | [Architektur](../doc/0x08-Lab_env.md)    | Übersicht der OCI Architektur für den Walkthrough.       | 10    |
| 02 | [OCI Login](ex01/1x02-Login.md)          | Erstes Login in Oracle Cloud Infrastructure (OCI)        | 15    |

Table: Workshop Übungen zum Thema Einführung

## OCI Walkthrough

| ID | Thema                                                      | Beschreibung                                                | Dauer |
|----|------------------------------------------------------------|-------------------------------------------------------------|-------|
| 03 | [Netzwerk](ex01/1x03-Network.md)                           | Konfiguration von Virtual Cloud Networks                    | 15    |
| 04 | [Compute](ex01/1x04-Compute-Basic.md)                      | Konfiguration einer Compute Instance                        | 15    |
| 04 | [Compute Load Balancer](ex01/1x04-Compute-LoadBalancer.md) | Konfiguration von Compute Instances mit einem Load Balancer | 20    |
| 04 | [Compute Block Volume](ex01/1x04-Compute-BlockVolume.md)   | Konfiguration von Block Volumes für eine Compute Instance   | 20    |
| 05 | [DB System](ex01/1x05-Database.md)                         | Konfiguration eines DB Systems                              | 30    |
| 06 | [Autonomous](ex01/1x06-Autonomous.md)                      | Konfiguration einer Autonomous Databases                    | 30    |
| 07 | [Object Store](ex01/1x07-Object-Storage.md)                | Konfiguration von Object Storages                           | 15    |
| 08 | [OCI Command line](ex01/1x08-OCI-CLI.md)                   | Konfiguration und Einsatz des OCI Command Line Utilities    | 15    |

Table: Workshop Übungen zum Thema OCI Walkthrough

## Terraform Kickstart

| ID | Thema                                                       | Beschreibung                                                   | Dauer |
|----|-------------------------------------------------------------|----------------------------------------------------------------|-------|
| 09 | [Login](ex09/1x01-tf-login.md)                              | Konfiguration Terraform Login und erste Schritte mit Terraform | 10    |
| 10 | [Netzwerk](ex10/1x01-tf-network.md)                         | Erstellen und Konfiguration von Virtual Cloud Networks         | 20    |
| 11 | [Compute Instance](ex11/1x01-tf-compute-basic.md)           | Erstellen von Compute Instances                                | 20    |
| 12 | [Compute Instance Anpassen](ex12/1x01-tf-compute-adv.md)    | Anpassung von Compute Instances                                | 20    |
| 13 | [Compute Block Volume](ex13/1x01-tf-compute-blockvolume.md) | Konfiguration von Block Volumes für eine Compute Instance      | 20    |
| 14 | [DB System](ex14/1x01-tf-database.md)                       | Konfiguration eines DB Systems                                 | 20    |
| 15 | [Autonomous](ex15/1x01-tf-autonomous.md)                    | Konfiguration einer Autonomous Databases                       | 20    |
| 16 | [Modules](ex16/1x01-tf-modules.md)                          | Verwendung von Terraform Modulen                               | 20    |
| 17 | [OCI Stacks](ex17/1x01-tf-oci-stacks.md)                    | Nutzung von OCI Stacks                                         | 20    |

Table: Workshop Übungen zum Thema Terraform Kickstart
