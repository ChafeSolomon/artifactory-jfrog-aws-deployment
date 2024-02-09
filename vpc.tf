# Create VPC
resource "aws_vpc" "artifactory-vpc" {
  cidr_block = "10.0.0.0/16" # You can change the CIDR block as needed

  tags = {
    Name = "artifactory-terraform-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.artifactory-vpc.id
  tags = {
    Name = "artifactory-terraform-igw"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.artifactory-vpc.id
  cidr_block        = "10.0.1.0/24" # Public subnet CIDR block
  tags = {
    Name = "artifactory-terraform-public-subnet"
  }
}

# Create Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.artifactory-vpc.id
  cidr_block        = "10.0.2.0/24" # Private subnet CIDR block
  tags = {
    Name = "artifactory-terraform-private-subnet"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet.id

  depends_on = [aws_internet_gateway.my_igw]
  tags = {
    Name = "artifactory-terraform-nat-gateway"
  }
}

# Create Elastic IP for OpenVPN
resource "aws_eip" "elastic_ip" {
  domain   = "vpc"
  tags = {
    Name = "artifactory-terraform-eip"
  }
}

# Create Primary RT for Public
resource "aws_route_table" "public"{
    vpc_id = aws_vpc.artifactory-vpc.id
    route {
        cidr_block                 = "0.0.0.0/0"
        gateway_id             = aws_internet_gateway.my_igw.id
    }
    tags = {
        Name = "artifactory-terraform-public-rt"
      }
}

# Create Secondary RT for Private
resource "aws_route_table" "private"{
    vpc_id = aws_vpc.artifactory-vpc.id
    route {
        cidr_block                 = "0.0.0.0/0"
        nat_gateway_id                 = aws_nat_gateway.nat_gateway.id
    }
    tags = {
        Name = "artifactory-terraform-private-rt"
      }
}