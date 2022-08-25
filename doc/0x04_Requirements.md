# Anforderungen Workshop Umgebung

Im Rahmen des Workshop ***O-DB-DOCKER*** *Oracle-Datenbanken in Docker-Container* besteht die Gelegenheit verschiedene Themen am praktischen Beispiel zu vertiefen. Dazu wird jedem Teilnehmer eine Compute Node in der Oracle Cloud für die Zeitdauer des DOAG Schulungstages zur Verfügunggestellt. Alternativ können die Teilnehmer die Übungen zudem in einer eigenen lokalen VM oder Docker Umgebung ausführen. Die Teilnehmer können frei wählen, welche Umgebung sie für den Workshop nutzen möchten. Allerdings ist das Einrichten der lokalen VM bzw. der lokalen Docker-Umgebung nicht Teil des Workshops selbst. Die folgende Zusammenstellung gibt eine kurze Übersicht der verschiedenen Anforderungen an die drei Workshop Umgebungen.

Ausführliche Informationen zur Workshop Umgebung, Unterlagen, Anleitungen etc. sind im Vorfeld zum DOAG Schulungstag via [DOAG2019 O-DB-DOCKER](https://url.oradba.ch/DOAG2019_O-DB-DOCKER) verfügbar. Falls sie Fragen haben, zögern Sie nicht, am Trivadis-Stand vorbei zu kommen und nach Stefan Oehrli zu Verlangen.

## Voraussetzungen und Skills

Die verschiedenen Übungen des Workshop erlauben den schrittweise Einstig in das Thema *Oracle-Datenbanken in Docker-Container*. Dazu werden folgende Kenntnisse der Teilnehmer werden empfohlen:

* Oracle Datenbank Grundlagen wie Installation, Konfiguration und basis Datenbank Administration
* Docker Grundlagen (siehe auch [Get Started, Part 1: Orientation and setup](https://docs.docker.com/get-started/))
* Praktische Erfahrung im Umgang mit Shell Skripten, SSH und der Kommando Zeile.

## Compute Node in der Oracle Cloud

Die Compute Node in der Oracle Cloud werden speziell für diesen Workshop vorbereitet und stehen jedem Teilnehmer für die Dauer des DOAG Schulungstages für praktische Arbeiten zur Verfügung. Jede Compute Node ist wie folgt konfiguriert:

* *Host Name :* ol7dockerXX.trivadislabs.com (siehe Host Liste auf [DOAG2019 O-DB-DOCKER](https://url.oradba.ch/DOAG2019_O-DB-DOCKER))
* *Interne IP Adresse :* 10.0.0.2
* *Externe IP Adresse :* siehe Host Liste auf [DOAG2019 O-DB-DOCKER](https://url.oradba.ch/DOAG2019_O-DB-DOCKER)
* *VM Shape :* VM.Standard2.2
    * *CPU:* 2.0 GHz Intel® Xeon® Platinum 8167M (2 Cores)
    * *Memory:* 30GB
    * *Disk:* ca. 256GB
* *Software:* 
  * Oracle Enterprise Linux 7.7
  * Docker Engine / Community Edition
  * Vorbereitete Docker Images
  * Diverse Oracle Binaries und Git Client

Der Zugriff auf die Compute Nodes erfolgt ausschliesslich mit SSH und Private Keys. Die Workshop Teilnehmer müssen sicherstellen, dass sie folgende Anforderungen erfüllen:

* *SSH Client* für den remote Zugriff. z.B. Putty, MobaXterm oder ähnliches.
* *SCP Client* um Dateien remote zu kopieren. z.B. WinSCP, Putty oder ähnliches.
* *Text Editor* für das Anpassen / Entwicklen der Dockerfiles, Skripts etc. Z.B. MS Visual Studio Code, UltraEdit, Notepad++ oder ähnliches
* Zudem muss sichergestellt werden, dass ein Zugriff auf eine Public IP Address respektive Hostnamen via SSH Key möglich ist.

Optional werden zudem folgend Punkte empfohlen:

* GitHub Account für den Zugriff und Download des Source Codes. Der einfache Download geht grundsätzlich ohne Account.

## Lokale Vagrant VM

Analog zu den Compute Nodes können sämtliche Übungen direkt in einer Lokalen VM durchgeführt werden. Entsprechende Vagrant Skripte für den Aufbau einer VM stehen im Git Repository [oehrlis/o-db-docker](https://github.com/oehrlis/o-db-docker) zur Verfügung. Für den Aufbau dieser VM mit Vagrant müssen folgende Anforderungen erfüllt werden:

* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](
https://www.vagrantup.com)
* Lokale Kopie des Git Repository [oehrlis/o-db-docker](https://github.com/oehrlis/o-db-docker)
* Oracle Binaries für Oracle 19c sowie aktuelle RU
* Ausreichend Festplattenplatz für die VM und die Docker Images ca. 50GB
* Allenfalls weitere Tools, um mit den Container zu arbeiten. z.B. Text Editor etc.

Der Aufbau einer lokalen VM ist nicht bestandteil des Workshops. Teilnehmer, welche wünschen mit einer VM zu Arbeiten, müssend diese im Voraus konfigurieren.

## Lokale Docker Umgebung

Als dritte Variante lassen sich die Übungen auch in einer lokalen Docker Umgebung umsetzen. Dies bietet sich insbesondere für Linux oder MacOS Notebooks an. Um den Workshop lokal durchzuführen, müssen folgende Anforderungen erfüllt werden:

* Installation der Docker Community Edition. Siehe auch [About Docker - Community](https://docs.docker.com/install/)
* Lokale Kopie des Git Repository [oehrlis/o-db-docker](https://github.com/oehrlis/o-db-docker)
und [oracle/docker-images)](https://github.com/oracle/docker-images)
* Oracle Binaries für Oracle 19c sowie aktuelle RU
* Ausreichend Festplattenplatz für die Docker Images ca. 50GB
* Allenfalls weitere Tools, um mit den Container zu arbeiten. z.B. Text Editor, Git Client etc.

Der Aufbau einer lokalen Docker Umgebung ist nicht bestandteil des Workshops. Teilnehmer, welche wünschen mit einer lokalen Docker Installation zu Arbeiten, müssend diese im Voraus konfigurieren.
