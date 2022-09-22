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
  # backend "http" {
  #   update_method = "PUT"
  #   address       = "https://objectstorage.eu-zurich-1.oraclecloud.com/p/85_v_f7WQxnsTfHe53ab5KH6swneqzVXa1evVnfYRkxpgdvN7X1rdHOxH1PE87F-/n/frxplqvlwvmz/b/Student01/o/terraform.tfstate"
  # }
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.0.0"
    }
  }
}

# define the terraform provider
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

# --- EOF ----------------------------------------------------------------------
