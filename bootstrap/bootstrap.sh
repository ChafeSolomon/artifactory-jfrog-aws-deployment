#!/bin/bash
wget https://releases.jfrog.io/artifactory/artifactory-rpms/artifactory-rpms.repo -O jfrog-artifactory-rpms.repo
sudo mv jfrog-artifactory-rpms.repo /etc/yum.repos.d/
sudo yum update -y && sudo yum install jfrog-artifactory-oss -y
sudo systemctl enable artifactory --now