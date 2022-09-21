# ---------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: datasource.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Compute Instance for the terraform module tvdlab bastion.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# get the student compartment information based on the name
data "oci_identity_compartments" "lab_compartment" {
  compartment_id = var.base_compartment_ocid
  name           = var.lab_compartment_name
}
# get latest Oracle linux image
data "oci_core_images" "oracle_images" {
  compartment_id           = data.oci_identity_compartments.lab_compartment.compartments.0.compartment_id
  operating_system         = "Oracle Linux"
  operating_system_version = "7.9"
  shape                    = "VM.Standard.E4.Flex"
  sort_by                  = "TIMECREATED"
}

# --- EOF -------------------------------------------------------------------
