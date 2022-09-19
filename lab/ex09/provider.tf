# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: provider.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2022.19.19
# Revision...: 
# Purpose....: Provider specific configuration for this terraform configuration.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

# define remote state file for terraform
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.0.0"
    }
  }
}

# define the terraform provider
provider "oci" {
  tenancy_ocid     = "<TENANCY_OCID>"
  user_ocid        = "<USER_OCID>"
  fingerprint      = "<FINGERPRINT>"
  private_key_path = "<PRIVATE_KEY_PATH>"
  region           = "<REGION>"
}
# --- EOF ----------------------------------------------------------------------
