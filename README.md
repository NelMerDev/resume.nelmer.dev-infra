# ☁️ Cloud Resume Challenge – Terraform Edition

[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Deployed-FF9900?logo=amazon-aws)](https://aws.amazon.com/)
[![Cloud Resume Challenge](https://img.shields.io/badge/Cloud%20Resume%20Challenge-Completed-34D058?style=flat)](https://cloudresumechallenge.dev/)
[![Website](https://img.shields.io/website?url=https%3A%2F%2Fresume.nelmer.dev)](https://resume.nelmer.dev)

This repository contains the **Infrastructure as Code (IaC)** implementation for deploying a production-style, serverless resume website using **Terraform** and **AWS**.

The project demonstrates practical experience designing modular Terraform configurations, implementing least-privilege IAM, and deploying a serverless stack (API Gateway + Lambda + DynamoDB) for a real production endpoint.


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

```plaintext
[ Cloudflare DNS + HTTPS ]
            |
[ S3 Static Website – resume.nelmer.dev ]
            |
[ JavaScript fetch() 
         -> API Gateway 
         -> Lambda 
         -> DynamoDB ]
```


## 🧠 Key Decisions

- Used `terraform-aws-modules` to follow common infrastructure patterns and keep code maintainable.
- Kept DNS/HTTPS in Cloudflare to match a real-world setup where edge/networking is managed outside AWS.


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
- Infrastructure changes are applied manually using Terraform from the `infra/` directory.
- Terraform state is intentionally excluded from version control.
- Terraform is executed from the `infra/` directory to keep infrastructure code isolated from application code.
- Remote Terraform state (S3 + DynamoDB lock) is planned as a future enhancement.


## ▶️ How to Deploy (Terraform)

```bash
cd infra
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```
> This deploys AWS infrastructure (S3, API Gateway, Lambda, DynamoDB, IAM). DNS/HTTPS is handled in Cloudflare.


## 📁 Project Structure

```plaintext
.
├── infra/
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── data.tf
│   └── lambda_functions/
│       ├── VisitorCounter/
│       │   └── lambda_function.py
│       └── CloudflareS3Policy/
│           └── lambda_function.py
├── .gitignore
├── .terraform.lock.hcl
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
- Use Terraform Cloud or S3 backend for remote state


## 🔐 Security & Deployment Practices

- Terraform state is not committed to this repository.
- Infrastructure is deployed using IAM roles with least-privilege permissions.
- No AWS credentials or secrets are stored in the codebase.
- Frontend deployments use GitHub Actions with encrypted secrets; this repo contains infrastructure code only.
- S3 access policies are dynamically managed based on Cloudflare IP ranges.
- Terraform provider versions are locked using `.terraform.lock.hcl` for reproducible deployments.

---

## 🌐 Live Deployment

🔗 [Live Resume](https://resume.nelmer.dev)