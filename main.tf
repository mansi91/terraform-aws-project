provider "aws" {
  region = "us-west-2"  # Change to your preferred region
}

# Data source to find the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  
  owners = ["099720109477"]  # Canonical
}

# Create an EC2 instance
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"    # Free tier eligible
  
  tags = {
    Name = "terraform-instance"
  }
}