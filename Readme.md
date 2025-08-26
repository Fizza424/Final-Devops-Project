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

Alaso attaching console output of pipeline:
Started by user Fizza Naseer

Obtained Jenkinsfile from git https://github.com/Fizza424/Final-Devops-Project.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins
 in C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential fizzanaseer424@gmail.com
 > C:\Program Files\Git\cmd\git.exe rev-parse --resolve-git-dir C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2\.git # timeout=10
Fetching changes from the remote Git repository
 > C:\Program Files\Git\cmd\git.exe config remote.origin.url https://github.com/Fizza424/Final-Devops-Project.git # timeout=10
Fetching upstream changes from https://github.com/Fizza424/Final-Devops-Project.git
 > C:\Program Files\Git\cmd\git.exe --version # timeout=10
 > git --version # 'git version 2.49.0.windows.1'
using GIT_ASKPASS to set credentials 
 > C:\Program Files\Git\cmd\git.exe fetch --tags --force --progress -- https://github.com/Fizza424/Final-Devops-Project.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > C:\Program Files\Git\cmd\git.exe rev-parse "refs/remotes/origin/main^{commit}" # timeout=10
Checking out Revision 6ae5b9755a377effa13745e60e35133d54dc3c5f (refs/remotes/origin/main)
 > C:\Program Files\Git\cmd\git.exe config core.sparsecheckout # timeout=10
 > C:\Program Files\Git\cmd\git.exe checkout -f 6ae5b9755a377effa13745e60e35133d54dc3c5f # timeout=10
Commit message: "Update Jenkinsfile"
 > C:\Program Files\Git\cmd\git.exe rev-list --no-walk 932e35689624845c427943bbee7dcc970bedf48d # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
 > C:\Program Files\Git\cmd\git.exe rev-parse --resolve-git-dir C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2\.git # timeout=10
Fetching changes from the remote Git repository
 > C:\Program Files\Git\cmd\git.exe config remote.origin.url https://github.com/Fizza424/Final-Devops-Project.git # timeout=10
Fetching upstream changes from https://github.com/Fizza424/Final-Devops-Project.git
 > C:\Program Files\Git\cmd\git.exe --version # timeout=10
 > git --version # 'git version 2.49.0.windows.1'
 > C:\Program Files\Git\cmd\git.exe fetch --tags --force --progress -- https://github.com/Fizza424/Final-Devops-Project.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > C:\Program Files\Git\cmd\git.exe rev-parse "refs/remotes/origin/main^{commit}" # timeout=10
Checking out Revision 6ae5b9755a377effa13745e60e35133d54dc3c5f (refs/remotes/origin/main)
 > C:\Program Files\Git\cmd\git.exe config core.sparsecheckout # timeout=10
 > C:\Program Files\Git\cmd\git.exe checkout -f 6ae5b9755a377effa13745e60e35133d54dc3c5f # timeout=10
 > C:\Program Files\Git\cmd\git.exe branch -a -v --no-abbrev # timeout=10
 > C:\Program Files\Git\cmd\git.exe branch -D main # timeout=10
 > C:\Program Files\Git\cmd\git.exe checkout -b main 6ae5b9755a377effa13745e60e35133d54dc3c5f # timeout=10
Commit message: "Update Jenkinsfile"
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build Docker image)
[Pipeline] bat

C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2>docker build -t fizza424/final-project:latest . 
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 475B 0.0s done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/node:18-alpine
#2 DONE 0.2s

#3 [internal] load .dockerignore
#3 transferring context: 2B 0.0s done
#3 DONE 0.1s

#4 [internal] load build context
#4 transferring context: 55.07kB 0.2s done
#4 DONE 0.3s

#5 [1/5] FROM docker.io/library/node:18-alpine@sha256:8d6421d663b4c28fd3ebc498332f249011d118945588d0a35cb9bc4b8ca09d9e
#5 resolve docker.io/library/node:18-alpine@sha256:8d6421d663b4c28fd3ebc498332f249011d118945588d0a35cb9bc4b8ca09d9e 0.2s done
#5 DONE 0.2s

#6 [3/5] COPY package*.json ./
#6 CACHED

#7 [2/5] WORKDIR /usr/src/app
#7 CACHED

#8 [4/5] RUN npm install --omit=dev
#8 CACHED

#9 [5/5] COPY . .
#9 DONE 0.4s

#10 exporting to image
#10 exporting layers
#10 exporting layers 0.2s done
#10 exporting manifest sha256:abfd23fe5d9df18f62a7596f4ac3ce81d2b3db587961db6bd54f01848190ce7a 0.0s done
#10 exporting config sha256:f9a1e110d5163ffd587658b042a21b4c39d555720a8a65b8d17fc958c472c08d 0.0s done
#10 exporting attestation manifest sha256:24e66d699135cc9c985eb526f72be1f219e88ce4c25bc76014e86e540b712ec8
#10 exporting attestation manifest sha256:24e66d699135cc9c985eb526f72be1f219e88ce4c25bc76014e86e540b712ec8 0.1s done
#10 exporting manifest list sha256:6ed29984a8a0df4f89d510fab0f092a9c21ad0e4b03cf9485c79685c30dca1f5 0.0s done
#10 naming to docker.io/fizza424/final-project:latest
#10 naming to docker.io/fizza424/final-project:latest done
#10 unpacking to docker.io/fizza424/final-project:latest
#10 unpacking to docker.io/fizza424/final-project:latest 0.3s done
#10 DONE 0.9s
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Push to Docker Hub)
[Pipeline] withCredentials
Masking supported pattern matches of %DOCKER_PASS%
[Pipeline] {
[Pipeline] bat

C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2>echo ****   | docker login -u Dockerhub-credentials --password-stdin 
Error response from daemon: Get "https://registry-1.docker.io/v2/": unauthorized: incorrect username or password

C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2>docker push fizza424/final-project:latest 
The push refers to repository [docker.io/fizza424/final-project]
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
06417f3f59ca: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
d5862619d849: Waiting
dd71dde834b5: Waiting
1e5a4c89cee5: Layer already exists
71c4fead23f2: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
dd71dde834b5: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
71c4fead23f2: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
dd71dde834b5: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
dd71dde834b5: Waiting
71c4fead23f2: Layer already exists
3279937d806f: Waiting
f18232174bc9: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
dd71dde834b5: Waiting
dd71dde834b5: Layer already exists
3279937d806f: Waiting
f18232174bc9: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
25ff2da83641: Waiting
bb3014ad8ebb: Waiting
3279937d806f: Waiting
f18232174bc9: Waiting
3279937d806f: Layer already exists
f18232174bc9: Layer already exists
25ff2da83641: Layer already exists
bb3014ad8ebb: Layer already exists
06417f3f59ca: Pushed
d5862619d849: Pushed
latest: digest: sha256:6ed29984a8a0df4f89d510fab0f092a9c21ad0e4b03cf9485c79685c30dca1f5 size: 856
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Deploy to EC2)
[Pipeline] bat

C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2>scp -i "C:/Users/HP/Downloads/fizza-ec2-key.pem" docker-compose.yml ec2-user@65.2.78.12:/home/ec2-user/ 

C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2>ssh -i "C:/Users/HP/Downloads/fizza-ec2-key.pem" ec2-user@65.2.78.12 "docker pull fizza424/final-project:latest && docker-compose -f docker-compose.yml up -d" 
latest: Pulling from fizza424/final-project
f18232174bc9: Already exists
dd71dde834b5: Already exists
1e5a4c89cee5: Already exists
25ff2da83641: Already exists
71c4fead23f2: Already exists
bb3014ad8ebb: Already exists
3279937d806f: Already exists
d5862619d849: Pulling fs layer
d5862619d849: Verifying Checksum
d5862619d849: Download complete
d5862619d849: Pull complete
Digest: sha256:6ed29984a8a0df4f89d510fab0f092a9c21ad0e4b03cf9485c79685c30dca1f5
Status: Downloaded newer image for fizza424/final-project:latest
docker.io/fizza424/final-project:latest
time="2025-08-26T20:28:04Z" level=warning msg="/home/ec2-user/docker-compose.yml: `version` is obsolete"
 Container final_project_app  Recreate
 Container final_project_app  Recreated
 Container final_project_app  Starting
 Container final_project_app  Started
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Backup logs to S3)
[Pipeline] withCredentials
Masking supported pattern matches of %AWS_SECRET_ACCESS_KEY%
[Pipeline] {
[Pipeline] bat

C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2>set AWS_REGION=ap-south-1 

C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2>set AWS_ACCESS_KEY_ID=AKIAX3Q2J55K63RIRA5P 

C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2>set AWS_SECRET_ACCESS_KEY=**** 

C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2>aws s3 cp "C:/ProgramData/Jenkins/.jenkins/logs/" s3://fizza-devops-log/ --recursive --region ap-south-1 
Completed 1.1 KiB/9.6 KiB (249 Bytes/s) with 15 file(s) remaining
upload: ..\..\logs\tasks\Workspace clean-up.log.1 to s3://fizza-devops-log/tasks/Workspace clean-up.log.1
Completed 1.1 KiB/9.6 KiB (249 Bytes/s) with 14 file(s) remaining
Completed 1.3 KiB/9.6 KiB (288 Bytes/s) with 14 file(s) remaining
upload: ..\..\logs\tasks\Fingerprint cleanup.log to s3://fizza-devops-log/tasks/Fingerprint cleanup.log
Completed 1.3 KiB/9.6 KiB (288 Bytes/s) with 13 file(s) remaining
Completed 2.0 KiB/9.6 KiB (414 Bytes/s) with 13 file(s) remaining
upload: ..\..\logs\tasks\Workspace clean-up.log.3 to s3://fizza-devops-log/tasks/Workspace clean-up.log.3
Completed 2.0 KiB/9.6 KiB (414 Bytes/s) with 12 file(s) remaining
Completed 3.9 KiB/9.6 KiB (786 Bytes/s) with 12 file(s) remaining
upload: ..\..\logs\jenkins.branch.MultiBranchProject.log to s3://fizza-devops-log/jenkins.branch.MultiBranchProject.log
Completed 3.9 KiB/9.6 KiB (786 Bytes/s) with 11 file(s) remaining
Completed 4.5 KiB/9.6 KiB (903 Bytes/s) with 11 file(s) remaining
upload: ..\..\logs\tasks\Workspace clean-up.log.4 to s3://fizza-devops-log/tasks/Workspace clean-up.log.4
Completed 4.5 KiB/9.6 KiB (903 Bytes/s) with 10 file(s) remaining
Completed 4.9 KiB/9.6 KiB (949 Bytes/s) with 10 file(s) remaining
upload: ..\..\logs\tasks\Workspace clean-up.log.5 to s3://fizza-devops-log/tasks/Workspace clean-up.log.5
Completed 4.9 KiB/9.6 KiB (949 Bytes/s) with 9 file(s) remaining
Completed 5.0 KiB/9.6 KiB (952 Bytes/s) with 9 file(s) remaining
upload: ..\..\logs\tasks\Fingerprint cleanup.log.3 to s3://fizza-devops-log/tasks/Fingerprint cleanup.log.3
Completed 5.0 KiB/9.6 KiB (952 Bytes/s) with 8 file(s) remaining
Completed 5.5 KiB/9.6 KiB (1.0 KiB/s) with 8 file(s) remaining  
upload: ..\..\logs\health-checker.log to s3://fizza-devops-log/health-checker.log
Completed 5.5 KiB/9.6 KiB (1.0 KiB/s) with 7 file(s) remaining
Completed 6.1 KiB/9.6 KiB (1.1 KiB/s) with 7 file(s) remaining
upload: ..\..\logs\tasks\Workspace clean-up.log.2 to s3://fizza-devops-log/tasks/Workspace clean-up.log.2
Completed 6.1 KiB/9.6 KiB (1.1 KiB/s) with 6 file(s) remaining
Completed 6.2 KiB/9.6 KiB (1.1 KiB/s) with 6 file(s) remaining
Completed 6.4 KiB/9.6 KiB (1.1 KiB/s) with 6 file(s) remaining
Completed 6.5 KiB/9.6 KiB (1.1 KiB/s) with 6 file(s) remaining
Completed 7.6 KiB/9.6 KiB (1.3 KiB/s) with 6 file(s) remaining
Completed 9.5 KiB/9.6 KiB (1.7 KiB/s) with 6 file(s) remaining
upload: ..\..\logs\jenkins.branch.OrganizationFolder.log to s3://fizza-devops-log/jenkins.branch.OrganizationFolder.log
Completed 9.5 KiB/9.6 KiB (1.7 KiB/s) with 5 file(s) remaining
upload: ..\..\logs\tasks\Fingerprint cleanup.log.1 to s3://fizza-devops-log/tasks/Fingerprint cleanup.log.1
Completed 9.5 KiB/9.6 KiB (1.7 KiB/s) with 4 file(s) remaining
upload: ..\..\logs\tasks\Fingerprint cleanup.log.4 to s3://fizza-devops-log/tasks/Fingerprint cleanup.log.4
Completed 9.5 KiB/9.6 KiB (1.7 KiB/s) with 3 file(s) remaining
upload: ..\..\logs\tasks\Workspace clean-up.log to s3://fizza-devops-log/tasks/Workspace clean-up.log
Completed 9.5 KiB/9.6 KiB (1.7 KiB/s) with 2 file(s) remaining
upload: ..\..\logs\tasks\Fingerprint cleanup.log.5 to s3://fizza-devops-log/tasks/Fingerprint cleanup.log.5
Completed 9.5 KiB/9.6 KiB (1.7 KiB/s) with 1 file(s) remaining
Completed 9.6 KiB/9.6 KiB (1.7 KiB/s) with 1 file(s) remaining
upload: ..\..\logs\tasks\Fingerprint cleanup.log.2 to s3://fizza-devops-log/tasks/Fingerprint cleanup.log.2
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] echo
✅ Pipeline completed successfully!
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS


