
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# Data Source for Ubuntu Image

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_ubuntu
}

data "yandex_vpc_security_group" "dynamic_example" {
  name     = "example_dynamic"
  folder_id = var.folder_id
}

resource "yandex_compute_instance" "ubuntu" {
  name        = var.vpc_name
  platform_id = "standard-v3"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [data.yandex_vpc_security_group.dynamic_example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}


