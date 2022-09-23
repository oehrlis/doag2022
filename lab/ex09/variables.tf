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
#VAR variable "user_ocid" {
#VAR   description = "user OCID used to access OCI"
#VAR   default     = ""
#VAR   type        = string
#VAR }

#VAR variable "fingerprint" {
#VAR   description = "Fingerprint for user"
#VAR   default     = ""
#VAR   type        = string
#VAR }

#VAR variable "private_key_path" {
#VAR   description = "Private Key Path"
#VAR   default     = ""
#VAR   type        = string
#VAR }

#VAR variable "tenancy_ocid" {
#VAR   description = "tenancy id where to create the resources"
#VAR   type        = string
#VAR }

#VAR variable "region" {
#VAR   # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
#VAR   description = "The OCI region where resources will be created"
#VAR   type        = string
#VAR }

# --- LAB Config ---------------------------------------------------------------
variable "lab_id" {
  description = "Student LAB ID"
  default     = ""
  type        = string
}
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
