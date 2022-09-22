---
title: "OCI Command-Line Interface"
permalink: /lab/oci-cli/
excerpt: "Das OCI-CLI konfigurieren"
---
<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD025 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD041 -->
## OCI Command-Line Interface

### Übungsziele {.unlisted .unnumbered}

Ziel ist das Arbeiten mit dem OCI-CLI in der Cloud Shell.

### Aufgaben {.unlisted .unnumbered}

- Öffnen Sie die Cloud Shell
- Erstellen Sie ein VCN mit dem OCI-CLI

### Cloud Shell öffnen

Das OCI-CLI ist in derf Cloud-Shell bereits vorkonfiguriert und übernimmt die IAM-Berechtigung vom
eingeloggten User.

Funktion vom CLI testen und den Namespace anzeigen.

![Namespace anzeigen](../../images/1x01-07-oci-cli-01.png){:width="900px"}

Sie können zu den Schlüsselwörtern die Hilfe anzeigen lassen:

```bash
oci --help
oci network -h
oci bv volume create -h
```

### VCN mit dem OCI-CLI anlegen - VCN only

In vielen Kommandi wird die OCID vom eigenen Compartment benutzt. Mit einer Abfrage auf das IAM kann
man die OCID herausfinden.

Beispiel für Student01:

```bash
$ oci iam compartment list --query "data [?name == 'Student01'].{OCID:id}" --compartment-id-in-subtree true
[
  {
    "OCID": "ocid1.compartment.oc1..aaaaaaaagbfj3upniunsayhhtnnp46up3hfrhy45zjfcsfg2hbcs7haxs"
  }
]
```

Die OCID als Umgebungsvariable exportieren:

```bash
export C=ocid1.compartment.oc1..aaaaaaaagbfj3upniunsayhhtnnp46up3hfrhy45zjfcsfg2hbcs7haxs
```

VCN anlegen mit dem Variable für das Compartment.

```bash
$ oci network vcn create --cidr-block 192.168.0.0/16 --compartment-id $C --display-name doag-demo-vcn --dns-label doagdemovcn
{
  "data": {
    "byoipv6-cidr-blocks": null,
    "cidr-block": "192.168.0.0/16",
    "cidr-blocks": [
      "192.168.0.0/16"
    ],
    "compartment-id": "ocid1.compartment.oc1..aaaaaaaagbfj3upniunsayhhtnnp46up3hfrhy45zjfcsfg2hbcs7haxs5ga",
    "default-dhcp-options-id": "ocid1.dhcpoptions.oc1.eu-frankfurt-1.aaaaaaaaiplyj6vefy3fgcggbncwfxbhrwtzf2okdfryuhunm7qymkcnr2da",
    "default-route-table-id": "ocid1.routetable.oc1.eu-frankfurt-1.aaaaaaaabbxt2e6lkjf5bzzydyxskmuivj4mwizzaphijuyhwssd7vzisiwa",
    "default-security-list-id": "ocid1.securitylist.oc1.eu-frankfurt-1.aaaaaaaaxcrk6va537pdfuwvdymuxxhmedjoareuia5fdtfadzqxhect6cda",
    "defined-tags": {
      "Oracle-Tags": {
        "CreatedBy": "oracleidentitycloudservice/doagoci01",
        "CreatedOn": "2022-09-22T12:24:15.765Z"
      },
      "Owner": {
        "Creator": "oracleidentitycloudservice/doagoci01"
      }
    },
    "display-name": "doag-demo-vcn",
    "dns-label": "doagdemovcn",
    "freeform-tags": {},
    "id": "ocid1.vcn.oc1.eu-frankfurt-1.amaaaaaafa2l3syaevtkgqsyiyag24wjsrqydadmfogzzmpnnipdhyzjir6a",
    "ipv6-cidr-blocks": null,
    "ipv6-private-cidr-blocks": null,
    "lifecycle-state": "AVAILABLE",
    "time-created": "2022-09-22T12:24:15.910000+00:00",
    "vcn-domain-name": "doagdemovcn.oraclevcn.com"
  },
  "etag": "596e9356"
}
```

Verifizieren Sie in der OCI Konsole ob das angelegt wurde.

### OCI-CLI Shell Script vom Github Repository zum Anlegen eines VCN

- legt VCN an
- benötigt als Input das Compartment als Variable C
- Credits an BrokeDBA - <http://www.brokedba.com/>

```bash
# Prüfen ob die Compartment-Variable noch gesetzt ist und setzen vom CIDR-Block.
echo $C

# Download vom Shell Script
curl https://objectstorage.eu-zurich-1.oraclecloud.com/p/peQ_DqJOgHPj0WLzfx0Hvu04plDgrLPUVRlIP61ocJf5d45EWjWRPU3LxZEuC-w4/n/zrrioivzmxcn/b/oci-cli/o/create_vcn.sh -o create_vcn.sh
chmod +x create_vcn.sh

# Script ausführen
./create_vcn.sh
```

Verifizieren Sie in der OCI Konsole ob das angelegt wurde.
