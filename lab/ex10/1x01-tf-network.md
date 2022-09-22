---
title: "Netzwerk"
permalink: /lab/tf-network/
excerpt: "VCN Konfiguration mit Terraform"
---
<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD025 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD041 -->
## Terraform Netzwerk Konfiguration

### Übungsziele {.unlisted .unnumbered}

Erarbeiten der Terraform Konfiguration für ein Netzwerk zur weiteren Verwendung

- Die Ressourcen werden ausschliessliche mit Terraform erstellt. Prüfen sie jeweils
  die Resssouren in ihrem Compartment via OCI Konsole z.B.
  Konfiguration Networking -> Virtual Cloud Networks
- Bei der Architektur halten wir uns an die gleiche Architektur wie bei den OCI Übungen
- Bitte beachten Sie, dass Sie sich in ihrem zugewiesenen Compartment befinden
- Region ist *eu-frankfurt-1*

### Aufgaben {.unlisted .unnumbered}

Das virtuelle Netzwerk wird Schritt für Schritt erstellt:

- 1 VCN
- 1 Internet Gateway
- 1 NAT Gateway
- 1 Routing Table für Public Subnet und Private Subnet
- 1 Security List für Public Subnet und Private Subnet
- 1 Public Subnet und 2 Private Subnet
- Löschen der Netzwerk Ressourcen

::: note
**Hinweise** Die hier aufgeführten Schritte werden im Compartment *Student01*
ausgeführt und heissen auch dementsprechend. Ersetzen Sie die Nummer mit der
Ihnen zugewiesenen Nummer 01-0n.
:::

### VCN mit Terraform erstellen

Das VCN soll folgend Informationen endhalten. Kontrollieren Sie ggf. die Datei
*vcn.tf*

| Item                         | Value               | Bemerkungen  |
|:-----------------------------|:--------------------|:-------------|
| Name                         | vcn-doag-student-01 | keine        |
| IPv4 CIDR Blocks             | 10.0.0.0/16         | keine        |

Table: VCN Terraform Konfigurationsvorgaben

Da wir in diesem Verzeichnis Terraform noch nicht initialisiert haben, müssen
wir als erstes *terraform init* ausführen.

```bash
terraform init
```

*Terraform plan* erstellen und prüfen wass alles für Ressourcen erstellt werden
sollen.

```bash
terraform plan -out=network.tfplan
```

Den Plan mit *terraform apply* ausführen.

```bash
terraform apply network.tfplan
```

### Internet Gateway mit Terraform erstellen

Erstellen Sie mit folgenden Angaben zusätzlich im VCN die Ressource
*Internet Gateways*.

| Item | Value                     | Bemerkungen |
|:-----|:--------------------------|:------------|
| Name | igw-doag-student-01       | keine       |

Table: Internet Gateway Terraform Konfigurationsvorgaben

Die Datei *vcn_igw.tf* wurde bereits vorbereitet. Entfernen Sie den Kommentar Prefix
*#IGW* manual mit *vi* oder mit *sed*.

```bash
sed -i 's/#IGW//g' vcn_igw.tf
```

Erstellen Sie für die angepasste Konfiguration einen neuen Plan *Terraform plan*
erstellen und prüfen wass alles für Ressourcen erstellt werden sollen.

```bash
terraform plan -out=network.tfplan
```

Den Plan mit *terraform apply* ausführen.

```bash
terraform apply network.tfplan
```

### NAT Gateway mit Terraform erstellen

Erstellen Sie mit folgenden Angaben zusätzlich im VCN die Ressource
*NAT Gateways*.

| Item | Value                     | Bemerkungen |
|:-----|:--------------------------|:------------|
| Name | ngw-doag-student-01       | keine       |

Table: NAT Gateway Terraform Konfigurationsvorgaben

Die Datei *vcn_nat.tf* wurde bereits vorbereitet. Entfernen Sie den Kommentar Prefix
*#NAT* manual mit *vi* oder mit *sed*.

```bash
sed -i 's/#NAT//g' vcn_nat.tf
```

Erstellen Sie für die angepasste Konfiguration einen neuen Plan *Terraform plan*
erstellen und prüfen wass alles für Ressourcen erstellt werden sollen.

```bash
terraform plan -out=network.tfplan
```

Den Plan mit *terraform apply* ausführen.

```bash
terraform apply network.tfplan
```

### Routing Table für Public und Private Subnet

Für den zuvor erstellen Internet Gateway sowie NAT Gateway benötigen wir noch
entsprechende Routing Tables. Dazu legen wir folgende Ressourcen an.

| Item | Value                      | Bemerkungen                            |
|:-----|:---------------------------|:---------------------------------------|
| Name | rt-doag-student-01-public  | Routing Table für den Internet Gateway |
| Name | rt-doag-student-01-private | Routing Table für den NAT Gateway      |

Table: Routing Tables Terraform Konfigurationsvorgaben

Für die beiden Routing Tables fügen wir folgen Route hinzu:

| Target Type             | Value                     | Bemerkungen      |
|:------------------------|:--------------------------|:-----------------|
| Internet Gateway        | rt-doag-student-01-public | Internet Gateway |
| Destination CIDR Block  | 0.0.0.0/0                 | Internet Gateway |
| Target Internet Gateway | igw-doag-student-01       | Internet Gateway |
| NAT      Gateway        | rt-doag-student-public    | NAT Gateway      |
| Destination CIDR Block  | 0.0.0.0/0                 | NAT Gateway      |
| Target NAT Gateway      | ngw-doag-student-01       | NAT Gateway      |

Table: Routing Table Terraform detail Konfigurationsvorgaben

Die Datei *vcn_route.tf* wurde bereits vorbereitet. Entfernen Sie den Kommentar Prefix
*#RT* manual mit *vi* oder mit *sed*.

```bash
sed -i 's/#RT//g' vcn_route.tf
```

Erstellen Sie für die angepasste Konfiguration einen neuen Plan *Terraform plan*
erstellen und prüfen wass alles für Ressourcen erstellt werden sollen.

```bash
terraform plan -out=network.tfplan
```

Den Plan mit *terraform apply* ausführen.

```bash
terraform apply network.tfplan
```

### Security List für Public und Private Subnet

Mit den Security Listen schränken wir den Zugriff auf die verschiedenen Subnetze
ein. Dementsprechend erstellen wir für das private sowie public Subnet entsprechende
Security Listen.

| Item                         | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Name                         | sl-doag-student-01-public  | keine        |
| Name                         | sl-doag-student-01-private | keine        |

Table: Public und Private Security List Terraform Konfigurationsvorgaben

Dabei fügen wir jeweils folgende Ingress-Regeln hinzu:

| Destination | Source Type & CIDR | Port | Protocol | Bemerkungen |
|:------------|:-------------------|:-----|:---------|:------------|
| Ingress     | CIDR 0.0.0.0/0     | 22   | TCP      | Public      |
| Ingress     | CIDR 0.0.0.0/0     | 80   | TCP      | Public      |
| Ingress     | CIDR 10.0.0.0/16   | 22   | TCP      | Private     |
| Ingress     | CIDR 10.0.0.0/16   | 80   | TCP      | Private     |
| Ingress     | CIDR 10.0.0.0/16   | 1521 | TCP      | Private     |

Table: Ingress-Regeln Public respektive Private Subnet

Wir fügen zusätzlich jeweils folgende Egress-Regeln hinzu:

| Destination | Source Type & CIDR | Port | Protocol | Bemerkungen |
|:------------|:-------------------|:-----|:---------|:------------|
| Egress      | CIDR 0.0.0.0/0     | All  | All      | Public      |
| Egress      | CIDR 0.0.0.0/0     | All  | All      | Private     |

Table: Egress-Regeln Public respektive Private Subnet

Die Datei *vcn_security.tf* wurde bereits vorbereitet. Entfernen Sie den Kommentar Prefix
*#SEC* manual mit *vi* oder mit *sed*.

```bash
sed -i 's/#SEC//g' vcn_security.tf
```

Erstellen Sie für die angepasste Konfiguration einen neuen Plan *Terraform plan*
erstellen und prüfen wass alles für Ressourcen erstellt werden sollen.

```bash
terraform plan -out=network.tfplan
```

Den Plan mit *terraform apply* ausführen.

```bash
terraform apply network.tfplan
```

### Subnetze mit mit Terraform erstellen

Für unser Umgebung erstellen wir 3 Subnetze wobei eine Public ist und zwei Subnetze
Privat sind. Die folgende Tabelle beschreibt die Konfiguration der Verschiedenen Subnetze

| Item            | Value                          | Bemerkungen |
|:----------------|:-------------------------------|:------------|
| Name            | sn-doag-student-01-public      | Public      |
| Subnet Type     | Regional                       | Public      |
| IPv4 CIDR Block | 10.0.1.0/24                    | Public      |
| Subnet Access   | Public                         | Public      |
| DNS Label       | snstudentpub01                 | Public      |
| Route Table     | rt-doag-student-public         | Public      |
| DHCP Options    | Default DHCP Options           | Public      |
| Security Lists  | sl-doag-student-01-public      | Public      |
| Name            | sn-doag-student-01-private-app | Private APP |
| Subnet Type     | Regional                       | Private APP |
| IPv4 CIDR Block | 10.0.2.0/24                    | Private APP |
| Subnet Access   | Private                        | Private APP |
| DNS Label       | snstudentprivapp01             | Private APP |
| Route Table     | rt-doag-student-private        | Private APP |
| DHCP Options    | Default DHCP Options           | Private APP |
| Security Lists  | sl-doag-studet-01-private      | Private APP |
| Name            | sn-doag-student-01-private-db  | Private DB  |
| Subnet Type     | Regional                       | Private DB  |
| IPv4 CIDR Block | 10.0.3.0/24                    | Private DB  |
| Subnet Access   | Private                        | Private DB  |
| DNS Label       | snstudentprivdb02              | Private DB  |
| Route Table     | rt-doag-student-private        | Private DB  |
| DHCP Options    | Default DHCP Options           | Private DB  |
| Security Lists  | sl-doag-student-01-private     | Private DB  |

Table: Public und Private Subnet Konfiguration für Terraform

Die Datei *vcn_subnets.tf* wurde bereits vorbereitet. Entfernen Sie den Kommentar Prefix
*#SUB* manual mit *vi* oder mit *sed*.

```bash
sed -i 's/#SUB//g' vcn_subnets.tf
```

Erstellen Sie für die angepasste Konfiguration einen neuen Plan *Terraform plan*
erstellen und prüfen wass alles für Ressourcen erstellt werden sollen.

```bash
terraform plan -out=network.tfplan
```

Den Plan mit *terraform apply* ausführen.

```bash
terraform apply network.tfplan
```

### Löschen der Netzwerk Ressourcen

Kontrollieren Sie die verschiedenen Netzwerkressourcen in der OCI Konsole. Stimmen
die verschiedenen Ressourcen?

In der nächsten Übung werden wir das gesammte VCN noch einmal neu erstellen. Aus
diesem Grund, können die aktuellen Ressourcen mit *terraform destroy* gelöscht
werden. Bestätigen Sie den destroy Vorgang mit **yes**.

```bash
terraform destroy
```
