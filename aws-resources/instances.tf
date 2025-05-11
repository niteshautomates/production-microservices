module "ubuntu" {
  source            = "./modules/servers"
  image_id          = module.data.image_id
  instance_type     = var.instance_type
  key               = module.key-pair.public_key
  key_name          = module.key-pair.key-name
  security_group_id = module.security-group.security-group-id

}


module "key-pair" {
  source   = "./modules/key-pair"
  key      = var.key
  key_name = var.key_name
}


module "security-group" {
  source = "./modules/security-groups"
}

module "data" {
  source = "./modules/datasources"
}