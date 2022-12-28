provider "yandex" {
  token     = "y0_AgAAAAAAgQVtAATuwQAAAADXXBr0vNf3KidmTqWh9t_u9sz6ZRsocnA"
  cloud_id  = "b1g5togtnendvqppvoie"
  folder_id = "b1gv355u3l2dspkgvov0"
  zone      = "ru-central1-a"
}
resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  metadata = {
  ssh-keys = "ubuntu:${file("appuser.pub")}"
  }
  
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = "fd84gcfsk0v9p1ac4oh8"
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = "e9b9hmsht01le47daoe3"
    nat       = true
  }
  
  connection {
	type = "ssh"
	host = yandex_compute_instance.app.network_interface.0.nat_ip_address
	user = "ubuntu"
	agent = false
	# путь до приватного ключа
    private_key = "${file("priv")}"
  }
  
  provisioner "file" {
    source = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}