---
title: "Compute Instance"
permalink: /lab/tf-compute/
excerpt: "Erstellen einer Compute Instance mit Terraform"
---

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD025 -->
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD041 -->
## Compute Instance mit Terraform

### Übungsziele {.unlisted .unnumbered}

Erstellen einer Compute Instance mit Public Access.

### Aufgaben {.unlisted .unnumbered}

- SSH Key für den Zugriff via SSH erstellen
- Compute Instance erstellen
- SSH Verbindung auf die Compute Instance
- Umstellung des Backends von lokal auf remote

### SSH Key für die Compute Instance

Für den Zugriff auf eine Compute Instance via SSH wir ein entsprechender SSH Key
benötigt. Man kann dazu entweder einen eigenen SSK Key erstellen respektive einen
bestehenden nutzen oder diesen auch via Terraform mit der Ressource *tls_private_key*
generieren lassen. Die letze Methode ist zwar relative einfach und praktisch.
Man muss sich aber bewusst sein, dass von Terraform generierte Keys und Passwörter
jeweils auch der *terraform.tfstate* Datei stehen. Dies ist daher mit vorsicht zu
geniessen und sollte primär für einfach Test Systeme benutzt werden. Es ist
davon abzuraten, dass man bei business kritischen Systemen die SSH Keys im
State File hat.

In dieser Übung werden wir testweise sowohl lokal einen SSH Key mit *ssh-keygen*
sowie mit der Ressource *tls_private_key* einen Key erstellen.

Erstellen eines lokalen SSH Key Paares mit *ssh-keygen*. Der public Key werden
wir anschliessend in der Terraform verwenden.

```bash
cd $HOME/doag2022/lab/ex11
. $HOME/tf_env
mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh
ssh-keygen -C "DOAG OCI Test" -f $HOME/.ssh/id_rsa_doag -b 2048
chmod 600 $HOME/.ssh/id_rsa_doag*
cat >ssh_public_key_path
```

Für den generierten SSH mit Terraform nutzen wir die Ressource *tls_private_key*
Ein entsprechendes Beispiel ist in der Datei *bastion_ssh_key.tf*.

```bash
resource "tls_private_key" "bastion_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}
```

Damit uns Terraform den generierten Key auch mitteil, erstellen wir noch eine
Ausgabe in der Datei *outputs.tf*.

```bash
output "generated_private_key_pem" {
  value     = tls_private_key.bastion_ssh_key.private_key_pem
  sensitive = true
}
```

Falls noch nicht gemacht, müssen wir das Terraform Backend initialisieren.

```bash
cd $HOME/doag2022/lab/ex10
. $HOME/tf_env
terraform init
```

### Compute Instance mit Terraform erstellen

Mit *oci_core_instance* erstellen wir nur eine Compute Instance gemäss den
folgenden Angaben.

| Item                         | Value                                | Bemerkungen  |
|:-----------------------------|:-------------------------------------|:-------------|
| Name                         | tfci-doag-student-01-public          | keine        |
| Placement                    | AD3                                  | keine        |
| Shape                        | Reduzieren auf 4GB                   | keine        |
| Image                        | Oracle Linux 7.9                     | keine        |
| Virtual Cloud Network        | vcn-doag-student-01                  | keine        |
| Subnet                       | sn-doag-student-01-public (Regional) | keine        |
| Private IP Address           | 10.0.1.11                            | keine        |
| Hostname                     | tfci-doag-student-01-public          | keine        |
| Public IP address            | Assign a public IPv4 address         | keine        |
| SSH keys                     | Public SSH Key aus der Cloud Shell   | keine        |

Table: Compute Instance Terraform Konfiguration

Die entsprechende Terraform Konfiguration ist in der Datei *compute.tf* vorbereitet.
Wir versuchen dabei möglichst viele Information zu generieren oder abzufragen.

- Aktuellstes Oracle Linux Image mit *oci_core_images* abfragen
- Availability Domain AD3 abfragen
- Namen basierend auf Vorgabewerten, Compartment Names etc abzuleiten
- Generierte SSH Keys laden

Prüfen Sie als erstes die Datei *compute.tf*. Stimmen die oben aufgeführten Werte?

```bash
cat compute.tf
```

Passen Sie den Pfad des SSH Public Keys in *terraform.tfvars* an.

```bash
sed -i "s|SSH_KEY_PATH|$HOME/.ssh/id_rsa_doag.pub|" terraform.tfvars
```

*Terraform plan* erstellen und prüfen wass alles für Ressourcen erstellt werden
sollen.

```bash
terraform plan -out=compute.tfplan
```

Den Plan mit *terraform apply* ausführen.

```bash
terraform apply compute.tfplan
```

Sobald Terraform die Instanz angelegt hat, können Sie via OCI Konsole die Ressourcen
kontrollieren. Wurde alles wie gewünscht angelegt?

- VCN mit den verschiedene Subnetzen
- Compute Instance im Public Subnetz

Anschliessend verbinden Sie sich via SSH. Nutzen Sie dazu das SSH Kommando
respektive die Public IP Adresse, welche im Terraform Output angegeben wurde.

```bash
ssh -A -i /Users/stefan.oehrli/.ssh/id_rsa_doag opc@<PUBLICIP>
```

### Umstellung des Terraform Backends

Bis anhin wurde unser Terraform State jeweils in der lokalen Datei *terraform.tfstate*
bewirtschafte. Wenn wir diese verlieren oder sie beschädigt wird, kennt Terraform
den Zustand der OCI Umgebungen nicht mehr. Ein erneutes *plan* und *apply* würde
einfach alle Ressourcen neu anlegen. Daher erstellt Terraform jeweils eine
Sicherung der State Datei als *terraform.tfstate.backup*. Das abspeichern der
State Datei in einem Version Control sollte man übrigens nicht machen. Zum Einen
wird die State Datei immer wieder von Terraform angepasst. Zum Andern stehen da teilweise
Sensitive Informationen drin.

::: warning
**Warnung** Der Verlust eines Terraform State entspricht einem kleinen bis grösseren
Disaster. Ein aktuelles State File ist daher immens Wichtig. Terraform bietet
verschiedene Massnahmen um Verloren Zustände der Infrastruktur wieder herzustellen.
Alle sind aber mit Aufwand und entsprechendem Risiko verbunden. Das neu anlegen
einer Compute Resource ist nicht das primäre Problem sondern die Daten, welche
in der Datenbank oder auf dem Volume waren. Informationen zu
*Terraform State Restoration* finden Sie unter den folgenden Links:

- Terraform State Restoration Overview [Blog](https://support.hashicorp.com/hc/en-us/articles/4403065345555-Terraform-State-Restoration-Overview)
- Terraform CLI documentation [Recovering from State Disasters](https://www.terraform.io/cli/state/recover)
- Terraform CLI documentation [Command: state rm](https://www.terraform.io/cli/commands/state/rm)
- Terraform CLI documentation [Command: import](https://www.terraform.io/cli/commands/import)
:::

Damit die Terraform State Datei nicht einfach lokal herumliegt, kann man diese auch
in einem remote Backend (siehe auch [Backend Configuration](https://www.terraform.io/language/settings/backends/configuration))
abspeichern. Die bietet mehrer Vorteile. Zum einen ist die State Datei zentral und
sicher abgespeichert. Idealerweise natürlich mit einer entsprechende Sicherung.
Zudem ist man unabhängig. D.h. man kann vom System A eine Umgebung aufbauen und
auf dem System B den Terraform Code aus dem Version Control auschecken und
Anpassungen vornehmen. Mit dem remote Backend weis Terraform immer wie der Status
ist.

Grundsätzlich stehen verschiedene Backends zur Verfügung. Mit OCI kann man den
Terraform State respektive die State Datei relativ einfach in einem HTTP Backend
in einem OCI Object Store ablegen.

Erstellen wir als erstes mit dem OCI-CLI *oci* ein entsprechendes Bucket. Das
soll in unserem Fall gleich benannt werden wie das Compartment. Die benötigen
Informationen wie Compartment OCID suchen wir uns ebenfalls direkt mit *oci*
zusammen.

Erstellen Sie ein neues OCI Bucket mit dem Namen *StudentNN*. Wobei NN die Nummer
Ihrer Umgebung ist.

```bash
export COMPARTMENT_NAME="Student$(id -un|tail -c 3)"
export COMPARTMENT_OCID=$(oci iam compartment list \
    --compartment-id-in-subtree true --all \
    --raw-output --query "data [?name == '${COMPARTMENT_NAME}'].id|[0]")

oci os bucket create --compartment-id "$COMPARTMENT_OCID" --name "$COMPARTMENT_NAME"
```

Anschliessend laden wir unsere State Datei in das Bucket

```bash
touch terraform.tfstate
oci os object put --bucket-name "$COMPARTMENT_NAME" --file "terraform.tfstate"
```

Damit wir mit Terraform auf die State Datei zugreifen können, benötigen wir noch
eine Pre-Authenticated URL für die Provider Konfiguration.

```bash
oci os preauth-request create --bucket-name  "$COMPARTMENT_NAME" \
--name "terraform.tfstate" --access-type "ObjectReadWrite" \
--time-expires "2025-11-21T23:00:00+00:00" --object-name "terraform.tfstate"
```

OCI-CLI gibt die Pre-Authenticated URL mit dem Parameter ** an. Kopieren Sie diesen
Wert bitte wir benötigen diesen für die Anpassung der Provider Konfiguration in
der Datei *provider.tf*.

In der Terraform Provider Konfiguration *provider.tf* fügen wir nun das HTTP Backend
hinzu. Die entsprechenden Zeilen sind bereits in der Datei. Sie müssen lediglich die
Kommentarzeilen entfernen und *PRE_AUTH_URL* mit der zuvor kopierten Pre-Authenticated URL
ersetzten. Anbei ein Auszug aus *provider.tf*.

```bash
vi provider.tf

terraform {
  required_version = ">= 0.14.0"
    backend "http" {
      update_method = "PUT"
      address       = "https://objectstorage.eu-zurich-1.oraclecloud.com/PRE_AUTH_URL"
    }
```

Jetzt muss nur noch Terraform mitgeteilt werden, dass neu ein Remote Backen zu verwenden
ist. Dazu führen wir *terraform init* aus.

```bash
terraform init
```

Die Anpassung auf ein remote Backend ist übrigens eine Voraussetzung für die nächste
Übung. Wenn das nicht klappt, bekommen wir da ein *leichtes* Durcheinander. Die
lokale State Datei *terraform.tfstate* sowie *terraform.tfstate.backup* benötigen
wir nicht mehr.

::: note
**Hinweise** Als kleine Hausaufgabe, können Sie auch einmal versuchen bei einer
erstellten Terraform Umgebung die State Datei zu löschen und manuell wiederherzustellen.
Nutzen Sie dazu die oben aufgeführten Links.
:::
