resource "aws_security_group" "security-group-tf" {
  name        = "Allow SSH"
  description = "Security group created by terraform"
  dynamic "ingress" {
    for_each = [22, 80, 443, 3306, 27017, 300, 8080, 8081, 8082, 8083, 8761]
    iterator = port
    content {
      description = "Allow from VPC"
      from_port   = port.value
      to_port     = port.value
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "security-group-id" {
  value = aws_security_group.security-group-tf.id

}