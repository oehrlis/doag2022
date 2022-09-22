# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: vcn_nat.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2022.09.22
# Revision...: 
# Purpose....: VCN NAT gateway resource.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

#NAT # create the nat gateway resource -------------------------------------------
#NAT resource "oci_core_nat_gateway" "ngw" {
#NAT   compartment_id = data.oci_identity_compartment.lab_compartment.id
#NAT   display_name   = "ngw-${local.resource_name}"
#NAT   vcn_id         = oci_core_vcn.vcn.id
#NAT   block_traffic  = false
#NAT }
# --- EOF ----------------------------------------------------------------------
