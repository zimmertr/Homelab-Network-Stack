# Debian Image 
variable "DEBIAN_IMAGE_DATASTORE" {
  type        = string
  default     = "local"
}
variable "DEBIAN_IMAGE_NODE_NAME" {
  type        = string
  default     = "mercury"
}
variable "DEBIAN_IMAGE_URL" {
  type        = string
  default     = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
}
variable "DEBIAN_IMAGE_FILENAME" {
  type        = string
  default     = "debian-12-genericcloud-amd64.img"
}


# OpnSense Image
variable "OPNSENSE_IMAGE_DATASTORE" {
  type        = string
  default     = "local"
}
variable "OPNSENSE_IMAGE_NODE_NAME" {
  type        = string
  default     = "mercury"
}
variable "OPNSENSE_IMAGE_URL" {
  type        = string
  default     = "https://mirror.ams1.nl.leaseweb.net/opnsense/releases/23.7/OPNsense-23.7-dvd-amd64.iso.bz2"
}
variable "OPNSENSE_IMAGE_FILENAME" {
  type        = string
  default     = "OPNsense-23.7-dvd-amd64.iso"
}


# Proxmox DNS
variable "PROXMOX_DNS_SEARCH_DOMAIN" {
  type        = string
  default     = "sol.milkyway"
}
variable "PROXMOX_DNS_SERVERS" {
  type        = list
  default     = ["192.168.10.20","192.168.10.30","8.8.8.8"]
}
variable "PROXMOX_NODE_NAME" {
  type        = string
  default     = "mercury"
}
variable "PROXMOX_RESOURCE_POOL_NAME" {
  type        = string
  default     = "Networking"
}
variable "PROXMOX_RESOURCE_POOL_DESCRIPTION" {
  type        = string
  default     = "Resources pertaining to Networking"
}
variable "PROXMOX_IP_ADDRESS" {
  type        = string
  default     = "192.168.1.10"
  description = "IP Address used for Proxmox DNS & hosts entry"
}
variable "PROXMOX_WAN_BRIDGE_NAME" {
  type        = string
  default     = "vmbr1"
  description = "Linux Bridge interface used for WAN connections"
}
variable "PROXMOX_WAN_BRIDGE_PORT" {
  type        = string
  default     = "eno1"
  description = "Linux Network Interface used for WAN connections"
}
variable "PROXMOX_SSH_KEY_PATH" {
  type        = string
  default     = "/Users/tj/.ssh/sol.milkyway.pub"
}


# Unifi Network Application
variable "UNIFI_VM_ID" {
  type        = number
  default     = 10030
}
variable "UNIFI_NODE_NAME" {
  type        = string
  default     = "mercury"
}
variable "UNIFI_CPU_CORES" {
  type        = number
  default     = 1
}
variable "UNIFI_MEMORY" {
  type        = number
  default     = 2048
}
variable "UNIFI_DATASTORE" {
  type        = string
  default     = "local-lvm"
}
variable "UNIFI_DISK_SIZE" {
  type        = string
  default     = "20"
}
variable "UNIFI_NETWORK_DEVICE" {
  type        = string
  default     = "vmbr0"
}
variable "UNIFI_MAC_ADDRESS" {
  type        = string
}
variable "UNIFI_VLAN_ID" {
  type        = number
  default     = 10
}
variable "UNIFI_CLOUD_INIT_DATASTORE"{
  type        = string
  default     = "local"
}
variable "UNIFI_SSH_KEY_PATH" {
  type        = string
  default     = "/Users/tj/.ssh/sol.milkyway.pub"
}
variable "UNIFI_USER_NAME" {
  type        = string
  default     = "tj"
}
variable "UNIFI_HOSTNAME"{
  type        = string
  default     = "cassini"
}
variable "UNIFI_IP_ADDRESS" {
  type        = string
  default     = "192.168.10.10"
  description = "IP Address used for Proxmox DNS & hosts entry"
}


# PowerDNS
variable "POWERDNS_VM_ID" {
  type        = number
  default     = 10020
}
variable "POWERDNS_NODE_NAME" {
  type        = string
  default     = "mercury"
}
variable "POWERDNS_CPU_CORES" {
  type        = number
  default     = 1
}
variable "POWERDNS_MEMORY" {
  type        = number
  default     = 2048
}
variable "POWERDNS_DATASTORE" {
  type        = string
  default     = "local-lvm"
}
variable "POWERDNS_DISK_SIZE" {
  type        = string
  default     = "20"
}
variable "POWERDNS_NETWORK_DEVICE" {
  type        = string
  default     = "vmbr0"
}
variable "POWERDNS_MAC_ADDRESS" {
  type        = string
}
variable "POWERDNS_VLAN_ID" {
  type        = number
  default     = 10
}
variable "POWERDNS_CLOUD_INIT_DATASTORE"{
  type        = string
  default     = "local"
}
variable "POWERDNS_SSH_KEY_PATH" {
  type        = string
  default     = "/Users/tj/.ssh/sol.milkyway.pub"
}
variable "POWERDNS_USER_NAME" {
  type        = string
  default     = "tj"
}
variable "POWERDNS_HOSTNAME"{
  type        = string
  default     = "explorer"
}
variable "POWERDNS_IP_ADDRESS" {
  type        = string
  default     = "192.168.10.20"
  description = "IP Address used for Proxmox DNS & hosts entry"
}


# OPNsense
variable "OPNSENSE_VM_ID" {
  type        = number
  default     = 10001
}
variable "OPNSENSE_NODE_NAME" {
  type        = string
  default     = "mercury"
}
variable "OPNSENSE_CPU_CORES" {
  type        = number
  default     = 2
}
variable "OPNSENSE_MEMORY" {
  type        = number
  default     = 8096
}
variable "OPNSENSE_DATASTORE" {
  type        = string
  default     = "local-lvm"
}
variable "OPNSENSE_DISK_SIZE" {
  type        = string
  default     = "50"
}
variable "OPNSENSE_HOSTNAME"{
  type        = string
  default     = "sol"
}
variable "OPNSENSE_IP_ADDRESS" {
  type        = string
  default     = "192.168.10.1"
  description = "IP Address used for Proxmox DNS & hosts entry"
}
variable "OPNSENSE_LAN_NETWORK_DEVICE" {
  type        = string
  default     = "vmbr0"
}
variable "OPNSENSE_WAN_NETWORK_DEVICE" {
  type        = string
  default     = "vmbr1"
}
variable "OPNSENSE_LAN_MAC_ADDRESS" {
  type        = string
  default     = "6A:00:25:9A:12:13"
}
variable "OPNSENSE_WAN_MAC_ADDRESS" {
  type        = string
  default     = "3E:2A:A4:E3:D5:AA"
}
variable "OPNSENSE_LAN_VLAN_ID" {
  type        = number
  default     = 10
}
variable "OPNSENSE_WAN_VLAN_ID" {
  type        = number
  default     = 10
}


# PiHole
variable "PIHOLE_VM_ID" {
  type        = number
  default     = 10010
}
variable "PIHOLE_NODE_NAME" {
  type        = string
  default     = "mercury"
}
variable "PIHOLE_CPU_CORES" {
  type        = number
  default     = 1
}
variable "PIHOLE_MEMORY" {
  type        = number
  default     = 2048
}
variable "PIHOLE_DATASTORE" {
  type        = string
  default     = "local-lvm"
}
variable "PIHOLE_DISK_SIZE" {
  type        = string
  default     = "20"
}
variable "PIHOLE_NETWORK_DEVICE" {
  type        = string
  default     = "vmbr0"
}
variable "PIHOLE_MAC_ADDRESS" {
  type        = string
}
variable "PIHOLE_VLAN_ID" {
  type        = number
  default     = 10
}
variable "PIHOLE_CLOUD_INIT_DATASTORE"{
  type        = string
  default     = "local"
}
variable "PIHOLE_SSH_KEY_PATH" {
  type        = string
  default     = "/Users/tj/.ssh/sol.milkyway.pub"
}
variable "PIHOLE_USER_NAME" {
  type        = string
  default     = "tj"
}
variable "PIHOLE_HOSTNAME"{
  type        = string
  default     = "sputnik"
}
variable "PIHOLE_IP_ADDRESS" {
  type        = string
  default     = "192.168.10.30"
  description = "IP Address used for Proxmox DNS & hosts entry"
}
