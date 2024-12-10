resource "local_file" "ansible_inventory" {
  content  = templatefile("/etc/homewrk2/ter-homeworks/03/src/inventory.yml", {
    webservers = var.webservers
    databases  = var.databases
    storage    = var.storage
  })

  filename = "$/etc/homewrk2/ter-homeworks/03/src/inventory.ini"
}
