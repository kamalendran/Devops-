terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get a default subnet
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Create EC2 instance
resource "aws_instance" "web_server" {

  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  subnet_id = data.aws_subnets.default.ids[0]

  tags = {
    Name = "Terraform-EC2"
  }
}
