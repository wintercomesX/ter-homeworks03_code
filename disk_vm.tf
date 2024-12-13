resource "yandex_compute_disk" "storage_disk" {
  count = 3

  name     = "storage-disk-${count.index + 1}"
  size     = 1                                    
  type = "network-ssd"
}

resource "yandex_compute_instance" "storage" {
  name   = "storage"
  hostname = "storage"
  platform_id = "standard-v3"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
#      auto_delete = true
      image_id    = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [var.security_id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    content {
      disk_id = secondary_disk.value.id
      # auto_delete = true  # (опционально) для автоматического удаления
    }
  }
}
