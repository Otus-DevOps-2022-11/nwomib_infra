resource "yandex_compute_instance" "db" {
  name = var.prod_app
  labels = {
    tags = "reddit-db"
  }

  resources {
    cores  = var.cpu
    memory = var.mem
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.app-subnet.id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}