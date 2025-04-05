output "jenkins_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}

output "access_jenkins_url" {
  value = "http://${aws_instance.jenkins_instance.public_ip}:8080"
}