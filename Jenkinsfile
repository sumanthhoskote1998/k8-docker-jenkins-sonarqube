pipeline {
    agent any

    environment {
        SONARQUBE_URL = 'http://13.60.239.186:9000'  // Replace with your SonarQube URL
        SONARQUBE_TOKEN = credentials('sqp_07ebae4f9abb12d473d8e84e8ea97c9524f73479')    // Create Jenkins secret for token
        DOCKER_IMAGE = 'calculator-app'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sumanthhoskote1998/k8-docker-jenkins-sonarqube.git'
            }
        }

        stage('Build Project') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                    mvn sonar:sonar \
                      -Dsonar.host.url=${SONARQUBE_URL} \
                      -Dsonar.login=${SONARQUBE_TOKEN} \
                      -Dsonar.projectKey=calculator-app
                    """
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t ${DOCKER_IMAGE}:latest .
                """
            }
        }

        stage('Deploy Docker Container') {
            steps {
                sh """
                docker stop calculator-app || true
                docker rm calculator-app || true
                docker run -d -p 8080:8080 --name calculator-app ${DOCKER_IMAGE}:latest
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}

