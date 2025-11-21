resource "aws_vpc" "this" {
  cidr_block = "10.10.0.0/16"
  tags = { Name = "ecom-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = { Name = "ecom-public-subnet" }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = var.availability_zone
  map_public_ip_on_launch = false
  tags = { Name = "ecom-private-subnet" }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "ecom-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = { Name = "ecom-public-rt" }
}

resource "aws_route_table_association" "pub_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
