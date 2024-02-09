output "artifactory_instance_arn" {
  value = aws_instance.artifactory_instance.arn
}
output "artifactory_instance_ebs" {
  value = aws_instance.artifactory_instance.root_block_device.0.volume_id
}
output "openvpn_instance_ip" {
  value = aws_instance.artifactory_openvpn.public_ip
}