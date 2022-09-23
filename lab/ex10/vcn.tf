# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: vcn.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2022.09.22
# Revision...: 
# Purpose....: VCN resource for the terraform configuration.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

# Main VCN resource
resource "oci_core_vcn" "vcn" {
  compartment_id = data.oci_identity_compartment.lab_compartment.id
  cidr_blocks    = ["10.0.0.0/16"]
  display_name   = "tf-vnc-${local.resource_name}"
  dns_label      = local.resource_shortname
}

# create public DHCP option -------------------------------------------------
resource "oci_core_default_dhcp_options" "public_dhcp_option" {
  manage_default_resource_id = oci_core_vcn.vcn.default_dhcp_options_id
  display_name               = "Default public dhcp tf-vnc-${local.resource_name}"

  options {
    custom_dns_servers = []
    server_type        = "VcnLocalPlusInternet"
    type               = "DomainNameServer"
  }

  options {
    search_domain_names = [
      "${local.resource_shortname}.oraclevcn.com",
    ]
    type = "SearchDomain"
  }
}

# create private DHCP option ------------------------------------------------
resource "oci_core_dhcp_options" "private_dhcp_option" {
  compartment_id = data.oci_identity_compartment.lab_compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "Default private dhcp tf-vnc-${local.resource_name}"

  # domain names server
  options {
    custom_dns_servers = []
    server_type        = "VcnLocalPlusInternet"
    type               = "DomainNameServer"
  }

  options {
    search_domain_names = [
      "${local.resource_shortname}.oraclevcn.com",
    ]
    type = "SearchDomain"
  }
}
# --- EOF ----------------------------------------------------------------------
