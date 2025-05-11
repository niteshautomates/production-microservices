data "aws_ami" "ubuntu_ami_id" {

  most_recent = true
  owners      = ["099720109477"]


  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
  }


}

output "image_id" {
  value = data.aws_ami.ubuntu_ami_id.id
}