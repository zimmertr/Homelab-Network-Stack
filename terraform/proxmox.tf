resource "proxmox_virtual_environment_pool" "resource_pool" {
  comment = var.PROXMOX_RESOURCE_POOL_DESCRIPTION
  pool_id = var.PROXMOX_RESOURCE_POOL_NAME
}

resource "proxmox_virtual_environment_dns" "dns_configuration" {
  domain    = var.PROXMOX_DNS_SEARCH_DOMAIN
  node_name = var.PROXMOX_NODE_NAME

  servers = var.PROXMOX_DNS_SERVERS
}

resource "proxmox_virtual_environment_hosts" "hosts_file" {
  node_name = var.PROXMOX_NODE_NAME

  entry {
    address = var.PROXMOX_IP_ADDRESS

    hostnames = [
      "${var.PROXMOX_NODE_NAME}",
      "${var.PROXMOX_NODE_NAME}.sol.milkyway",
    ]
  }
  entry {
    address = var.OPNSENSE_IP_ADDRESS

    hostnames = [
      "${var.OPNSENSE_HOSTNAME}",
      "${var.OPNSENSE_HOSTNAME}.sol.milkyway",
    ]
  }
  entry {
    address = var.UNIFI_IP_ADDRESS

    hostnames = [
      "${var.UNIFI_HOSTNAME}",
      "${var.UNIFI_HOSTNAME}.sol.milkyway",
    ]
  }
  entry {
    address = var.POWERDNS_IP_ADDRESS

    hostnames = [
      "${var.POWERDNS_HOSTNAME}",
      "${var.POWERDNS_HOSTNAME}.sol.milkyway",
    ]
  }
  entry {
    address = var.PIHOLE_IP_ADDRESS

    hostnames = [
      "${var.PIHOLE_HOSTNAME}",
      "${var.PIHOLE_HOSTNAME}.sol.milkyway",
    ]
  }
}
