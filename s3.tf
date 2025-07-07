import {
  to = aws_s3_bucket.resume
  id = "resume.nelmer.dev"
}
resource "aws_s3_bucket" "resume" {

  tags = {
    Name      = "resume.nelmer.dev"
    ManagedBy = "Terraform"
  }
}

import {
  to = aws_s3_bucket.root
  id = "nelmer.dev"
}
resource "aws_s3_bucket" "root" {

  tags = {
    Name      = "nelmer.dev"
    ManagedBy = "Terraform"
  }
}