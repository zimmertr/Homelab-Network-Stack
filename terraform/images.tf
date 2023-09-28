resource "proxmox_virtual_environment_file" "debian_image" {
  content_type  = "iso"
  datastore_id  = var.DEBIAN_IMAGE_DATASTORE
  node_name     = var.DEBIAN_IMAGE_NODE_NAME

  source_file {
    path        = var.DEBIAN_IMAGE_URL
    file_name   = var.DEBIAN_IMAGE_FILENAME
  }
}

resource "proxmox_virtual_environment_file" "opnsense_image" {
  content_type  = "iso"
  datastore_id  = var.OPNSENSE_IMAGE_DATASTORE
  node_name     = var.OPNSENSE_IMAGE_NODE_NAME

  source_file {
    path        = var.OPNSENSE_IMAGE_URL
    file_name   = var.OPNSENSE_IMAGE_FILENAME
  }
  
  connection {
    type     = "ssh"
    user     = "root"
    password = var.PROXMOX_SSH_KEY_PATH
    host     = var.PROXMOX_IP_ADDRESS
  }

  # Proxmox won't let you upload a bz2 archive as a disk image. So trick it by saving the file as *.iso.
  # Afterwards, use a remote-exec provisioner to name it back to *.bz2 and, finally, extract it. 
  provisioner "remote-exec" {
    inline = [
      "mv /var/lib/vz/template/iso/${var.OPNSENSE_IMAGE_FILENAME} /var/lib/vz/template/iso/${var.OPNSENSE_IMAGE_FILENAME}.bz2",
      "bzip2 -d /var/lib/vz/template/iso/${var.OPNSENSE_IMAGE_FILENAME}.bz2"
    ]
  }
}
