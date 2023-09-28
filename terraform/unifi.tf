data "local_file" "ssh_public_key_unifi" {
  filename = var.UNIFI_SSH_KEY_PATH
}

resource "proxmox_virtual_environment_file" "user_data_unifi" {
  content_type = "snippets"
  datastore_id = var.UNIFI_CLOUD_INIT_DATASTORE
  node_name    = var.UNIFI_NODE_NAME

  source_raw {
    file_name = "vm-${var.UNIFI_VM_ID}-cloud-config.yaml"
    data = <<EOF
#cloud-config
hostname: ${var.UNIFI_HOSTNAME}

users:
  - default
  - name: ${var.UNIFI_USER_NAME}
    groups:
      - sudo
    shell: /bin/bash
    ssh_authorized_keys:
      - ${trimspace(data.local_file.ssh_public_key_unifi.content)}
    sudo: ALL=(ALL) NOPASSWD:ALL

package_upgrade: true

packages:
  - qemu-guest-agent
  
runcmd:
    - systemctl enable --now qemu-guest-agent
    EOF
  }
}

resource "proxmox_virtual_environment_vm" "unifi" {
  vm_id                   = var.UNIFI_VM_ID
  pool_id                 = proxmox_virtual_environment_pool.resource_pool.id
  name                    = var.UNIFI_HOSTNAME

  node_name               = var.UNIFI_NODE_NAME
  
  description             = "Unifi Network Application"
  tags                    = ["Networking"]

  agent { enabled         = true }
  operating_system {type  = "l26"  }
  serial_device {}  
  
  cpu {
    cores                 = var.UNIFI_CPU_CORES

  }

  memory {
    dedicated             = var.UNIFI_MEMORY
  }

  disk {
    datastore_id          = var.UNIFI_DATASTORE
    file_id               = proxmox_virtual_environment_file.debian_image.id
    interface             = "scsi0"
    size                  = var.UNIFI_DISK_SIZE
  }

  network_device {
    bridge                = var.UNIFI_NETWORK_DEVICE
    mac_address           = var.UNIFI_MAC_ADDRESS
    vlan_id               = var.UNIFI_VLAN_ID
  }  

  initialization {
    datastore_id          = var.UNIFI_CLOUD_INIT_DATASTORE
    user_data_file_id     = proxmox_virtual_environment_file.user_data_unifi.id   

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
