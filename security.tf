# create key pair if provided
resource "aws_key_pair" "this" {
  count = length(var.ssh_public_key) > 0 ? 1 : 0
  key_name   = var.key_pair_name
  public_key = var.ssh_public_key
}

# Security group for EC2 (allow SSH and HTTP/other)
resource "aws_security_group" "ec2_sg" {
  name   = "ecom-ec2-sg"
  vpc_id = aws_vpc.this.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "UptimeKuma default HTTP (3001) - optional"
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for RDS - only allow traffic from VPC / EC2 SG
resource "aws_security_group" "rds_sg" {
  name   = "ecom-rds-sg"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
    description     = "Allow MySQL from app servers"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
