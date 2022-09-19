# **Demo 01** Basic Terraform Setup

The following demo is a simple example for a Terraform OCI provider configuration.

## Preparations

Make sure you have defined the Terraform environment variables TF_VAR for basic
provider configuration. Usually done using a simple environment file `.env`.

```bash
. .env
env|grep TF_VAR
TF_VAR_fingerprint=<Fingerprint of OCI Key>
TF_VAR_user_ocid=<User OCID>
TF_VAR_tenancy_ocid=<Tenant OCID>
TF_VAR_private_key_path=<PATH to Key file>

cd demo01
```

## Files

The following files are available:

- [main.tf](./main.tf) Main configuration to build the environment. Currently empty
- [outputs.tf](./outputs.tf) Outputs defined for the terraform configuration.
- [provider.tf](./provider.tf) Provider specific configuration for this terraform
  configuration.
- [variables.tf](./variables.tf) Variable file for the terraform configuration.

## Demonstration Steps

- Initialize the Terraform environment. This will download the OCI provider and all
requested modules.

```bash
terraform init
```

- Validate the Terraform configuration e.g. verify whether a configuration is
syntactically valid and internally consistent.

```bash
terraform validate
```

- Run Terraform plan to generates a speculative execution plan and show what
  actions Terraform would take to apply the current configuration. It will ask for
  the region as for this variable no default values has been defined.

```bash
terraform plan -out demo01.tfplan
```

- Run Terraform apply to create or update infrastructure according to Terraform
  configuration files in the current directory.

```bash
terraform apply demo01.tfplan
```

- Finally destroy the terraform configuration respectively the associated resources.

```bash
terraform destroy
```
