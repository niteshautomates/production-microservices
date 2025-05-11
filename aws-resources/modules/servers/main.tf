resource "aws_instance" "ubuntu" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "First-instance-by-terraform"

  }

  vpc_security_group_ids = [var.security_group_id]

  user_data = file("${path.module}/userData.sh")
}


