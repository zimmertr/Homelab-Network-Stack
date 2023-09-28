data "local_file" "ssh_public_key_sputnik" {
  filename = var.PIHOLE_SSH_KEY_PATH
}

resource "proxmox_virtual_environment_file" "user_data_sputnik" {
  content_type = "snippets"
  datastore_id = var.PIHOLE_CLOUD_INIT_DATASTORE
  node_name    = var.PIHOLE_NODE_NAME

  source_raw {
    file_name = "vm-${var.PIHOLE_VM_ID}-cloud-config.yaml"   
    data = <<EOF
#cloud-config
hostname: ${var.PIHOLE_HOSTNAME}

users:
  - default
  - name: ${var.PIHOLE_USER_NAME}
    groups:
      - sudo
    shell: /bin/bash
    ssh_authorized_keys:
      - ${trimspace(data.local_file.ssh_public_key_sputnik.content)}
    sudo: ALL=(ALL) NOPASSWD:ALL

package_upgrade: true

packages:
  - qemu-guest-agent

runcmd:
    - systemctl enable --now qemu-guest-agent
    EOF
  }
}

resource "proxmox_virtual_environment_vm" "sputnik" {
  vm_id                   = var.PIHOLE_VM_ID
  pool_id                 = proxmox_virtual_environment_pool.resource_pool.id
  name                    = var.PIHOLE_HOSTNAME

  node_name               = var.PIHOLE_NODE_NAME
  
  description             = "PiHole"
  tags                    = ["Networking"]

  agent { enabled         = true }
  operating_system {type  = "l26"  }
  serial_device {}  
  
  cpu {
    cores                 = var.PIHOLE_CPU_CORES

  }

  memory {
    dedicated             = var.PIHOLE_MEMORY
  }

  disk {
    datastore_id          = var.PIHOLE_DATASTORE
    file_id               = proxmox_virtual_environment_file.debian_image.id
    interface             = "scsi0"
    size                  = var.PIHOLE_DISK_SIZE
  }

  network_device {
    bridge                = var.PIHOLE_NETWORK_DEVICE
    mac_address           = var.PIHOLE_MAC_ADDRESS
    vlan_id               = var.PIHOLE_VLAN_ID
  }  

  initialization {
    datastore_id          = var.PIHOLE_CLOUD_INIT_DATASTORE
    user_data_file_id     = proxmox_virtual_environment_file.user_data_sputnik.id

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  lifecycle {
    ignore_changes        = [tags]
  }
}
