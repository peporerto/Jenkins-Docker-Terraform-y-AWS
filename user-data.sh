#!/bin/bash
yum update -y
yum install -y docker git
systemctl start docker
systemctl enable docker

# Jenkins
amazon-linux-extras install java-openjdk11 -y
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade
yum install -y jenkins
systemctl enable jenkins
systemctl start jenkins