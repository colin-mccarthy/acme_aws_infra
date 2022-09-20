

resource "aws_instance" "ubuntu_server" {
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t3.micro"
  key_name               = "terra"
  vpc_security_group_ids = [aws_security_group.ubuntu_servers.id]

  tags = {
    Name = "Ubuntu"
  }
}


variable "my_vpc" {
  type = string
}


module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"
  count   = 1


  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ubuntu_servers.id]
  key_name               = "terra"

  tags = {
    Name = "Ubuntu2"
  }
}








resource "aws_security_group" "ubuntu_servers" {
  name        = "ubuntu_servers"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.my_vpc

  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


output "instance_ip_addr2" {
  value = module.ec2_instances.public_dns
}
  
output "instance_ip_addr" {
  value = aws_instance.ubuntu_server.public_dns
}
