provider "yandex" {
  token     = "y0_AgAAAAAAgQVtAATuwQAAAADaeH6nwJSQwXOARVSYLkzjXwqgLeG34jY"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = var.subnet_id
  prof            = "prod"
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = var.subnet_id
  prof            = "prod"
}
