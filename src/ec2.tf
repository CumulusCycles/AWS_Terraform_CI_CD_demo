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

resource "aws_security_group" "private_ec2" {
  name        = "private-ec2"
  description = "Egress-only security group for the private EC2 instance"
  vpc_id      = module.vpc-infra.cc_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "private-ec2"
    Project = "CC TF Demo"
  }
}

resource "aws_instance" "private" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.micro"
  subnet_id                   = module.vpc-infra.cc_private_subnets[0].id
  vpc_security_group_ids      = [aws_security_group.private_ec2.id]
  associate_public_ip_address = false

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = {
    Name    = "private-ec2"
    Project = "CC TF Demo"
  }
}

output "private_ec2_instance_id" {
  description = "ID of the EC2 instance in the first private subnet"
  value       = aws_instance.private.id
}
