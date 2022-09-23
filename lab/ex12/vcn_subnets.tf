# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: vcn_subnets.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2022.09.22
# Revision...: 
# Purpose....: VCN Subnet resources.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

 # create public subnet ---------------------------------------------------------
 resource "oci_core_subnet" "public_subnet" {
   compartment_id    = data.oci_identity_compartment.lab_compartment.id
   cidr_block        = cidrsubnet("10.0.0.0/20", 4, 1)
   display_name      = "sn-${local.resource_name}-public"
   dns_label         = local.public_dns_label
   vcn_id            = oci_core_vcn.vcn.id
   security_list_ids = [oci_core_vcn.vcn.default_security_list_id]
   route_table_id    = oci_core_vcn.vcn.default_route_table_id
   dhcp_options_id   = oci_core_vcn.vcn.default_dhcp_options_id
 }

 # create private subnet 1 ------------------------------------------------------
 resource "oci_core_subnet" "private_subnet1" {
   compartment_id             = data.oci_identity_compartment.lab_compartment.id
   cidr_block                 = cidrsubnet("10.0.0.0/20", 4, 2)
   display_name               = "sn-${local.resource_name}-private-app"
   dns_label                  = local.private_app_dns_label
   prohibit_public_ip_on_vnic = true
   vcn_id                     = oci_core_vcn.vcn.id
   security_list_ids          = [oci_core_security_list.private_security_list.id]
   route_table_id             = oci_core_route_table.private_route_table.id
   dhcp_options_id            = oci_core_dhcp_options.private_dhcp_option.id
 }

 # create private subnet 2 ------------------------------------------------------
 resource "oci_core_subnet" "private_subnet2" {
   compartment_id             = data.oci_identity_compartment.lab_compartment.id
   cidr_block                 = cidrsubnet("10.0.0.0/20", 4, 3)
   display_name               = "sn-${local.resource_name}-private-db"
   dns_label                  = local.private_db_dns_label
   prohibit_public_ip_on_vnic = true
   vcn_id                     = oci_core_vcn.vcn.id
   security_list_ids          = [oci_core_security_list.private_security_list.id]
   route_table_id             = oci_core_route_table.private_route_table.id
   dhcp_options_id            = oci_core_dhcp_options.private_dhcp_option.id
 }
# --- EOF ----------------------------------------------------------------------
