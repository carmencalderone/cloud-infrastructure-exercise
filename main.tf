#deploy of the network AWS
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"
  region="eu-south-1"
}
#deploy of subnet into network create below 
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-south-1a"
}

resource "aws_network_interface" "my_networkinterface" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.100"]
}

  #deploy a virtual machine with 1 vCPU and 1,0 gb of RAM 
resource "aws_instance" "wordpress_instance" {
  ami= "ami-0b6321d6ee7c8ab67" # amazon linux AMI on MILAN region 
  user_data = file("startup.sh")
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.my_networkinterface.id
  }
}

