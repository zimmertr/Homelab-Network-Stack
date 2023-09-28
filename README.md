# Proxmox Network Stack

* [Summary](#Summary)
* [Instructions](#Instructions)

<hr>

## Summary

This was a project I started to stand up my common network stack using (mostly) Terraform on Promxox. It consists of:

* OPNsense
* Pi-Hole
* PowerDNS Recursor Server
* PowerDNS Authoritative Server
* PowerDNS Admin Server
* Unifi Network Application

After spending a lot of time on it and getting a viable proof of concept working, I decided I wasn't going to run OPNsense on Proxmox after all. Instead, I would install it directly on metal and use plugins for AdGuard, Unbound, the Unifi Network Application. So, I stopped work on it and pushed it to GitHub as is. At the very least people might find it a useful example of the BPG Terraform provider with cloud-init and such. 

<hr>

## Instructions

1. Ensure that an API Token and SSH Key exist for your Proxmox server. My token has the following permissions:

   > VM.Monitor, VM.Audit, Pool.Allocate, Pool.Audit, Datastore.AllocateSpace, VM.Config.HWType, Datastore.AllocateTemplate, VM.Config.Options, VM.Config.CDROM, VM.Config.Cloudinit, SDN.Use, VM.Config.CPU, VM.Config.Memory, VM.Config.Network, Sys.Conopnsensee, VM.PowerMgmt, VM.Allocate, Datastore.Audit, VM.Config.Disk, Sys.Modify, Sys.Audit, VM.Migrate, VM.Clone, Datastore.Allocate, Group.Allocate, Mapping.Audit, Mapping.Modify, Mapping.Use, Permissions.Modify, Realm.Allocate, Realm.AllocateUser, SDN.Allocate, SDN.Audit, Sys.Incoming, Sys.PowerMgmt, Sys.Syslog, User.Modify, VM.Backup, VM.Conopnsensee, VM.Snapshot, VM.Snapshot.Rollback

2. Create `config.env`, complete the necessary variables, and source the variables to your shell.

   ```bash
   cp config.env{.example,}
   vim config.env
   source config.env
   ```

3. Start the SSH Agent and add your SSH Key.
   ```bash
    eval "$(ssh-agent -s)"
    ssh-add --apple-use-keychain ~/.ssh/REPLACEME
   ```

4. Create the resources
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

5. Configure the Ansible inventory file
   ```bash
   vim inventory.yml
   ```

6. Search the codebase for `REPLACEME` and add in all your passwords

7. Use Ansible to install Docker on the VMs and stand up the services with Docker Compose:

   ```bash
   ansible-playbook -i inventory.yml provision_vms.yml
   ```

   
