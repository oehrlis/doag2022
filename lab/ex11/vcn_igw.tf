# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: vcn_igw.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2022.09.22
# Revision...: 
# Purpose....: VCN internet gateway resource.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

 # create the internet gateway resource -----------------------------------------
 resource "oci_core_internet_gateway" "igw" {
  compartment_id = data.oci_identity_compartment.lab_compartment.id
  display_name   = "igw-${local.resource_name}"
  vcn_id         = oci_core_vcn.vcn.id
  enabled        = "true"
 }
# --- EOF ----------------------------------------------------------------------
