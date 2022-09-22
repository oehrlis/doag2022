# ---------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: locals.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Local variables for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

locals {
  label_prefix         = "doag"
  lab_compartment_ocid = data.oci_identity_compartments.lab_compartments.compartments.0.id
  availability_domain  = data.oci_identity_availability_domains.ad_list.availability_domains[var.ad_index - 1].name
  #ssh_authorized_keys   = join("", [file(var.ssh_public_key_path), tls_private_key.bastion_ssh_key.public_key_openssh])
  ssh_authorized_keys   = file(var.ssh_public_key_path)
  resource_name         = lower(join("-", [local.label_prefix, trimsuffix(data.oci_identity_compartment.lab_compartment.name, var.lab_id), var.lab_id]))
  resource_shortname    = lower(replace(local.resource_name, "-", ""))
  public_dns_label      = lower(join("", ["sn", trimsuffix(data.oci_identity_compartment.lab_compartment.name, var.lab_id), "pub", var.lab_id]))
  private_app_dns_label = lower(join("", ["sn", trimsuffix(data.oci_identity_compartment.lab_compartment.name, var.lab_id), "pvap", var.lab_id]))
  private_db_dns_label  = lower(join("", ["sn", trimsuffix(data.oci_identity_compartment.lab_compartment.name, var.lab_id), "pvdb", var.lab_id]))
}
# --- EOF -------------------------------------------------------------------
