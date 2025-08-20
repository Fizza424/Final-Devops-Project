pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "fizza424/final-devops-project"   // change to your Docker Hub repo
        AWS_REGION = "ap-south-1"                           // change if different
        EC2_USER = "ec2-user"
        EC2_HOST = "13.235.78.253"                          // your EC2 public IP
        PEM_PATH = "/var/lib/jenkins/fizza-ec2-key.pem"     // path where Jenkins has your .pem
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Fizza424/Final-Devops-Project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_HUB_REPO}:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', 
                                                 usernameVariable: 'DOCKER_USER', 
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${DOCKER_HUB_REPO}:latest
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    sh """
                        ssh -o StrictHostKeyChecking=no -i ${PEM_PATH} ${EC2_USER}@${EC2_HOST} '
                            docker pull ${DOCKER_HUB_REPO}:latest &&
                            docker stop app || true &&
                            docker rm app || true &&
                            docker run -d --name app -p 80:80 ${DOCKER_HUB_REPO}:latest
                        '
                    """
                }
            }
        }

        stage('Backup Logs to S3') {
            steps {
                withAWS(region: "${AWS_REGION}", credentials: 'aws-creds') {
                    sh """
                        tar -czf app-logs.tar.gz /var/lib/jenkins/jobs || true
                        aws s3 cp app-logs.tar.gz s3://final-devops-project-logs/
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline executed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}



