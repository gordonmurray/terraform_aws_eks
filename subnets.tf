resource "aws_subnet" "subnet-1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-west-1a"
  cidr_block              = "100.10.0.0/20"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_subnet" "subnet-1b" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-west-1b"
  cidr_block              = "100.10.16.0/20"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_subnet" "subnet-1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "eu-west-1c"
  cidr_block              = "100.10.32.0/20"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "terraform-eks"
  }
}