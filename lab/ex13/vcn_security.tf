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

 # create default security list
 resource "oci_core_default_security_list" "public_security_list" {
   manage_default_resource_id = oci_core_vcn.vcn.default_security_list_id
   display_name               = "sl-${local.resource_name}-public"

   # allow outbound tcp traffic on all ports
   egress_security_rules {
     protocol    = "ALL"
     destination = "0.0.0.0/0"
   }

   # allow inbound SSH traffic
   ingress_security_rules {
     description = "Allow inbound SSH traffic"
     protocol    = 6
     source      = "0.0.0.0/0"

     tcp_options {
       min = 22
       max = 22
     }
   }

   # allow inbound HTTP traffic
   ingress_security_rules {
     description = "Allow inbound HTTP traffic"
     protocol    = 6
     source      = "0.0.0.0/0"

     tcp_options {
       min = 80
       max = 80
     }
   }
 }

 # create default security list
 resource "oci_core_security_list" "private_security_list" {
   compartment_id = data.oci_identity_compartment.lab_compartment.id
   vcn_id         = oci_core_vcn.vcn.id
   display_name   = "sl-${local.resource_name}-private"

   # allow outbound tcp traffic on all ports
   egress_security_rules {
     protocol    = "ALL"
     destination = "0.0.0.0/0"
   }

   # allow inbound SSH traffic
   ingress_security_rules {
     description = "Allow inbound SSH traffic"
     protocol    = 6
     source      = "0.0.0.0/0"

     tcp_options {
       min = 22
       max = 22
     }
   }

   # allow inbound HTTP traffic
   ingress_security_rules {
     description = "Allow inbound HTTP traffic"
     protocol    = 6
     source      = "0.0.0.0/0"

     tcp_options {
       min = 80
       max = 80
     }
   }

   # allow inbound HTTP traffic
   ingress_security_rules {
     description = "Allow inbound SQL traffic"
     protocol    = 6
     source      = "0.0.0.0/0"

     tcp_options {
       min = 1521
       max = 1521
     }
   }
 }
# --- EOF ----------------------------------------------------------------------
