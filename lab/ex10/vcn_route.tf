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

#RT # create a default routing table -----------------------------------------------
#RT resource "oci_core_default_route_table" "default_route_table" {
#RT  display_name               = "rt-${local.resource_name}-public"
#RT  manage_default_resource_id = oci_core_vcn.vcn.default_route_table_id

#RT  route_rules {
#RT    destination       = "0.0.0.0/0"
#RT    network_entity_id = oci_core_internet_gateway.igw.id
#RT  }
#RT }

# create a default routing table --------------------------------------------
#RT resource "oci_core_route_table" "private_route_table" {
#RT   compartment_id = data.oci_identity_compartment.lab_compartment.id
#RT   display_name   = "rt-${local.resource_name}-private"
#RT   vcn_id         = oci_core_vcn.vcn.id

#RT  route_rules {
#RT    destination       = "0.0.0.0/0"
#RT    network_entity_id = oci_core_nat_gateway.ngw.id
#RT  }
#RT }
# --- EOF ----------------------------------------------------------------------
