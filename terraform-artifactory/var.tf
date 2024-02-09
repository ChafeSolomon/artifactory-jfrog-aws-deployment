variable "artifactory_ami" {
  type    = string
  default = "ami-0277155c3f0ab2930"
}

variable "openvpn_ami" {
  type    = string
  default = "ami-04ed6d5795186e8e1"
}

variable "artifactory_volume" {
  type = number
  default = 10
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "artifactory_ingress" {
  type = map(string)
  default = {
    "port1" = "80"
    "port2" = "443"
    "port3" = "8081"
    "port4" = "8082"
    "port5" = "22"
  }
}

variable "openvpn_artifactory_ingress" {
  type = map(string)
  default = {
    "port1" = "22"
    "port2" = "1194"
    "port3" = "943"
    "port4" = "443"
  }
}

variable "key_name"{
  type = string
  default = "openvpn-artifactory"
}