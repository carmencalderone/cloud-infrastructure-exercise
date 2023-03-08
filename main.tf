#Deploy of the AWS network 
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"
}
#Deploy of subnet into network create below 
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-south-1a"
}
#Deploy a virtual machine with 1 vCPU and 1 GB of RAM Memory
resource "aws_instance" "wordpress_instance" {
  ami= "ami-0b6321d6ee7c8ab67" # Amazon Linux 2 AMI on MILAN region 
  user_data = file("install_wordpress.sh") # startup bash script
  instance_type = "t2.micro"
  availability_zone = "eu-south-1a"
}