# Infrastructure Notes – resume.nelmer.dev

This document contains architectural decisions, removed components, and design notes
for the Terraform infrastructure repository.

---

## Removed Components

### VPC and Security Group Modules

Originally, this repository included:

- terraform-aws-modules/vpc/aws
- terraform-aws-modules/security-group/aws

These modules were removed because:

- All Lambda functions are running outside of a VPC
- No private networking resources are required
- API Gateway and DynamoDB do not require custom VPC configuration
- S3 static hosting does not require VPC configuration

Keeping unused networking modules adds unnecessary complexity and cost risk.

The infrastructure was simplified to follow the principle:

> Only provision what is required.

---

## Remote State

Terraform remote state is stored in:

- S3 bucket: terraform-state.nelmer.dev
- DynamoDB table: terraform-locks

Each Terraform project uses a unique state key to allow multiple
projects to share the same backend bucket safely.

---

## Repository Structure

Current structure:

- main.tf
- providers.tf
- backend.tf
- variables.tf
- outputs.tf
- data.tf
- lambda_functions/

All state files are excluded from version control.

---

## Design Principles

- Minimal infrastructure
- No unnecessary networking
- Serverless-first architecture
- Fully Infrastructure as Code
- Remote state with locking enabled