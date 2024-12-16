locals {

  webservers = [
    for instance in yandex_compute_instance.web :
    {
      name = instance.name
      ip   = instance.network_interface[0].nat ? instance.network_interface[0].nat_ip_address : instance.network_interface[0].ip_address
      fqdn = "${instance.name}.ru-central1.internal"
    }
  ]

  databases = [
    for instance in yandex_compute_instance.db :
    {
      name = instance.name
      ip   = instance.network_interface[0].nat ? instance.network_interface[0].nat_ip_address : instance.network_interface[0].ip_address
      fqdn = "${instance.name}.ru-central1.internal"
    }
  ]

  storage = [
    for instance in yandex_compute_instance.storage :
    {
      name = instance.name
      ip   = instance.network_interface[0].nat ? instance.network_interface[0].nat_ip_address : instance.network_interface[0].ip_address
      fqdn = "${instance.name}.ru-central1.internal"
    }
  ]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.yml.tpl", {
    webservers = local.webservers,
    databases  = local.databases,
    storages   = local.storage,
  })

  filename = "/etc/homewrk2/ter-homeworks/03/src/inventory.yml"
}
