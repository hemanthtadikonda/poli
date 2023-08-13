resource "aws_instance" "instance" {

  ami                      = data.aws_ami.ami.id
  instance_type            = "t2.micro"
  vpc_security_group_ids  = ["sg-0baa986d8ebb5eeda"]

  tags = {
    Name = "chocolux-server"
  }
}

output "server_output" {
  value = aws_instance.instance
}

