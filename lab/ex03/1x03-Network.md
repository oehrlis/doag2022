<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD041 -->
## VCN-Basics

## Ziel: Erstellen eines Netzwerks zur weiteren Verwendung

- Networking -> Virtual Cloud Networks
- Bitte beachten Sie, dass  Sie sich in ihrem zugewiesenen Compartment befinden
- Region ist eu-frankfurt-1
- Wir verwenden nicht den VCN Wizard.

Das virtuelle Netzwerk wird Schritt für Schritt erstellt:

- 1 VCN
- 1 Internet Gateway
- 1 NAT Gateway
- 1 Routing Table für Public Subnet
- 1 Routing Table für Private Subnet
- 1 Security List für Public Subnet
- 1 Security List für Private Subnet
- 1 Public Subnet
- 2 Private Subnet

## Hinweis

Die hier aufgeführten Schritte werden im Compartment Student01 ausgeführt und heissen auch dementsprechend.
Ersetzen Sie die Nummer mit der Ihnen zugewiesenen Nummer 01-0n.

### VCN

_Create VCN_ auswählen, wir verwenden nicht den VCN Wizard.

![OCI VCN Overview](1x03-01-vcn-vcn-01.png)

| Item                         | Value               | Bemerkungen  |
|:-----------------------------|:--------------------|:-------------|
| Name                         | vcn-doag-student-01 | keine        |
| Compartment                  | <Compartment>       | keine        |
| IPv4 CIDR Blocks             | 10.0.0.0/16         | keine        |

Table: VCN Konfigurationsvorgaben

![OCI VCN Create Dialog](1x03-01-vcn-vcn-02.png)

Die restlichen Einstellungen belassen, mit Klick auf _Create VCN_ wird die Resource erstellt und anschliessend angezeigt.

### Internet Gateway

Im erstellten VCN die Resource _Internet Gateways_ auswählen, _Create Internet Gateway_.

![OCI Internet Gateways Overview](1x03-01-vcn-igw-01.png)

| Item                         | Value               | Bemerkungen  |
|:-----------------------------|:--------------------|:-------------|
| Name                         | igw-doag-student-01 | keine        |

Table: Internet Gateways Konfigurationsvorgaben

![OCI Internet Gateways Create Dialog](1x03-01-vcn-igw-02.png)

Die restlichen Einstellungen belassen, mit Klick auf _Create Internet Gateway_ wird die Resource erstellt und anschliessend angezeigt.

### NAT Gateway

Im erstellten VCN die Resource _NAT Gateways_ auswählen, _Create NAT Gateway_.

![OCI NAT Gateway Overview](1x03-01-vcn-ngw-01.png)

| Item                         | Value               | Bemerkungen  |
|:-----------------------------|:--------------------|:-------------|
| Name                         | ngw-doag-student-01 | keine        |

Table: NAT Gateways Konfigurationsvorgaben

![OCI NAT Gateways Create Dialog](1x03-01-vcn-ngw-02.png)

Die restlichen Einstellungen belassen, mit Klick auf _Create NAT Gateway_ wird die Resource erstellt und anschliessend angezeigt.

### Routing Table für Public Subnet

Die Route beinhaltet das Internet Gateway. Im erstellten VCN die Resource _Route Tables_ auswählen, _Create Route Table_.

![OCI Routing Table Overview](1x03-01-vcn-route_table-01.png)

| Item                         | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Name                         | rt-doag-student-01-public  | keine        |

Table: Public Routing Table Konfigurationsvorgaben

Fügen Sie folgende Route hinzu:

| Target Type                  | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Internet Gateway             | rt-doag-student-01-public  | keine        |
| Destination CIDR Block       | 0.0.0.0/0                  | keine        |
| Target Internet Gateway      | igw-doag-student-01        | keine        |

Table: Public Routing Table Konfigurationsvorgaben

![OCI Routing Table Overview](1x03-01-vcn-route_table-02.png)

Die restlichen Einstellungen belassen, mit Klick auf _Create_ wird die Resource erstellt und anschliessend angezeigt.

### Routing Table für Private Subnet

Die Route beinhaltet das NAT Gateway. Im erstellten VCN die Resource _Route Tables_ auswählen, _Create Route Table_.

![OCI Routing Table Overview](1x03-01-vcn-route_table-01.png)

| Item                         | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Name                         | rt-doag-student-01-private | keine        |

Table: Private Routing Table Konfigurationsvorgaben

Fügen Sie folgende Route hinzu:

| Target Type                  | Value                   | Bemerkungen  |
|:-----------------------------|:------------------------|:-------------|
| Internet Gateway             | rt-doag-student-public  | keine        |
| Destination CIDR Block       | 0.0.0.0/0               | keine        |
| Target NAT Gateway           | ngw-doag-student-01     | keine        |

Table: Private Routing Table Konfigurationsvorgaben

![OCI Routing Table Create Dialog](1x03-01-vcn-route_table-03.png)

Die restlichen Einstellungen belassen, mit Klick auf _Create_ wird die Resource erstellt und anschliessend angezeigt.

### Security List für Public Subnet

Die Security List lässt Zugriff auf das Public Subnet von den Ports 22 (SSH) und 80 (http) zu.
Im erstellten VCN die Resource _Security Lists_ auswählen, _Create Security List_.

![OCI Public Security List Overview](1x03-01-vcn-security_list_public-01.png)

| Item                         | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Name                         | sl-doag-student-01-public  | keine        |

Table: Public Subnet Konfigurationsvorgaben

Fügen Sie folgende Ingress-Regeln hinzu:

| Destination                  | Source Type & CIDR   | Port    | Protocol    |
|:-----------------------------|:---------------------|:--------|:------------|
| Ingress                      | CIDR 0.0.0.0/0       | 22      | TCP         |
| Ingress                      | CIDR 0.0.0.0/0       | 80      | TCP         |

Table: Ingress-Regeln Public Subnet

Fügen Sie folgende Egress-Regeln hinzu:

| Destination                  | Source Type & CIDR   | Port    | Protocol    |
|:-----------------------------|:---------------------|:--------|:------------|
| Egress                       | CIDR 0.0.0.0/0       | All     | All         |

Table: Egress-Regeln Public Subnet

Die restlichen Einstellungen belassen, mit Klick auf _Create Security List_ wird die Resource erstellt und anschliessend angezeigt.

![OCI Ingress-Regeln Public Subnet](1x03-01-vcn-security_list_public-02.png)
![OCI Egress-Regeln Public Subnet](1x03-01-vcn-security_list_public-03.png)

### Security List für Private Subnet

Die Security List lässt Zugriff auf das Private Subnet von den Ports 22 (SSH) und 1521 (sqlnet) aus dem Public Subnet zu.
Im erstellten VCN die Resource _Security Lists_ auswählen, _Create Security List_.

![OCI Private Security List Overview](1x03-01-vcn-security_list_private-01.png)

| Item                         | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Name                         | sl-doag-student-01-private | keine        |

Table: Private Subnet Konfigurationsvorgaben

Fügen Sie folgende Ingress-Regeln hinzu:

| Destination                  | Source Type & CIDR   | Port    | Protocol    |
|:-----------------------------|:---------------------|:--------|:------------|
| Ingress                      | CIDR 10.0.1.0/24     | 22      | TCP         |
| Ingress                      | CIDR 10.0.1.0/24     | 1521    | TCP         |

Table: Ingress-Regeln

Fügen Sie folgende Egress-Regeln hinzu:

| Destination                  | Source Type & CIDR   | Port    | Protocol    |
|:-----------------------------|:---------------------|:--------|:------------|
| Egress                       | CIDR 0.0.0.0/0       | All     | All         |

Table: Egress-Regeln

Die restlichen Einstellungen belassen, mit Klick auf _Create Security List_ wird die Resource erstellt und anschliessend angezeigt.

![OCI Ingress-Regeln Private Subnet](1x03-01-vcn-security_list_private-02.png)
![OCI Egress-Regeln Private Subnet](1x03-01-vcn-security_list_private-03.png)

### Public Subnet

Im erstellten VCN die Resource _Subnets_ auswählen, _Create Subnet_.

![OCI Subnet Overview](1x03-01-vcn-subnet_public-01.png)

| Item                         | Value                     | Bemerkungen  |
|:-----------------------------|:--------------------------|:-------------|
| Name                         | sn-doag-student-01-public | keine        |
| Subnet Type                  | Regional                  | keine        |
| IPv4 CIDR Block              | 10.0.1.0/24               | keine        |
| Subnet Access                | Public                    | keine        |
| DNS Label                    | snstudentpub01            | keine        |
| Route Table                  | rt-doag-student-public    | keine        |
| DHCP Options                 | Default DHCP Options      | keine        |
| Security Lists               | sl-doag-student-01-public | keine        |

Table: Public Subnet Konfiguration

![OCI Create Public Subnet Dialog part I](1x03-01-vcn-subnet_public-02.png)
![OCI Create Public Subnet Dialog part II](1x03-01-vcn-subnet_public-03.png)

Die restlichen Einstellungen belassen, mit Klick auf _Create Subnet_ wird die Resource erstellt und anschliessend angezeigt.

### Private Subnets

Im erstellten VCN die Resource _Subnets_ auswählen, _Create Subnet_.

| Item                         | Value                          | Bemerkungen  |
|:-----------------------------|:-------------------------------|:-------------|
| Name                         | sn-doag-student-01-private-app | keine        |
| Subnet Type                  | Regional                       | keine        |
| IPv4 CIDR Block              | 10.0.2.0/24                    | keine        |
| Subnet Access                | Private                        | keine        |
| DNS Label                    | snstudentprv01                 | keine        |
| Route Table                  | rt-doag-student-private        | keine        |
| DHCP Options                 | Default DHCP Options           | keine        |
| Security Lists               | sl-doag-studet-01-private      | keine        |

Table: Private Subnet Konfiguration I

![OCI Create private Subnet Dialog part I](1x03-01-vcn-subnet_private-01.png)
![OCI Create private Subnet Dialog part II](1x03-01-vcn-subnet_private-02.png)
![OCI Create private Subnet Dialog part III](1x03-01-vcn-subnet_private-03.png)

Die restlichen Einstellungen belassen, mit Klick auf _Create Subnet_ wird die Resource erstellt und anschliessend angezeigt.

Wiederholen Sie die Erstellen für das zweite private Subnet.

| Item                         | Value                          | Bemerkungen  |
|:-----------------------------|:-------------------------------|:-------------|
| Name                         | sn-doag-student-01-private-db  | keine        |
| Subnet Type                  | Regional                       | keine        |
| IPv4 CIDR Block              | 10.0.3.0/24                    | keine        |
| Subnet Access                | Private                        | keine        |
| DNS Label                    | snstudentprv02                 | keine        |
| Route Table                  | rt-doag-student-private        | keine        |
| DHCP Options                 | Default DHCP Options           | keine        |
| Security Lists               | sl-doag-student-01-private     | keine        |

Table: Private Subnet Konfiguration II

Übersicht der erstellten Subnets:

![OCI Private Subnet List](1x03-01-vcn-subnet_private_list.png)
