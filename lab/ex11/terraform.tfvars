# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: terraform.tfvars
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2022.09.20
# Revision...: 
# Purpose....: Terraform Variable file.
# Notes......: 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

# defined by environment variables ---------------------------------------------
# fingerprint                 = ""
# private_key_path            = ""
# tenancy_ocid                = ""
# user_ocid                   = ""

# provider identity parameters -------------------------------------------------
region = "eu-frankfurt-1"

# general lab parameters -------------------------------------------------------
base_compartment_ocid   = "ocid1.compartment.oc1..aaaaaaaarwdzpyew2frhxyoor5lymqzlcktktzu7mnd24zpvu3l5id3mupaq"
ssh_public_key_path     = "/Users/stefan.oehrli/.ssh/id_rsa_doag.pub"
ad_index                = 3

# compute public parameters ----------------------------------------------------
compute_public_private_ip       = "10.0.1.10"
compute_public_shape            = "VM.Standard.E4.Flex"
compute_public_ocpus            = 1
compute_public_memory_in_gbs    = 4
compute_public_boot_volume_size = 50
# --- EOF ----------------------------------------------------------------------
