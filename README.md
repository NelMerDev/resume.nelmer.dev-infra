# ☁️ Cloud Resume Challenge – Terraform Edition

![Terraform CI](https://github.com/NelMerDev/resume.nelmer.dev-infra/actions/workflows/terraform.yml/badge.svg)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Deployed-FF9900?logo=amazon-aws)](https://aws.amazon.com/)
[![Cloud Resume Challenge](https://img.shields.io/badge/Cloud%20Resume%20Challenge-Completed-34D058?style=flat)](https://cloudresumechallenge.dev/)
[![Website](https://img.shields.io/website?url=https%3A%2F%2Fresume.nelmer.dev)](https://resume.nelmer.dev)

This repository contains the **Infrastructure as Code (IaC)** implementation for deploying a production-style, serverless resume website using **Terraform** and **AWS**.

The project demonstrates practical experience designing modular Terraform configurations, implementing least-privilege IAM, and deploying a production-style serverless architecture (API Gateway + Lambda + DynamoDB) supporting a live public endpoint.


## 🔗 Related Repository

- Frontend (static site + CI/CD): https://github.com/NelMerDev/resume.nelmer.dev

> Originally inspired by the [Cloud Resume Challenge](https://cloudresumechallenge.dev/).

---

## 🚀 What This Project Deploys

| Component        | Description                                                                 |
|------------------|-----------------------------------------------------------------------------|
| **S3**           | Static website hosting for `resume.nelmer.dev` (S3 Website endpoint)        |
| **Cloudflare**   | Manages domain DNS and provides HTTPS (SSL)                                 |
| **Lambda**       | Updates and returns visitor count via API                                   |
| **API Gateway**  | HTTP endpoint that triggers the Lambda function                             |
| **DynamoDB**     | NoSQL database to store visitor count                                       |
| **IAM**          | Least-privilege policies for Lambda, API, and DynamoDB                      |
| **Terraform**    | Uses official `terraform-aws-modules` for clean, scalable IaC               |
| **GitHub Actions** | Frontend repo deploys the static site to S3; this repo focuses on IaC     |


## 🧱 Architecture Diagram

```
[ User ]
   ↓
[ Cloudflare DNS + HTTPS ]
   ↓
[ S3 Static Website – resume.nelmer.dev ]
   ↓
[ JavaScript fetch()
        → API Gateway
        → Lambda
        → DynamoDB ]
```


## 🧠 Key Decisions

- Used `terraform-aws-modules` to follow common infrastructure patterns and keep code maintainable.
- Kept DNS/HTTPS in Cloudflare to match a real-world setup where edge/networking is managed outside AWS.
- Remote state is managed in S3 with DynamoDB locking for production-style Terraform workflows.
- Removed unused VPC and security group modules to maintain a minimal, fully serverless, cost-efficient architecture.


## 🛠️ Technologies Used

- **Terraform** – Infrastructure as Code
- **AWS S3** – Static resume hosting
- **Cloudflare** – DNS + HTTPS
- **AWS Lambda** – Serverless function for visitor counter
- **API Gateway** – Lightweight HTTP endpoint
- **DynamoDB** – NoSQL data storage
- **IAM** – Role-based access control
- **GitHub Actions** – CI/CD for S3 deployment


## ⚙️ CI/CD & Deployment

- The frontend (static resume) is deployed automatically via GitHub Actions in the frontend repository.
- Infrastructure changes are applied manually via Terraform CLI after successful CI validation.
- Remote Terraform state is stored in:
  - S3 bucket: `terraform-state.nelmer.dev`
  - DynamoDB table: `terraform-locks`
- State locking is enabled to prevent concurrent modification.
- Terraform state is excluded from version control.
- This repository includes GitHub Actions CI to enforce:
  - `terraform fmt -check`
  - `terraform validate`
- All pull requests and pushes are validated automatically before infrastructure changes are applied.


## ▶️ How to Deploy (Terraform)

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```
> This deploys AWS infrastructure (S3, API Gateway, Lambda, DynamoDB, IAM). DNS/HTTPS is handled in Cloudflare.


## 🔒 Terraform Backend Configuration

This project uses **remote state with locking** for production safety.

- **Backend:** S3 (`terraform-state.nelmer.dev`)
- **State path:** `resume-nelmer-dev-infra/terraform.tfstate`
- **Locking:** DynamoDB table (`terraform-locks`)
- **Encryption:** Enabled

### Why this matters

This prevents:

- Accidental state corruption  
- Concurrent `terraform apply` conflicts  
- Local state drift  
- State file loss on local machines  

Using remote state + locking mirrors real-world production Terraform workflows.

## 📁 Project Structure

```
.
├── backend.tf
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── data.tf
├── lambda_functions/
│   ├── VisitorCounter/
│   │   └── lambda_function.py
│   └── CloudflareS3Policy/
│       └── lambda_function.py
├── docs/
│   └── notes.md
├── .github/
│   └── workflows/
│       └── terraform.yml
├── .terraform.lock.hcl
├── .gitignore
└── README.md
```


## 🧑‍💻 Skills Demonstrated

✅ Terraform module usage (`terraform-aws-modules/s3-bucket/aws`, etc.)  
✅ Serverless AWS stack (Lambda + API Gateway + DynamoDB)  
✅ Cloudflare HTTPS & DNS setup outside AWS  
✅ CI/CD with GitHub Actions  
✅ IAM role and policy design for secure access  
✅ Static hosting with S3  
✅ Production-ready Infrastructure as Code


## 🚧 Future Enhancements

- Add monitoring/alerts (CloudWatch Alarms, Lambda logging, etc.)  
- Switch to CloudFront + ACM for fully AWS-native HTTPS  
- Add unit tests for Lambda and deploy preview environments  
- Evaluate Terraform Cloud for remote execution workflows


## 🔐 Security & Deployment Practices

- Terraform state is not committed to this repository.
- Infrastructure is deployed using IAM roles with least-privilege permissions.
- No AWS credentials or secrets are stored in the codebase.
- Frontend deployments use GitHub Actions with OIDC (no long-lived AWS keys); this repo contains infrastructure code only.
- S3 access policies are dynamically managed based on Cloudflare IP ranges.
- Terraform provider versions are locked using `.terraform.lock.hcl` for reproducible deployments.
- Backend state is encrypted at rest and protected by DynamoDB state locking.


## 💰 Cost Awareness

This architecture is designed to operate within AWS Free Tier limits under normal traffic conditions.

---

## 🌐 Live Deployment

🔗 [Live Resume](https://resume.nelmer.dev)