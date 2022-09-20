

variable "my_vpc" {
  type = string
}


module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"
  count   = 1


  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [module.sg.security_group_id]
  key_name               = "terra"

  tags = {
    Name = "Ubuntu2"
  }
}








module "sg" {
  source = "terraform-aws-modules/security-group/aws"
  
  name        = "ubuntu_servers"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.my_vpc

  egress_with_cidr_blocks = [
    {
      cidr_blocks      = "0.0.0.0/0"
      description      = ""
      from_port        = 0
      protocol         = "-1"
      self             = false
      to_port          = 0
    }
  ]
  
  ingress_with_cidr_blocks = [
   {
     cidr_blocks      = "0.0.0.0/0"
     description      = ""
     from_port        = 22
     protocol         = "tcp"
     self             = false
     to_port          = 22
  }
  ]
}


output "instance_ip_addr" {
  value = module.ec2_instances[*].public_ip
}
  
output "instance_public_dns" {
  value = module.ec2_instances[*].public_dns
}
