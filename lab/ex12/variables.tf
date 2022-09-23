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

variable "ssh_public_key_path" {
  description = "path to the ssh public key used to access the bastion. set this or the ssh_public_key"
  default     = ""
  type        = string
}

variable "ad_index" {
  description = "The index of the availability domain. This is used to identify the availability_domain place the compute instances."
  default     = 1
  type        = number
}

# --- Compute Config -----------------------------------------------------------
variable "compute_public_os" {
  description = "Base OS for the compute host."
  default     = "Oracle Linux"
  type        = string
}

variable "compute_public_os_version" {
  description = "Define Base OS version for the compute host."
  default     = "7.8"
  type        = string
}

variable "compute_public_private_ip" {
  description = "Private IP for host."
  default     = "10.0.1.10"
  type        = string
}

variable "compute_public_shape" {
  description = "The shape of compute instance."
  default     = "VM.Standard.E4.Flex"
  type        = string
}

variable "compute_public_ocpus" {
  description = "The ocpus for the shape."
  default     = 1
  type        = number
}

variable "compute_public_memory_in_gbs" {
  description = "The memory in gbs for the shape."
  default     = 4
  type        = number
}

variable "compute_public_boot_volume_size" {
  description = "Size of the boot volume."
  default     = 50
  type        = number
}
# --- EOF ----------------------------------------------------------------------
