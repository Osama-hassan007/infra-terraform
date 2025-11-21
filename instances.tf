data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.nano"  # 1 vCPU, 0.5GB; if you need strictly 1GB use t3.micro
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  root_block_device {
    volume_size = 8
  }

  user_data = file("${path.module}/user-data-files/frontend_userdata.sh")

  tags = { Name = "frontend-ubuntu" }
}

resource "aws_instance" "backend" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"  # 1 vCPU 1GB
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  root_block_device {
    volume_size = 8
  }

  user_data = file("${path.module}/user-data-files/backend_userdata.sh")

  tags = { Name = "backend-ubuntu" }
}
