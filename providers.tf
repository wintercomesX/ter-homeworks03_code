terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

provider "yandex" {
#  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
  service_account_key_file = file("/etc/homewrk2/ter-homeworks/03/src/authorized_key.json")
}
