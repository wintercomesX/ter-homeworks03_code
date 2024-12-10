resource "yandex_compute_instance" "web" {

  count = 2

  name        = "web-${count.index+1}" #Имя ВМ в облачной консоли
  hostname    = "web-${count.index+1}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
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
    security_group_ids = ["enpfjh55d01i8l6n9l0p"]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }


  allow_stopping_for_update = true

  depends_on = [yandex_compute_instance.db]
}



