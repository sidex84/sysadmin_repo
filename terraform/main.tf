terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = var.zone
}

resource "yandex_compute_instance" "vm" {
  count = 3
  
  name        = "web-server-${count.index + 1}"
  hostname    = "web-server-${count.index + 1}"
  platform_id = "standard-v3"
  
  zone = var.zone
  
  resources {
    cores  = 2
    memory = 2
  }
  
  boot_disk {
    initialize_params {
      image_id = var.image_id
      type     = "network-hdd"
      size     = 10
    }
  }
  
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
  
  labels = {
    project = "yandex-praktikum"
  }
}

output "instances" {
  value = {
    for idx, instance in yandex_compute_instance.vm : 
    instance.name => {
      internal_ip = instance.network_interface.0.ip_address
      external_ip = instance.network_interface.0.nat_ip_address
    }
  }
}
