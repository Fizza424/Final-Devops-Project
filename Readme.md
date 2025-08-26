DevOps Demo: Node.js → Docker → Jenkins (Windows) → EC2 → S3

This repository powers a live demonstration pipeline that showcases modern DevOps practices through the following steps:

Docker Build
A Docker image is built on Jenkins running on Windows (using Docker Desktop, with Linux containers enabled).

Push to Docker Hub
The built image is pushed to Docker Hub for distributed access and deployment.

Deploy via SSH
The image is pulled and the container is launched on an Amazon EC2 instance (Amazon Linux), accessible on port 80 for testing.

Log Backups to S3
Container logs are backed up automatically to an Amazon S3 bucket for persistence and auditing.

Prerequisites

You’ll need:

Docker Hub
A Docker Hub account (public repository recommended for simplicity).

AWS Infrastructure

An EC2 key pair (.pem) for SSH access.

A Security Group allowing traffic on ports 22 (SSH) and 80 (HTTP).

An S3 bucket for storing logs.

EC2 instance (e.g., Amazon Linux 2023, t2.micro should work fine).

IAM Role attached to the EC2 instance with permissions to write to S3. 
GitHub

Jenkins on Windows
Setup with the following plugins and tools:

Git

Pipeline

Credentials Binding

OpenSSH client

Docker Desktop (configured for Linux containers) 
GitHub

Jenkins Configuration & Job Parameters

Before running your pipeline, create the following credentials in Jenkins:

dockerhub-creds – for your Docker Hub username and password

ec2-key – your EC2 .pem key as a “Secret file” 
GitHub

Within the Jenkins job, configure these environment parameters as needed per environment:

DOCKERHUB_REPO (e.g., your-dockerhub-username/docker-devops-demo)

EC2_HOST (e.g., ec2-3-120-...compute.amazonaws.com)

S3_BUCKET (e.g., fizza-devops-logs)

AWS_REGION (e.g., ap-south-1)

Additional parameters as required for your environment
