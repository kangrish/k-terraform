provider "proxmox" {
    pm_api_url      = "https://your-proxmox-server:8006/api2/json"
    pm_user         = "root@pam"
    pm_password     = "your-password"
    pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "example" {
    name        = "terraform-vm"
    target_node = "proxmox-node"

    clone {
        base_vm_id = "template-id"
        storage    = "local-lvm"
    }

    disks {
        id           = 0
        size         = 10
        type         = "scsi"
        storage      = "local-lvm"
        storage_type = "lvm"
    }

    network {
        id      = 0
        bridge  = "vmbr0"
        model   = "virtio"
    }

    cpu {
        sockets = 1
        cores   = 2
    }

    memory {
        dedicated = 2048
    }

    lifecycle {
        ignore_changes = [
            "network",
        ]
    }
}