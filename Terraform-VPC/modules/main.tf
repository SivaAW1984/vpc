provider "aws" {
  region = local.region
}

locals {
   region = "us-east-1"
}

resource "aws_vpc_ipam" "test" {
  operating_regions {
    region_name = local.region
  }
}

resource "aws_vpc_ipam_pool" "this" {
  description                       = "IPv4 pool"
  address_family                    = "ipv4"
  ipam_scope_id                     = aws_vpc_ipam.this.private_default_scope_id
  locale                            = local.region
  allocation_default_netmask_length = 28

  tags = local.tags
}

resource "aws_vpc_ipam_pool_cidr" "this" {
  ipam_pool_id = aws_vpc_ipam_pool.this.id
  cidr         = "10.0.0.0/8"
}

resource "aws_vpc_ipam_preview_next_cidr" "this" {
  ipam_pool_id = aws_vpc_ipam_pool.this.id

  depends_on = [
    aws_vpc_ipam_pool_cidr.this
  ]
}

resource "aws_vpc" "vpc" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.this.id
  ipv4_netmask_length = 28
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}
