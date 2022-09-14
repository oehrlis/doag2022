<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD013 -->

# VCN-Basics

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

<img src="./../../images/0x03-01-vcn-vcn-01.png" width="900">

| Item                         | Value               | Bemerkungen  |
|:-----------------------------|:--------------------|:-------------|
| Name                         | vcn-doag-student-01 | keine        |
| Compartment                  | <Compartment>       | keine        |
| IPv4 CIDR Blocks             | 10.0.0.0/16         | keine        |

<img src="./../../images/0x03-01-vcn-vcn-02.png" width="900">

Die restlichen Einstellungen belassen, mit Klick auf _Create VCN_ wird die Resource erstellt und anschliessend angezeigt.

### Internet Gateway

Im erstellten VCN die Resource _Internet Gateways_ auswählen, _Create Internet Gateway_.

<img src="./../../images/0x03-01-vcn-igw-01.png" width="900">

| Item                         | Value               | Bemerkungen  |
|:-----------------------------|:--------------------|:-------------|
| Name                         | igw-doag-student-01 | keine        |

<img src="./../../images/0x03-01-vcn-igw-02.png" width="900">

Die restlichen Einstellungen belassen, mit Klick auf _Create Internet Gateway_ wird die Resource erstellt und anschliessend angezeigt.

### NAT Gateway

Im erstellten VCN die Resource _NAT Gateways_ auswählen, _Create NAT Gateway_.

<img src="./../../images/0x03-01-vcn-ngw-01.png" width="900">

| Item                         | Value               | Bemerkungen  |
|:-----------------------------|:--------------------|:-------------|
| Name                         | ngw-doag-student-01 | keine        |

<img src="./../../images/0x03-01-vcn-igw-02.png" width="900">

Die restlichen Einstellungen belassen, mit Klick auf _Create NAT Gateway_ wird die Resource erstellt und anschliessend angezeigt.

### Routing Table für Public Subnet

Die Route beinhaltet das Internet Gateway. Im erstellten VCN die Resource _Route Tables_ auswählen, _Create Route Table_.

<img src="./../../images/0x03-01-vcn-route_table-01.png" width="900">

| Item                         | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Name                         | rt-doag-student-01-public  | keine        |

Fügen Sie folgende Route hinzu:

| Target Type                  | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Internet Gateway             | rt-doag-student-01-public  | keine        |
| Destination CIDR Block       | 0.0.0.0/0                  | keine        |
| Target Internet Gateway      | igw-doag-student-01        | keine        |

<img src="./../../images/0x03-01-vcn-route_table-02.png" width="900">

Die restlichen Einstellungen belassen, mit Klick auf _Create_ wird die Resource erstellt und anschliessend angezeigt.

### Routing Table für Private Subnet

Die Route beinhaltet das NAT Gateway. Im erstellten VCN die Resource _Route Tables_ auswählen, _Create Route Table_.

<img src="./../../images/0x03-01-vcn-route_table-01.png" width="900">

| Item                         | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Name                         | rt-doag-student-01-private | keine        |

Fügen Sie folgende Route hinzu:

| Target Type                  | Value                   | Bemerkungen  |
|:-----------------------------|:------------------------|:-------------|
| Internet Gateway             | rt-doag-student-public  | keine        |
| Destination CIDR Block       | 0.0.0.0/0               | keine        |
| Target NAT Gateway           | ngw-doag-student-01     | keine        |

<img src="./../../images/0x03-01-vcn-route_table-03.png" width="900">

Die restlichen Einstellungen belassen, mit Klick auf _Create_ wird die Resource erstellt und anschliessend angezeigt.

### Security List für Public Subnet

Die Security List lässt Zugriff auf das Public Subnet von den Ports 22 (SSH) und 80 (http) zu.
Im erstellten VCN die Resource _Security Lists_ auswählen, _Create Security List_.

<img src="./../../images/0x03-01-vcn-security_list_public-01.png" width="900">

| Item                         | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Name                         | sl-doag-student-01-public  | keine        |

Fügen Sie folgende Ingress-Regeln hinzu:

| Destination                  | Source Type & CIDR   | Port    | Protocol    |
|:-----------------------------|:---------------------|:--------|:------------|
| Ingress                      | CIDR 0.0.0.0/0       | 22      | TCP         |
| Ingress                      | CIDR 0.0.0.0/0       | 80      | TCP         |

Fügen Sie folgende Egress-Regeln hinzu:

| Destination                  | Source Type & CIDR   | Port    | Protocol    |
|:-----------------------------|:---------------------|:--------|:------------|
| Egress                       | CIDR 0.0.0.0/0       | All     | All         |

Die restlichen Einstellungen belassen, mit Klick auf _Create Security List_ wird die Resource erstellt und anschliessend angezeigt.

<img src="./../../images/0x03-01-vcn-security_list_public-02.png" width="900">

<img src="./../../images/0x03-01-vcn-security_list_public-03.png" width="900">

### Security List für Private Subnet

Die Security List lässt Zugriff auf das Private Subnet von den Ports 22 (SSH) und 1521 (sqlnet)aus dem Public Subnet zu.
Im erstellten VCN die Resource _Security Lists_ auswählen, _Create Security List_.

<img src="./../../images/0x03-01-vcn-security_list_private-01.png" width="900">

| Item                         | Value                      | Bemerkungen  |
|:-----------------------------|:---------------------------|:-------------|
| Name                         | sl-doag-student-01-private | keine        |

Fügen Sie folgende Ingress-Regeln hinzu:

| Destination                  | Source Type & CIDR   | Port    | Protocol    |
|:-----------------------------|:---------------------|:--------|:------------|
| Ingress                      | CIDR 10.0.1.0/24     | 22      | TCP         |
| Ingress                      | CIDR 10.0.1.0/24     | 1521    | TCP         |
| Ingress                      | CIDR 10.0.2.0/24     | 22      | TCP         |
| Ingress                      | CIDR 10.0.2.0/24     | 1521    | TCP         |

Fügen Sie folgende Egress-Regeln hinzu:

| Destination                  | Source Type & CIDR   | Port    | Protocol    |
|:-----------------------------|:---------------------|:--------|:------------|
| Egress                       | CIDR 0.0.0.0/0       | All     | All         |

Die restlichen Einstellungen belassen, mit Klick auf _Create Security List_ wird die Resource erstellt und anschliessend angezeigt.

<img src="./../../images/0x03-01-vcn-security_list_private-02.png" width="900">

<img src="./../../images/0x03-01-vcn-security_list_private-03.png" width="900">

### Public Subnet

Im erstellten VCN die Resource _Subnets_ auswählen, _Create Subnet_.

<img src="./../../images/0x03-01-vcn-subnet_public-01.png" width="900">

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

<img src="./../../images/0x03-01-vcn-subnet_public-02.png" width="900">

<img src="./../../images/0x03-01-vcn-subnet_public-03.png" width="900">

<img src="./../../images/0x03-01-vcn-subnet_public-04.png" width="900">

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

<img src="./../../images/0x03-01-vcn-subnet_private-01.png" width="900">

<img src="./../../images/0x03-01-vcn-subnet_private-02.png" width="900">

<img src="./../../images/0x03-01-vcn-subnet_private-03.png" width="900">

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

Übersicht der erstellten Subnets:

<img src="./../../images/0x03-01-vcn-subnet_private_list.png" width="900">
