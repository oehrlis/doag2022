# ------------------------------------------------------------------------------
# Trivadis - Part of Accenture, Platform Factory - Data Platforms
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: variables.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2021.11.17
# Revision...: 
# Purpose....: Variable file for the terraform configuration.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------
# provider identity parameters ------------------------------------------------
variable "user_ocid" {
  description = "user OCID used to access OCI"
  default     = ""
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint for user"
  default     = ""
  type        = string
}

variable "private_key_path" {
  description = "Private Key Path"
  default     = ""
  type        = string
}

variable "tenancy_ocid" {
  description = "tenancy id where to create the resources"
  type        = string
}


variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The OCI region where resources will be created"
  type        = string
}

# --- LAB Config ---------------------------------------------------------------
variable "lab_compartment_name" {
  description = "Name of the students LAB Compartment"
  default     = ""
  type        = string
}
variable "base_compartment_ocid" {
  description = "OCID of the base compartment"
  default     = ""
  type        = string
}
# --- EOF ----------------------------------------------------------------------
