pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "fizza424/final-project"
        AWS_DEFAULT_REGION = "ap-south-1" // change if your bucket is in another region
        S3_BUCKET = "fizza-devops-logs" // change to your bucket name
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Fizza424/Final-Project.git'
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Set Docker Context') {
    steps {
        bat 'docker context use desktop-linux'
    }
}


        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([ credentialsId: 'docker-hub-creds', url: '' ]) {
                    script {
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent (credentials: ['ec2-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@65.0.83.45 '
                          docker pull ${DOCKER_IMAGE}:latest &&
                          docker stop final-project || true &&
                          docker rm final-project || true &&
                          docker run -d --name final-project -p 80:3000 ${DOCKER_IMAGE}:latest
                        '
                    '''
                }
            }
        }

        stage('Backup logs to S3') {
            steps {
                sshagent (credentials: ['ec2-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@65.0.83.45 '
                          tar -czf /tmp/app-logs.tar.gz /usr/src/app/logs || true
                        '
                        scp -o StrictHostKeyChecking=no ec2-user@65.0.83.45:/tmp/app-logs.tar.gz .
                        aws s3 cp app-logs.tar.gz s3://${S3_BUCKET}/logs/$(date +%F-%H-%M-%S)-app-logs.tar.gz
                    '''
                }
            }
        }
    }
}
















