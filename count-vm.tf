resource "yandex_compute_instance" "web" {

  count = 2

  name        = "web-${count.index+1}" 
  hostname    = "web-${count.index+1}" 
  platform_id = "standard-v3"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      type     = "network-hdd"
      size     = 5
    }
  }


  scheduling_policy { preemptible = true }

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



