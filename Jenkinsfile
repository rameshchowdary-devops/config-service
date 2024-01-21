pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials-id')
        MAVEN_HOME = tool 'Maven'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    git credentialsId: '1fda5e71-b25f-4e8c-b7c1-81c7a4db4793',
                    url: 'https://github.com/rameshchowdary-devops/config-service.git',
                    branch: 'main'
                }
            }
        }

        stage('Build Docker') {
            steps {
                script {
                    echo 'Build Docker Image'
                    docker.build("rameshpaidi/config-service:${IMAGE_TAG}")
                }
            }
        }

        stage('Push the artifacts') {
            steps {
                script {
                    echo 'Push to Repo'
                    docker.withRegistry('', DOCKER_HUB_CREDENTIALS) {
                        docker.image("rameshpaidi/config-service:${IMAGE_TAG}").push()
                    }
                }
            }
        }
    }

    post {
        always {
            // Cleanup
            script {
                sh "docker logout"
            }
        }
    }
}
