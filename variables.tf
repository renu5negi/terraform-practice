variable ec2_instance_type {
    default = "t3.micro"
    type = string
    description = "The instance type for the EC2 instance"
}

variable ec2_ami {
    default = "ami-0ec10929233384c7f"
    type = string
    description = "The AMI ID for the EC2 instance (Ubuntu in us-east-1)"

}

variable ec2_root_volume_size {
     default = 8
     type = number
     description = "The size of the root volume for the EC2 instance in GB"
}

variable s3_bucket_name {
    default = "terraform-bucket-renu"
    type = string
    description = "The name of the S3 bucket to be created"
}

