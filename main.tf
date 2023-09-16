# configured aws provider and backend with proper credentials
provider "aws" {
  region = "us-west-1"
  assume_role {
    role_arn     = "arn:aws:iam::640111764884:role/stsassume-role"
    session_name = "terraform-sts"
  }
}
terraform {
  backend "s3" {
    bucket         = "rs-terraform-statefile01"
    key            = "terraform-statefile"
    region         = "us-west-1"
    role_arn       = "arn:aws:iam::640111764884:role/stsassume-role"
    dynamodb_table = "rs-terraform-statetable"
  }
}
# Define the AWS instance
resource "aws_instance" "this" {
  ami           = "ami-073e64e4c237c08ad" # us-west-1
  instance_type = "t2.micro"
  key_name               = "awskeypair"
  tags = {
    Name = "Terraform-Instance"
  }
}