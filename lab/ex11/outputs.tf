# ---------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: outputs.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Outputs defined for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

output "oracle_images" {
  description = "Latest Oracle Linux Image"
  value       = data.oci_core_images.oracle_images.images.0.display_name
}

output "lab_compartment" {
  description = "OCID of Student LAB Compartment"
  value       = data.oci_identity_compartment.lab_compartment.id
}

output "lab_vcn" {
  description = "OCID of the LAB virtual cloud network"
  value       = oci_core_vcn.vcn.id
}

output "compute_public_ip" {
  description = "The public IP address of the compute instance."
  value       = oci_core_instance.compute_public.public_ip
}

output "compute_private_ssh_key" {
  description = "The private SSH Key of the compute instance."
  value       = tls_private_key.bastion_ssh_key.private_key_pem
  sensitive   = true
}

output "compute_ssh_access" {
  description = "SSH access string for compute instance."
  value       = format("ssh -A -i %s opc@%s", trimsuffix(var.ssh_public_key_path, ".pub"), oci_core_instance.compute_public.public_ip)
}

### Important Security Notice ###
# The private key generated by this resource will be stored unencrypted in your Terraform state file. 
# Use of this resource for production deployments is not recommended. 
# Instead, generate a private key file outside of Terraform and distribute it securely to the system where Terraform will be run.
output "generated_private_key_pem" {
  value     = tls_private_key.bastion_ssh_key.private_key_pem
  sensitive = true
}
# --- EOF -------------------------------------------------------------------
