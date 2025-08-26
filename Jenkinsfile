pipeline {
    agent any

    environment {
        IMAGE_NAME = "fizza424/final-project"
        IMAGE_TAG  = "latest"
        AWS_REGION = "ap-south-1"
        EC2_HOST   = "ec2-user@65.2.78.12"   // ✅ updated new EC2 IP
        KEY_PATH   = "C:/Users/HP/Downloads/fizza-ec2-key.pem"
        S3_BUCKET  = "fizza-devops-log"
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
                    ssh -i "%KEY_PATH%" %EC2_HOST% "docker pull %IMAGE_NAME%:%IMAGE_TAG% && docker-compose -f docker-compose.yml up -d"
                """
            }
        }

        stage('Backup logs to S3') {
    steps {
        sshagent(['ec2-ssh-key']) {
            sh """
                ssh -o StrictHostKeyChecking=no ec2-user@65.2.78.12 \
                "AWS_ACCESS_KEY_ID=%AWS_ACCESS_KEY_ID% AWS_SECRET_ACCESS_KEY=%AWS_SECRET_ACCESS_KEY% AWS_REGION=%AWS_REGION% \
                aws s3 cp /var/lib/docker/containers/ s3://%S3_BUCKET%/ --recursive"
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

















