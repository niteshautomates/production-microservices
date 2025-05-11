output "key-content" {
  value = file("${path.module}/ssh_key.pub")
}