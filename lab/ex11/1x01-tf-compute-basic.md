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
cd $HOME/doag2022/lab/ex10
. $HOME/tf_env
mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh
ssh-keygen -C "DOAG OCI Test" -f $HOME/.ssh/id_rsa_doag -b 2048
chmod 600 $HOME/.ssh/id_rsa_doag*
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

```bash
export COMPARTMENT_NAME="Student$(id -un|tail -c 3)"
export COMPARTMENT_OCID=$(oci iam compartment list \
    --compartment-id-in-subtree true --all \
    --raw-output --query "data [?name == '${COMPARTMENT_NAME}'].id|[0]")

oci os bucket create --compartment-id "$COMPARTMENT_OCID" --name "$COMPARTMENT_NAME"

touch terraform.tfstate
oci os object put --bucket-name "$COMPARTMENT_NAME" --file "terraform.tfstate"

oci os preauth-request create --bucket-name  "$COMPARTMENT_NAME" \
--name "terraform.tfstate" --access-type "ObjectReadWrite" \
--time-expires "2050-11-21T23:00:00+00:00" --object-name "terraform.tfstate"

/p/85_v_f7WQxnsTfHe53ab5KH6swneqzVXa1evVnfYRkxpgdvN7X1rdHOxH1PE87F-/n/frxplqvlwvmz/b/Student01/o/terraform.tfstate
```
