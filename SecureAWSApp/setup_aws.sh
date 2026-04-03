#!/bin/bash
# Set variables (update with your values)
REGION="us-east-1"
VPC_ID="vpc-12345678"  # Replace with actual VPC ID from console
SUBNET_ID="subnet-12345678"  # Replace with actual subnet ID
SG_ID="sg-12345678"  # Replace with actual security group ID
KEY_NAME="intern"
AMI_ID="ami-0abcdef1234567890"  # Amazon Linux 2 AMI
# Launch EC2 instance
INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type t2.micro --key-name $KEY_NAME --security-group-ids $SG_ID --subnet-id $SUBNET_ID --query 'Instances[0].InstanceId' --output text)
echo "Launched EC2 instance: $INSTANCE_ID"
# Wait for instance to be running
aws ec2 wait instance-running --instance-ids $INSTANCE_ID
# Get public IP
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
echo "EC2 Public IP: $PUBLIC_IP"
# Create RDS instance (if not done manually)
# aws rds create-db-instance --db-instance-identifier webapp-db --db-instance-class db.t2.micro --engine mysql --master-username admin --master-user-password your-password --allocated-storage 20 --vpc-security-group-ids $SG_ID --db-subnet-group-name your-subnet-group
# Output for next steps
echo "Next: SSH into EC2 and run ec2_setup.sh"