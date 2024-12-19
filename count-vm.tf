resource "yandex_compute_instance" "web" {

  count = 2

  name        = "web-${count.index+1}" 
  hostname    = "web-${count.index+1}" 
  platform_id = "standard-v3"

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      type = var.disk_type
      size = var.disk_size
    }
  }

 scheduling_policy { 
    preemptible = var.is_preemptible 
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [data.yandex_vpc_security_group.dynamic_example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }


  allow_stopping_for_update = true

  depends_on = [yandex_compute_instance.db]
}



