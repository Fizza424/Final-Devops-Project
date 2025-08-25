pipeline {
    agent any

    environment {
        IMAGE_NAME = "fizza424/final-devops-project"   // must be all lowercase
        IMAGE_TAG  = "latest"
        AWS_REGION = "ap-south-1"   // change if your EC2/S3 is in a different region
        EC2_HOST   = "ec2-user@65.0.83.45"
        KEY_PATH   = "C:/Users/HP/Downloads/fizza-ec2-key.pem"   // update path to your .pem key
        S3_BUCKET  = "fizza-devops-log"   // change to your S3 bucket
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Fizza424/Final-Devops-Project.git'
            }
        }

        stage('Build Docker image') {
            steps {
                bat """
                    docker build -t %IMAGE_NAME%:%IMAGE_TAG% .
                """
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                                  usernameVariable: 'DOCKER_USER',
                                                  passwordVariable: 'DOCKER_PASS')]) {
                    bat """
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push %IMAGE_NAME%:%IMAGE_TAG%
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                bat """
                    scp -i "%KEY_PATH%" docker-compose.yml %EC2_HOST%:/home/ec2-user/
                    ssh -i "%KEY_PATH%" %EC2_HOST% "docker pull %IMAGE_NAME%:%IMAGE_TAG% && docker compose -f docker-compose.yml up -d"
                """
            }
        }

        stage('Backup logs to S3') {
            steps {
                withCredentials([aws(credentialsId: 'aws-creds', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    bat """
                        aws s3 cp C:/ProgramData/Jenkins/.jenkins/logs/ s3://%S3_BUCKET%/ --recursive --region %AWS_REGION%
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check the logs."
        }
    }
}
















