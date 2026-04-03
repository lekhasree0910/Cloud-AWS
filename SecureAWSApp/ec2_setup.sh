#!/bin/bash
# Update system
sudo yum update -y
# Install Python and pip
sudo yum install python3 python3-pip -y

# Install Flask and MySQL connector
pip3 install flask mysql-connector-python

# Install Git (for cloning repo if needed)
sudo yum install git -y

# Clone or upload project files (assuming uploaded via SCP)
# Example: scp -i your-key.pem * ec2-user@$PUBLIC_IP:/home/ec2-user/

# Set environment variables for RDS (securely via AWS Systems Manager or IAM)
export RDS_HOST="your-rds-endpoint.rds.amazonaws.com"
export DB_USER="admin"
export DB_PASSWORD="your-password"