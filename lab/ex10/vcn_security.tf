# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: vcn_security.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2022.09.22
# Revision...: 
# Purpose....: Public und Private security list resources.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

#SEC # create default security list
#SEC resource "oci_core_default_security_list" "public_security_list" {
#SEC   manage_default_resource_id = oci_core_vcn.vcn.default_security_list_id
#SEC   display_name               = "tf-sl-${local.resource_name}-public"

#SEC   # allow outbound tcp traffic on all ports
#SEC   egress_security_rules {
#SEC     protocol    = "ALL"
#SEC     destination = "0.0.0.0/0"
#SEC   }

#SEC   # allow inbound SSH traffic
#SEC   ingress_security_rules {
#SEC     description = "Allow inbound SSH traffic"
#SEC     protocol    = 6
#SEC     source      = "0.0.0.0/0"

#SEC     tcp_options {
#SEC       min = 22
#SEC       max = 22
#SEC     }
#SEC   }

#SEC   # allow inbound HTTP traffic
#SEC   ingress_security_rules {
#SEC     description = "Allow inbound HTTP traffic"
#SEC     protocol    = 6
#SEC     source      = "0.0.0.0/0"

#SEC     tcp_options {
#SEC       min = 80
#SEC       max = 80
#SEC     }
#SEC   }
#SEC }

#SEC # create default security list
#SEC resource "oci_core_security_list" "private_security_list" {
#SEC   compartment_id = data.oci_identity_compartment.lab_compartment.id
#SEC   vcn_id         = oci_core_vcn.vcn.id
#SEC   display_name   = "tf-sl-${local.resource_name}-private"

#SEC   # allow outbound tcp traffic on all ports
#SEC   egress_security_rules {
#SEC     protocol    = "ALL"
#SEC     destination = "0.0.0.0/0"
#SEC   }

#SEC   # allow inbound SSH traffic
#SEC   ingress_security_rules {
#SEC     description = "Allow inbound SSH traffic"
#SEC     protocol    = 6
#SEC     source      = "0.0.0.0/0"

#SEC     tcp_options {
#SEC       min = 22
#SEC       max = 22
#SEC     }
#SEC   }

#SEC   # allow inbound HTTP traffic
#SEC   ingress_security_rules {
#SEC     description = "Allow inbound HTTP traffic"
#SEC     protocol    = 6
#SEC     source      = "0.0.0.0/0"

#SEC     tcp_options {
#SEC       min = 80
#SEC       max = 80
#SEC     }
#SEC   }

#SEC   # allow inbound HTTP traffic
#SEC   ingress_security_rules {
#SEC     description = "Allow inbound SQL traffic"
#SEC     protocol    = 6
#SEC     source      = "0.0.0.0/0"

#SEC     tcp_options {
#SEC       min = 1521
#SEC       max = 1521
#SEC     }
#SEC   }
#SEC }
# --- EOF ----------------------------------------------------------------------
