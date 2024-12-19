### Cloud Variables
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

variable "cloud_id" {
  type        = string
  default     = "b1gok7td6eko66eb27qa"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gghnpp51joeriep6bo"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

### VM Variables
variable "vm_web_ubuntu" {
  default = "ubuntu-2004-lts"
  description = "The family of Ubuntu images to use for VM instances"
}

### for_each_variables

variable "database_vms" {
  type = map(object({
    disk_size    = number
    cores        = number
    memory       = number
    core_fraction = number 
  }))
  default = {
    main = {
      disk_size    = 6
      cores        = 2
      memory       = 1
      core_fraction = 20

    }
    replica = {
      disk_size    = 5
      cores        = 2
      memory       = 3
      core_fraction = 20
    }
  }
}

###metadata
variable "vms_ssh_root_key" {
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICYNA6NYQ46OZl41UMQXj+XZ5gjfkycS4f8I56TVdiGa root@kirill-VirtualBox"
  description = "ssh-keygen -t ed25519"
}


###vm-variables

# variable "webservers" {
#   type = list(object({
#     name        = string
#     external_ip = string
#     fqdn        = string
#   }))
# 
#   default = [
#     {
#       name        = "web-1"
#       external_ip = "89.169.154.134"
#       fqdn        = "web-1.ru-central1.internal"
#     },
#     {
#       name        = "web-2"
#       external_ip = "89.169.152.47"
#       fqdn        = "web-2.ru-central1.internal"
#     }
#   ]
# }
# variable "databases" {
#   type = list(object({
#     name        = string
#     external_ip = string
#     fqdn        = string
#   }))
# 
#   default = [
#     {
#       name        = "main"
#       external_ip = "89.169.141.101"
#       fqdn        = "main.ru-central1.internal"
#     },
#     {
#       name        = "replica"
#       external_ip = "51.250.65.189"
#       fqdn        = "replica.ru-central1.internal"
#     }
#   ]
# }
# 
# variable "storage" {
#   type = object({
#     name        = string
#     external_ip = string
#     fqdn        = string
#   })
# 
#   default = {
#     name        = "storage"
#     external_ip = "51.250.14.170"
#     fqdn        = "storage.ru-central1.internal"
#   }
# }

#security_vars

variable "security_id" {
  default = "enpfjh55d01i8l6n9l0p"
}

#resource_vars
variable "cores" {
  description = "Number of cores per instance"
  default     = 2
}

variable "memory" {
  description = "Amount of memory per instance (in GB)"
  default     = 1
}

variable "core_fraction" {
  description = "Core fraction for the CPU"
  default     = 20
}

#boot-disk vars

variable "disk_type" {
  description = "Type of the boot disk"
  default     = "network-hdd"
}

variable "disk_size" {
  description = "Size of the boot disk (in GB)"
  default     = 5
}

#preemptible_true_var

variable "is_preemptible" {
  description = "Whether the instance is preemptible"
  default     = true
}
