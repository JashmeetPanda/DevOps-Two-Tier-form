provider "aws" {
  region = "ap-southeast-2"  # Replace with your AWS region
}

# Data source for existing EC2 instance
data "aws_instance" "frontend" {
  instance_id = "i-0d5900b1d8a43f0b5"  # Replace with your actual instance ID
}
