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
  value       = data.oci_core_images.oracle_images.images.*.display_name
}

output "lab_compartment" {
  description = "OCID of Student LAB Compartment"
  value       = data.oci_identity_compartments.lab_compartment.compartments.*.compartment_id
}

# --- EOF -------------------------------------------------------------------
