# ☁️ Cloud Resume Challenge – Terraform Edition

[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Deployed-FF9900?logo=amazon-aws)](https://aws.amazon.com/)
[![CI/CD](https://github.com/nelson/resume-infra/actions/workflows/deploy.yml/badge.svg)](https://github.com/nelson/resume-infra/actions)
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

---

## 🧱 Architecture Diagram

```plaintext
[ Cloudflare DNS + HTTPS ]
            |
    [ S3 Static Website – resume.nelmer.dev ]
            |
  [ JavaScript fetch() -> API Gateway -> Lambda -> DynamoDB ]