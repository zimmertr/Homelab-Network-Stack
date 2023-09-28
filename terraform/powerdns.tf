data "local_file" "ssh_public_key_powerdns" {
  filename = var.POWERDNS_SSH_KEY_PATH
}

resource "proxmox_virtual_environment_file" "user_data_powerdns" {
  content_type = "snippets"
  datastore_id = var.POWERDNS_CLOUD_INIT_DATASTORE
  node_name    = var.POWERDNS_NODE_NAME

  source_raw {
    file_name = "vm-${var.POWERDNS_VM_ID}-cloud-config.yaml"
    data = <<EOF
#cloud-config
hostname: ${var.POWERDNS_HOSTNAME}

users:
  - default
  - name: ${var.POWERDNS_USER_NAME}
    groups:
      - sudo
    shell: /bin/bash
    ssh_authorized_keys:
      - ${trimspace(data.local_file.ssh_public_key_powerdns.content)}
    sudo: ALL=(ALL) NOPASSWD:ALL

package_upgrade: true

packages:
  - qemu-guest-agent

runcmd:
    - systemctl enable --now qemu-guest-agent
    EOF
  }
}

resource "proxmox_virtual_environment_vm" "powerdns" {
  vm_id                   = var.POWERDNS_VM_ID
  pool_id                 = proxmox_virtual_environment_pool.resource_pool.id
  name                    = var.POWERDNS_HOSTNAME

  node_name               = var.POWERDNS_NODE_NAME
  
  description             = "PowerDNS"
  tags                    = ["Networking"]

  agent { enabled         = true }
  operating_system {type  = "l26"  }
  serial_device {}  
  
  cpu {
    cores                 = var.POWERDNS_CPU_CORES

  }

  memory {
    dedicated             = var.POWERDNS_MEMORY
  }

  disk {
    datastore_id          = var.POWERDNS_DATASTORE
    file_id               = proxmox_virtual_environment_file.debian_image.id
    interface             = "scsi0"
    size                  = var.POWERDNS_DISK_SIZE
  }

  network_device {
    bridge                = var.POWERDNS_NETWORK_DEVICE
    mac_address           = var.POWERDNS_MAC_ADDRESS
    vlan_id               = var.POWERDNS_VLAN_ID
  }  

  initialization {
    datastore_id          = var.POWERDNS_CLOUD_INIT_DATASTORE
    user_data_file_id     = proxmox_virtual_environment_file.user_data_powerdns.id   

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
