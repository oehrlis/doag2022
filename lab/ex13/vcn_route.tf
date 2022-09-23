# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: vcn_route.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2022.09.22
# Revision...: 
# Purpose....: Public und Private routing table resources.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

 # create a default routing table -----------------------------------------------
 resource "oci_core_default_route_table" "default_route_table" {
  display_name               = "rt-${local.resource_name}-public"
  manage_default_resource_id = oci_core_vcn.vcn.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
 }

# create a default routing table --------------------------------------------
 resource "oci_core_route_table" "private_route_table" {
   compartment_id = data.oci_identity_compartment.lab_compartment.id
   display_name   = "rt-${local.resource_name}-private"
   vcn_id         = oci_core_vcn.vcn.id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.ngw.id
  }
 }
# --- EOF ----------------------------------------------------------------------
