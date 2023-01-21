provider "yandex" {
  token     = "y0_AgAAAAAAgQVtAATuwQAAAADXXBr0vNf3KidmTqWh9t_u9sz6ZRsocnA"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}
resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  zone = var.zone
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.image_id
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = yandex_vpc_subnet.app-subnet.id
    nat       = true
  }

  connection {
    type  = "ssh"
    host  = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file("${var.private_key}")
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}
	resource "yandex_vpc_network" "app-network" {
	  name = "reddit-app-network"
	}

	resource "yandex_vpc_subnet" "app-subnet" {
	  name           = "reddit-app-subnet"
	  zone           = "ru-central1-a"
	  network_id     = "${yandex_vpc_network.app-network.id}"
	  v4_cidr_blocks = ["192.168.10.0/24"]
	}