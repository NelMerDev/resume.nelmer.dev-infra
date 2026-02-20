terraform {
  backend "s3" {
    bucket         = "terraform-state.nelmer.dev"
    key            = "resume-nelmer-dev-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}