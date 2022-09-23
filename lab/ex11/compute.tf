# ------------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: compute.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2021.06.08
# Revision...: 
# Purpose....: Compute Instance for the terraform module tvdlab host.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

resource "oci_core_instance" "compute_public" {
  availability_domain = local.availability_domain
  compartment_id      = data.oci_identity_compartment.lab_compartment.id
  display_name        = "tfci-${local.resource_name}-public"
  shape               = var.compute_public_shape
  state               = "RUNNING"

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet.id
    assign_public_ip = true
    private_ip       = var.compute_public_private_ip
    display_name     = "vnic"
    hostname_label   = "tfci-${local.resource_name}-public"
  }

  # prevent the host from destroying and recreating itself if the image ocid changes 
  lifecycle {
    ignore_changes = [source_details[0].source_id]
  }

  metadata = {
    ssh_authorized_keys = local.ssh_authorized_keys
  }

  shape_config {
    memory_in_gbs = var.compute_public_memory_in_gbs
    ocpus         = var.compute_public_ocpus
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.oracle_images.images.0.id
    boot_volume_size_in_gbs = var.compute_public_boot_volume_size
  }

  timeouts {
    create = "60m"
  }
}
# --- EOF ----------------------------------------------------------------------
