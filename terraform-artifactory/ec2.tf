# Create Artifactory Instance
resource "aws_instance" "artifactory_instance" {
  ami                         = var.artifactory_ami
  instance_type               = "m7a.xlarge"
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.artifactory_sg.id]
  subnet_id                   = aws_subnet.private_subnet.id
  root_block_device {
    volume_size = var.artifactory_volume
    volume_type = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "artifactory-terraform"
  }
  key_name  = var.key_name
  user_data = file("${path.module}/bootstrap/bootstrap.sh")
}

# Create OpenVPN Instance
resource "aws_instance" "artifactory_openvpn" {
  ami                         = var.openvpn_ami
  instance_type               = "t3.medium"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.openvpn_artifactory_sg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  root_block_device {
    volume_size = 10
    volume_type = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name = "artifactory-terraform-ovpn",
  }
  key_name  = var.key_name
}


