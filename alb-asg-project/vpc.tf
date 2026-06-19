resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_config.vpc_cidr_block
  instance_tenancy = "default"


  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc"
  })

}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  count = 2

  vpc_id = aws_vpc.my_vpc.id

  cidr_block = cidrsubnet(var.vpc_config.vpc_cidr_block, 8, count.index)

  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-public-${count.index + 1}"
  })
}



resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-igw"
  })

}

resource "aws_route_table" "my_public_route" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_public_route"
  }
  route {
    cidr_block = var.vpc_config.igw_cidr_block
    gateway_id = aws_internet_gateway.my_igw.id


  }
}

resource "aws_route_table_association" "public_assoc" {
  count = 2

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.my_public_route.id
}

