pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "fizza424/devops-demo"
        EC2_HOST     = "ec2-user@65.0.83.45"
        S3_BUCKET    = "fizza-devops-logs"
    }

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/Fizza424/Final-Project.git'
            }
        }

        stage('Build Docker') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}", 'app')
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                    docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest
                    docker push ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $EC2_HOST '
                        docker pull ${DOCKER_IMAGE}:latest &&
                        docker stop app || true &&
                        docker rm app || true &&
                        docker run -d -p 80:3000 --name app ${DOCKER_IMAGE}:latest
                    '
                    """
                }
            }
        }

        stage('Backup Logs to S3') {
            steps {
                sshagent(['ec2-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $EC2_HOST '
                        docker logs app > app.log &&
                        aws s3 cp app.log s3://${S3_BUCKET}/app-\$(date +%F-%H-%M-%S).log
                    '
                    """
                }
            }
        }
    }
}













