resource "yandex_compute_instance" "db" {
  for_each = var.database_vms

  name                  = each.key
  hostname             = each.key
  platform_id          = "standard-v3"

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  
  boot_disk {
    initialize_params {
     image_id = data.yandex_compute_image.ubuntu.id
     size = each.value.disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat = true
    security_group_ids = ["enpfjh55d01i8l6n9l0p"]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }


}
