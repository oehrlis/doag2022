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

#SUB # create public subnet ---------------------------------------------------------
#SUB resource "oci_core_subnet" "public_subnet" {
#SUB   compartment_id    = data.oci_identity_compartment.lab_compartment.id
#SUB   cidr_block        = cidrsubnet("10.0.0.0/20", 4, 1)
#SUB   display_name      = "tf-sn-${local.resource_name}-public"
#SUB   dns_label         = local.public_dns_label
#SUB   vcn_id            = oci_core_vcn.vcn.id
#SUB   security_list_ids = [oci_core_vcn.vcn.default_security_list_id]
#SUB   route_table_id    = oci_core_vcn.vcn.default_route_table_id
#SUB   dhcp_options_id   = oci_core_vcn.vcn.default_dhcp_options_id
#SUB }

#SUB # create private subnet 1 ------------------------------------------------------
#SUB resource "oci_core_subnet" "private_subnet1" {
#SUB   compartment_id             = data.oci_identity_compartment.lab_compartment.id
#SUB   cidr_block                 = cidrsubnet("10.0.0.0/20", 4, 2)
#SUB   display_name               = "tf-sn-${local.resource_name}-private-app"
#SUB   dns_label                  = local.private_app_dns_label
#SUB   prohibit_public_ip_on_vnic = true
#SUB   vcn_id                     = oci_core_vcn.vcn.id
#SUB   security_list_ids          = [oci_core_security_list.private_security_list.id]
#SUB   route_table_id             = oci_core_route_table.private_route_table.id
#SUB   dhcp_options_id            = oci_core_dhcp_options.private_dhcp_option.id
#SUB }

#SUB # create private subnet 2 ------------------------------------------------------
#SUB resource "oci_core_subnet" "private_subnet2" {
#SUB   compartment_id             = data.oci_identity_compartment.lab_compartment.id
#SUB   cidr_block                 = cidrsubnet("10.0.0.0/20", 4, 3)
#SUB   display_name               = "tf-sn-${local.resource_name}-private-db"
#SUB   dns_label                  = local.private_db_dns_label
#SUB   prohibit_public_ip_on_vnic = true
#SUB   vcn_id                     = oci_core_vcn.vcn.id
#SUB   security_list_ids          = [oci_core_security_list.private_security_list.id]
#SUB   route_table_id             = oci_core_route_table.private_route_table.id
#SUB   dhcp_options_id            = oci_core_dhcp_options.private_dhcp_option.id
#SUB }
# --- EOF ----------------------------------------------------------------------
