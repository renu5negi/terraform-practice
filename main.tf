# key-pair (login to ec2 instance using ssh)

resource "aws_key_pair" "my_key_pair" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}

# vpc (virtual private cloud) & security group (firewall rules)

resource "aws_default_vpc" "default" {
  tags = {
    Name = "default-vpc"
  }
}

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = " this will add a TF generated security group to the default VPC"
  vpc_id      = aws_default_vpc.default.id # interpolation syntax to get the default vpc id

  # inbound rule to allow ssh access to the ec2 instance from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow ssh access from anywhere"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow http access from anywhere"
  }
  # outbound rule to allow all outbound traffic from the ec2 instance to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all outbound traffic to anywhere"
  }
}

# ec2 instance
resource "aws_instance" "my_ec2_instance" {
  ami             = var.ec2_ami # ubuntu ami in us-east-1 region
  instance_type   = var.ec2_instance_type
  key_name        = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.my_security_group.name]  # interpolation syntax to get the security group name


  root_block_device {
    volume_size = var.ec2_root_volume_size
    volume_type = "gp3"

  }

  tags = {
    Name = "terra-ec2-instance"
  }

}