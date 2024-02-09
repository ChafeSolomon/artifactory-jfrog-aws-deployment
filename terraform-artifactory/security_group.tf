# Security Group Creation for Artifactory
resource "aws_security_group" "artifactory_sg" {
  name        = "artifactory_sg"
  description = "Artifactory Security Group"
  vpc_id      = aws_vpc.artifactory-vpc.id

  tags = {
    Name = "artifactory-terraform"
  }
}

# Security Group Creation for OpenVPN
resource "aws_security_group" "openvpn_artifactory_sg" {
  name        = "openvpn_artifactory_sg"
  description = "OpenVPN Artifactory Security Group"
  vpc_id      = aws_vpc.artifactory-vpc.id

  tags = {
    Name = "artifactory-terraform"
  }
}

# Ingress Rules for OpenVPN
resource "aws_security_group_rule" "openvpn_artifactory_sg" {
  for_each = var.openvpn_artifactory_ingress
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.openvpn_artifactory_sg.id
}

# Ingress Rules for Artifactory
resource "aws_security_group_rule" "artifactory_sg_ingress" {
  for_each = var.artifactory_ingress
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  security_group_id = aws_security_group.artifactory_sg.id
  source_security_group_id = aws_security_group.openvpn_artifactory_sg.id
}

# Egress Rules for Artifactory
resource "aws_security_group_rule" "artifactory_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.artifactory_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Egress Rules for OpenVPN
resource "aws_security_group_rule" "openvpn_artifactory_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.openvpn_artifactory_sg.id
}

