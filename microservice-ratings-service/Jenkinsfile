pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
               git branch: 'develop', url: 'https://github.com/niteshautomates/ratings-service.git'
            }
        }
        stage('Docker MongoDB Build & Push'){
            steps {
                script {
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: '81f68c87-772f-416e-b1b0-196d3423c436', toolName: 'docker') {
                        sh "docker build -t mongodb ."
                        sh "docker tag mongodb nitesh2611/mongodb:${env.BUILD_NUMBER} "
                        sh "docker push nitesh2611/mongodb:${env.BUILD_NUMBER} "
                    }
                }
            }
        }
         stage("Docker Ratings Service Build & Push") {

            steps {
                script {
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: '81f68c87-772f-416e-b1b0-196d3423c436', toolName: 'docker') {
                        sh "docker build -t ratings-svc ."
                        sh "docker tag user-svc nitesh2611/ratings-svc:${env.BUILD_NUMBER} "
                        sh "docker push nitesh2611/ratings-svc:${env.BUILD_NUMBER} "
                    }
                }
            }
        }
        stage(){
            steps{

                         sh 'docker run -d --name mongodb-svc --network backend -p 27017:27017 nitesh2611/mongodb:latest'
                         sh 'sleep 20'
                         sh 'docker run -d --name ratings-service --network backend -p 8083:8083 nitesh2611/ratings-svc:latest'

            }
        }
    }
     post {
        always {
            echo 'Cleaning workspace using cleanWs...'
            cleanWs()
            echo 'Workspace cleaned.'
        }
    }
}
