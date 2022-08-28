# Add subnets for eks
resource "aws_subnet" "eks-sub1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "EKSSubnet1"
  }
}

resource "aws_subnet" "eks-sub2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "EKSSubnet2"
  }
}