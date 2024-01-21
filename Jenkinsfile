pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials-id')
        MAVEN_HOME = tool 'Maven'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Set Maven to the path
                    def mavenHome = tool 'Maven'
                    env.PATH = "${mavenHome}/bin:${env.PATH}"

                    // Maven Build
                    sh "mvn clean install"
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    // Docker Build
                    sh "docker build -t rameshpaidi/config-service:latest ."

                    // Docker Login
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker-hub-credentials-id', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]) {
                        sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    }

                    // Docker Push
                    sh "docker push rameshpaidi/config-service:latest"
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

