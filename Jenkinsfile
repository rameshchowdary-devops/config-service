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
                git credentialsId: '1fda5e71-b25f-4e8c-b7c1-81c7a4db4793', 
                url: 'https://github.com/rameshchowdary-devops/config-service.git',
                branch: 'main'                
 
            }
        }
        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Buid Docker Image'
                    docker build -t rameshpaidi/config-service:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    sh '''
                    echo 'Push to Repo'
                    docker push rameshpaidi/config-service:${BUILD_NUMBER}
                    '''
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