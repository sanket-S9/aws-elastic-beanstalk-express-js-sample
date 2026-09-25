pipeline {
    agent any

    environment {
        // docker hub image name - username/repo
        IMAGE_NAME = 'sanketadhikari/express-sample-app'
        // jenkins credential id, set up separately in jenkins ui (never hardcode real creds here)
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'docker run --rm -v $(pwd):/app -w /app node:16 npm install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'docker run --rm -v $(pwd):/app -w /app node:16 npm test'
            }
        }

        stage('Security Scan') {
            steps {
                sh 'docker run --rm -v $(pwd):/app -w /app node:16 npm audit --audit-level=high'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}
