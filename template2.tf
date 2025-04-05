provider "proxmox" {
    pm_api_url      = "https://your-proxmox-server:8006/api2/json"
    pm_user         = "root@pam"
    pm_password     = "your-password"
    pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "cloned_vm" {
    name       = "cloned-vm"
    target_node = "proxmox-node-name"
    clone      = "source-vm-name"

    cpu {
        cores = 2
    }

    memory {
        dedicated = 2048
    }

    network {
        model  = "virtio"
        bridge = "vmbr0"
    }

    disk {
        size = "20G"
    }
}