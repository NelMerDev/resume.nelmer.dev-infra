# ☁️ Cloud Resume Challenge – Terraform Edition

[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Deployed-FF9900?logo=amazon-aws)](https://aws.amazon.com/)
[![CI/CD](https://github.com/RomeoNotaLoka/resume.nelmer.dev/actions/workflows/deploy.yml/badge.svg)](https://github.com/RomeoNotaLoka/resume.nelmer.dev/actions)
[![Cloud Resume Challenge](https://img.shields.io/badge/Cloud%20Resume%20Challenge-Completed-34D058?style=flat)](https://cloudresumechallenge.dev/)
[![Website](https://img.shields.io/website?url=https%3A%2F%2Fresume.nelmer.dev)](https://resume.nelmer.dev)

This repository contains the complete **Infrastructure as Code (IaC)** setup using **Terraform** to deploy a production-grade, serverless resume website as part of the [Cloud Resume Challenge](https://cloudresumechallenge.dev/). This project demonstrates my hands-on experience with AWS services, Terraform modules, serverless architecture, CI/CD pipelines, and security best practices.

---

## 🚀 What This Project Deploys

| Component         | Description                                                                 |
|------------------|-----------------------------------------------------------------------------|
| **S3**           | Static website hosting for `resume.nelmer.dev` using public-read config     |
| **Cloudflare**   | Manages domain DNS and provides HTTPS (SSL)                                 |
| **Lambda**       | Updates and returns visitor count via API                                   |
| **API Gateway**  | HTTP endpoint that triggers the Lambda function                             |
| **DynamoDB**     | NoSQL database to store visitor count                                        |
| **IAM**          | Least-privilege policies for Lambda, API, and DynamoDB                      |
| **Terraform**    | Uses official `terraform-aws-modules` for clean, scalable IaC               |
| **GitHub Actions** | Automatically deploys resume updates to S3 on each commit to `main`       |


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


## 🛠️ Technologies Used

- **Terraform** – Infrastructure as Code
- **AWS S3** – Static resume hosting
- **Cloudflare** – DNS + HTTPS
- **AWS Lambda** – Serverless function for visitor counter
- **API Gateway** – Lightweight HTTP endpoint
- **DynamoDB** – NoSQL data storage
- **IAM** – Role-based access control
- **GitHub Actions** – CI/CD for S3 deployment


## ⚙️ GitHub Actions CI/CD

This repo includes a GitHub Actions workflow that **automatically uploads your static resume site to S3** every time you commit to the `main` branch. This keeps your resume live and up to date without manual deployment.

> CI/CD Workflow File: `.github/workflows/deploy.yml`


## 📁 Project Structure

```plaintext
.
├── main.tf                 # Root Terraform configuration
├── variables.tf            # Input variables
├── outputs.tf              # Outputs for Lambda/API Gateway/S3
├── lambda_functions/
│   └── VisitorCounter/     # JS Lambda source code for visitor counter
├── .github/
│   └── workflows/
│       └── deploy.yml      # GitHub Actions for CI/CD to S3
└── README.md               # You're here
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


## 🙋‍♂️ About Me

Hi, I'm **Nelson Mercedes** — a self-motivated Cloud Engineer passionate about automation, DevOps, and clean infrastructure design. This project is part of my portfolio to demonstrate real-world cloud engineering skills.

I'm currently focusing on:
- Building scalable, production-ready AWS infrastructure using Terraform and modular design patterns
- Automating cloud deployments with CI/CD pipelines using GitHub Actions and GitOps principles
- Developing serverless applications using AWS Lambda, API Gateway, and DynamoDB

Feel free to connect or check out my live resume:

🔗 [Live Resume](https://resume.nelmer.dev)  
📧 [Contact Me](mailto:contact@nelmer.dev)
