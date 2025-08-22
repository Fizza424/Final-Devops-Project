pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-creds')   // Add in Jenkins → Credentials
        AWS_CREDENTIALS = credentials('aws-creds')                // Add in Jenkins → Credentials
        DOCKER_IMAGE = "fizza424/devops-demo"                     // Change to your Docker Hub repo
        EC2_HOST = "ec2-user@65.0.83.45"                          // Your EC2 public IP + user
        PEM_KEY = "~/.ssh/fizza-ec2-key.pem"                      // Path to your private key
        APP_DIR = "/home/ec2-user/app"                            // Deploy directory on EC2
        BRANCH = "main"
    }

    stages {
        stage('Clone') {
            steps {
                git branch: "${BRANCH}", url: 'https://github.com/Fizza424/Final-Project.git'
            }
        }

        stage('Build Docker') {
            steps {
                script {
                    sh """
                        docker build -t ${DOCKER_IMAGE}:latest .
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh """
                        echo "${DOCKER_HUB_CREDENTIALS_PSW}" | docker login -u "${DOCKER_HUB_CREDENTIALS_USR}" --password-stdin
                        docker push ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    sh """
                        ssh -o StrictHostKeyChecking=no -i ${PEM_KEY} ${EC2_HOST} "
                            docker pull ${DOCKER_IMAGE}:latest &&
                            docker stop app || true &&
                            docker rm app || true &&
                            docker run -d --name app -p 80:80 ${DOCKER_IMAGE}:latest
                        "
                    """
                }
            }
        }

        stage('Backup Logs to S3') {
            steps {
                script {
                    sh """
                        ssh -o StrictHostKeyChecking=no -i ${PEM_KEY} ${EC2_HOST} "docker logs app > app.log"
                        scp -o StrictHostKeyChecking=no -i ${PEM_KEY} ${EC2_HOST}:app.log .
                        aws s3 cp app.log s3://your-s3-bucket-name/ --region ap-south-1
                    """
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
        success {
            echo "✅ Deployment successful!"
        }
    }
}













