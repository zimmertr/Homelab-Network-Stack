# Intel Celeron G1610T does not support VT-D so I cannot simply forward the PCI devices to the VM
resource "proxmox_virtual_environment_network_linux_bridge" "wan_bridge_network_interface" {
  node_name = var.PROXMOX_NODE_NAME
  name      = var.PROXMOX_WAN_BRIDGE_NAME

  comment   = "WAN"

  ports = [
    "eno1"
  ]
  
  connection {
    type     = "ssh"
    user     = "root"
    password = var.PROXMOX_SSH_KEY_PATH
    host     = var.PROXMOX_IP_ADDRESS
  }

  # Proxmox needs its networking configuration reloaded after adding the interface
  provisioner "remote-exec" {
    inline = [
      "ifreload -a"
    ]
  }
}

resource "proxmox_virtual_environment_vm" "opnsense" {
  vm_id                   = var.OPNSENSE_VM_ID
  pool_id                 = proxmox_virtual_environment_pool.resource_pool.id
  name                    = var.OPNSENSE_HOSTNAME
  node_name               = var.OPNSENSE_NODE_NAME
  started                 = false
  description             = "OPNsense"
  tags                    = ["Networking"]

  serial_device {}  
  memory {dedicated       = var.OPNSENSE_MEMORY}

  cpu {
    cores                 = var.OPNSENSE_CPU_CORES
    type                  = "host"
  }

  cdrom {
    enabled               = true
    file_id               = proxmox_virtual_environment_file.opnsense_image.id
  }

  disk {
    datastore_id          = var.OPNSENSE_DATASTORE
    file_format           = "raw"
    interface             = "virtio0"
    size                  = var.OPNSENSE_DISK_SIZE
  }

  network_device {
    bridge                = var.OPNSENSE_LAN_NETWORK_DEVICE
    mac_address           = var.OPNSENSE_LAN_MAC_ADDRESS
    vlan_id               = var.OPNSENSE_LAN_VLAN_ID
  }  

  network_device {
    bridge                = var.OPNSENSE_LAN_NETWORK_DEVICE
    mac_address           = var.OPNSENSE_WAN_MAC_ADDRESS
    vlan_id               = var.OPNSENSE_WAN_VLAN_ID
  }    

  lifecycle {
    ignore_changes        = [tags,cdrom]
  }
}
