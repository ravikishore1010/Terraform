resource "aws_vpc" "main" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = merge(var.tags,{
    
     Name = "VPC"})
}


resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet

  tags =  merge(var.tags,{
    
    Name = "public_subnet"})
}


resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet

  tags =  merge(var.tags,{
    
    Name = "private_subnet"})
}


resource "aws_internet_gateway" "automate-igw" {
  vpc_id = aws_vpc.main.id

  tags =  merge(var.tags,{
    
    Name = "igw"})
}  




resource "aws_route_table" "public-aut-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.cidr-block-1
    gateway_id = aws_internet_gateway.automate-igw.id
  }
tags =  merge(var.tags,{
    
    Name = "public_rt"})
}

resource "aws_route_table" "private-aut-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.cidr-block-2
    gateway_id = aws_nat_gateway.auto-nat.id
  }
tags =  merge(var.tags,{
    
    Name = "private_rt"})

}
resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public-aut-rt.id}"
}

resource "aws_route_table_association" "private" {
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private-aut-rt.id}"

}



resource "aws_eip" "auto-eip" {
tags =  merge(var.tags,{
    
    Name = "eip"})
}



resource "aws_nat_gateway" "auto-nat" {
  allocation_id = aws_eip.auto-eip.id
  subnet_id     = aws_subnet.public.id

  tags =  merge(var.tags,{
    
    Name = "nat"})

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.automate-igw]
}