provider "proxmox" {}

terraform {
  required_providers {
    proxmox     = {
      source    = "bpg/proxmox"
      version   = "0.32.0"
    }
  } 
}
