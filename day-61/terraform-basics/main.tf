# Terraform Block

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Provider Block

provider "aws" {

  region = "ap-south-1"

}

# Create S3 Bucket

resource "aws_s3_bucket" "my_bucket" {

  bucket = "terraweek-prashantmanjrekar-2026"

}

# Create EC2 Instance

resource "aws_instance" "my_instance" {
  ami           = "ami-045443a70fafb8bbc" # Available AMI used in Mumbai Region
  instance_type = "t3.micro"              # Available Instance Type used

  tags = {
    Name = "TerraWeek-Modified"
  }
}