data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

module "private_ec2" {
  source = "./modules/ec2"

  ami_id        = data.aws_ami.amazon_linux_2023.id
  vpc_id        = module.vpc-infra.cc_vpc_id
  subnet_id     = module.vpc-infra.cc_private_subnets[0].id
  instance_type = "t3.micro"
  name          = "private-ec2"
  project       = "CC TF Demo"
}

output "private_ec2_instance_id" {
  description = "ID of the EC2 instance in the first private subnet"
  value       = module.private_ec2.instance_id
}
