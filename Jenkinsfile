pipeline {
  agent any

  parameters {
    string(name: 'DOCKERHUB_REPO', defaultValue: 'fizza424/dockerhub_repo', description: 'Docker Hub repo (username/repo)')
    string(name: 'APP_NAME',       defaultValue: 'devops-demo', description: 'EC2 container + log folder name')
    string(name: 'EC2_HOST',       defaultValue: 'ec2-13-235-78-253.ap-south-1.compute.amazonaws.com', description: 'EC2 Public DNS or IP')
    string(name: 'EC2_USER',       defaultValue: 'ec2-user', description: 'Amazon Linux = ec2-user, Ubuntu = ubuntu')
    string(name: 'HOST_PORT',      defaultValue: '80', description: 'EC2 host port to expose')
    string(name: 'CONTAINER_PORT', defaultValue: '3000', description: 'App port inside container')
    string(name: 'AWS_REGION',     defaultValue: 'ap-south-1', description: 'Region for S3 backups')
    string(name: 'S3_BUCKET',      defaultValue: 'fizza-devops-logs', description: 'S3 bucket for logs')
  }

  environment {
    DOCKER_IMAGE = "${params.DOCKERHUB_REPO}"
  }

  options {
    disableConcurrentBuilds()
    timestamps()
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Docker Build & Tag') {
      steps {
        powershell '''
          cd app
          docker version
          docker build -t ${env.DOCKER_IMAGE}:${env.BUILD_NUMBER} -t ${env.DOCKER_IMAGE}:latest .
        '''
      }
    }

    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKERHUB_USR', passwordVariable: 'DOCKERHUB_PSW')]) {
          powershell '''
            echo "Logging in to Docker Hub..."
            docker login -u $env:DOCKERHUB_USR -p $env:DOCKERHUB_PSW
            docker push ${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}
            docker push ${env.DOCKER_IMAGE}:latest
          '''
        }
      }
    }

    stage('Deploy to EC2') {
      steps {
        withCredentials([file(credentialsId: 'ec2-key', variable: 'EC2_PEM')]) {
          powershell '''
            $ErrorActionPreference = "Stop"
            # fix key permissions on Windows if needed
            icacls $env:EC2_PEM /inheritance:r | Out-Null
            icacls $env:EC2_PEM /grant:r "$env:USERNAME:R" | Out-Null

            scp -o StrictHostKeyChecking=no -i $env:EC2_PEM deploy/deploy.sh ${params.EC2_USER}@${params.EC2_HOST}:/tmp/deploy.sh
            ssh -o StrictHostKeyChecking=no -i $env:EC2_PEM ${params.EC2_USER}@${params.EC2_HOST} "chmod +x /tmp/deploy.sh && sudo DOCKER_IMAGE='${env.DOCKER_IMAGE}' APP_NAME='${params.APP_NAME}' HOST_PORT='${params.HOST_PORT}' CONTAINER_PORT='${params.CONTAINER_PORT}' /tmp/deploy.sh '${env.BUILD_NUMBER}'"
          '''
        }
      }
    }

    stage('Backup logs to S3') {
      steps {
        withCredentials([file(credentialsId: 'ec2-key', variable: 'EC2_PEM')]) {
          powershell '''
            $ErrorActionPreference = "Stop"
            scp -o StrictHostKeyChecking=no -i $env:EC2_PEM deploy/backup_logs.sh ${params.EC2_USER}@${params.EC2_HOST}:/tmp/backup_logs.sh
            ssh -o StrictHostKeyChecking=no -i $env:EC2_PEM ${params.EC2_USER}@${params.EC2_HOST} "chmod +x /tmp/backup_logs.sh && AWS_REGION='${params.AWS_REGION}' S3_BUCKET='${params.S3_BUCKET}' APP_NAME='${params.APP_NAME}' /tmp/backup_logs.sh"
          '''
        }
      }
    }
  }

  post {
    always { cleanWs() }
  }
}








