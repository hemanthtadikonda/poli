resource "aws_instance" "instance" {

  ami                 = data.aws_ami.ami.id
  instance_tpe        = "t2.micro"
  vpc_security_groups = ["sg-0baa986d8ebb5eeda"]

  tags = {
    Name = "chocolux-server"
  }
}

output "server_output" {
  value = aws_instance.instance
}

