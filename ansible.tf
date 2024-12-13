resource "local_file" "ansible_inventory" {
  content = <<EOF
all:
  hosts:
    web-1:
      name: web-1
      ansible_host: 89.169.154.134
      fqdn: web-1.ru-central1.internal

    web-2:
      name: web-2
      ansible_host: 89.169.152.47
      fqdn: web-2.ru-central1.internal
  
    main:
      name: main
      ansible_host: 89.169.141.101
      fqdn: main.ru-central1.internal

    replica:
      name: replica
      ansible_host: 51.250.65.189
      fqdn: replica.ru-central1.internal

    storage:
      name: storage
      ansible_host: 51.250.14.170
      fqdn: storage.ru-central1.internal
EOF

  filename = "/etc/homewrk2/ter-homeworks/03/src/inventory.yml"
}
