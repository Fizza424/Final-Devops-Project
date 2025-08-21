pipeline {
    agent any

    parameters {
        string(name: 'DOCKERHUB_REPO', defaultValue: 'fizza424/dockerhub_repo', description: 'DockerHub repo')
        string(name: 'APP_NAME', defaultValue: 'final-devops-app', description: 'Container name')
        string(name: 'EC2_HOST', defaultValue: 'ec2-65-0-83-45.ap-south-1.compute.amazonaws.com', description: 'EC2 Public DNS')
        string(name: 'EC2_USER', defaultValue: 'ec2-user', description: 'EC2 username')
        string(name: 'HOST_PORT', defaultValue: '80', description: 'Port exposed on EC2')
        string(name: 'CONTAINER_PORT', defaultValue: '3000', description: 'App port inside container')
        string(name: 'AWS_REGION', defaultValue: 'ap-south-1', description: 'AWS Region')
        string(name: 'S3_BUCKET', defaultValue: 'fizza-devops-logs', description: 'S3 bucket for logs backup')
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
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
              sh """
                  docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} -t ${DOCKER_IMAGE}:latest .
                """
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKERHUB_USR', passwordVariable: 'DOCKERHUB_PSW')]) {
                    sh """
                      echo "$DOCKERHUB_PSW" | docker login -u "$DOCKERHUB_USR" --password-stdin
                      docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                      docker push ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                withCredentials([file(credentialsId: 'ec2-key', variable: 'EC2_PEM')]) {
                    sh """
                      chmod 400 $EC2_PEM
                      scp -o StrictHostKeyChecking=no -i $EC2_PEM deploy.sh ${params.EC2_USER}@${params.EC2_HOST}:/tmp/deploy.sh
                      ssh -o StrictHostKeyChecking=no -i $EC2_PEM ${params.EC2_USER}@${params.EC2_HOST} "chmod +x /tmp/deploy.sh && DOCKER_IMAGE='${DOCKER_IMAGE}' APP_NAME='${params.APP_NAME}' HOST_PORT='${params.HOST_PORT}' CONTAINER_PORT='${params.CONTAINER_PORT}' /tmp/deploy.sh '${params.BUILD_NUMBER}'"
                    """
                }
            }
        }

        stage('Backup Logs to S3') {
            steps {
                withCredentials([file(credentialsId: 'ec2-key', variable: 'EC2_PEM')]) {
                    sh """
                      scp -o StrictHostKeyChecking=no -i $EC2_PEM backup_logs.sh ${params.EC2_USER}@${params.EC2_HOST}:/tmp/backup_logs.sh
                      ssh -o StrictHostKeyChecking=no -i $EC2_PEM ${params.EC2_USER}@${params.EC2_HOST} "chmod +x /tmp/backup_logs.sh && AWS_REGION='${params.AWS_REGION}' S3_BUCKET='${params.S3_BUCKET}' APP_NAME='${params.APP_NAME}' /tmp/backup_logs.sh"
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}












