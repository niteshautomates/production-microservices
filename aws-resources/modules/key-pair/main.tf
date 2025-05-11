resource "aws_key_pair" "aws-keypair-tf" {
  key_name   = var.key_name
  public_key = file("${path.module}/ssh_key.pub")

}


output "key-name" {
  value = aws_key_pair.aws-keypair-tf.key_name
}

output "public_key" {
  value = aws_key_pair.aws-keypair-tf.public_key
}