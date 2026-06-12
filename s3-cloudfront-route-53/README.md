##  Architecture Diagram

This project demonstrates a production-style static website hosting architecture on AWS, fully provisioned using Terraform.

![Architecture Diagram](Terraform_Projects/s3-cloudfront-route-53/architecture-diagram.png)

### Architecture Overview

1. Users access the website through a custom domain name.
2. Amazon Route 53 provides DNS resolution and routes traffic to CloudFront.
3. Amazon CloudFront serves content globally with low latency and improved performance.
4. AWS Certificate Manager (ACM) provides SSL/TLS certificates for secure HTTPS communication.
5. CloudFront securely retrieves website assets from Amazon S3 using Origin Access Control (OAC), preventing direct public access to the bucket.
6. Amazon S3 stores the static website files such as HTML, CSS, JavaScript, and images.
7. Terraform automates the provisioning and management of all AWS resources, ensuring Infrastructure as Code (IaC) best practices.

### AWS Services Used

- Amazon S3
- Amazon CloudFront
- Amazon Route 53
- AWS Certificate Manager (ACM)
- Terraform

### Key Features

- Secure HTTPS access using ACM certificates
- Global content delivery through CloudFront
- Private S3 bucket access using OAC
- Custom domain integration with Route 53
- Fully automated infrastructure deployment using Terraform
