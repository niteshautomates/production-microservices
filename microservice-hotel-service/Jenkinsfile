pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
               git branch: 'develop', url: 'https://github.com/niteshautomates/hotel-service.git'
            }
        }
        stage('Docker PostgresSQL Build & Push'){
            steps {
                script {
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: '81f68c87-772f-416e-b1b0-196d3423c436', toolName: 'docker') {
                        sh "docker build -t postgresql - Dockerfile_PG ."
                        sh "docker tag mysql nitesh2611/postgresql:${env.BUILD_NUMBER} "
                        sh "docker push nitesh2611/postgresql:${env.BUILD_NUMBER} "
                    }
                }
            }
        }
         stage("Docker Hotel Service Build & Push") {

            steps {
                script {
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: '81f68c87-772f-416e-b1b0-196d3423c436', toolName: 'docker') {
                        sh "docker build -t hotel-svc ."
                        sh "docker tag user-svc nitesh2611/hotel-svc:${env.BUILD_NUMBER} "
                        sh "docker push nitesh2611/hotel-svc:${env.BUILD_NUMBER} "
                    }
                }
            }
        }
        stage(){
            steps{

                         sh 'docker run -d --name pg-svc --network backend -p 5432:5432 nitesh2611/postgresql:latest'
                         sh 'sleep 20'
                         sh 'docker run -d --name hotel-service --network backend -p 8082:8082 nitesh2611/hotel-svc:latest'


            }
        }
    }
    post {
        success {
            echo 'Build and tests succeeded! Triggering downstream job.'
            build job: 'Ratings-Service-CI'
        }
        always {
            echo 'Cleaning workspace using cleanWs...'
            cleanWs()
            echo 'Workspace cleaned.'
        }

    }
}
