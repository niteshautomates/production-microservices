pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
               git branch: 'develop', url: 'https://github.com/niteshautomates/user-service.git'
            }
        }
        stage('Docker MySQl Build & Push'){
            steps {
                script {
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: '81f68c87-772f-416e-b1b0-196d3423c436', toolName: 'docker') {
                        sh "docker build -t mysql -f Dockerfile_MySql ."
                        sh "docker tag mysql nitesh2611/mysql:${env.BUILD_NUMBER} "
                        sh "docker push nitesh2611/mysql:${env.BUILD_NUMBER} "
                    }
                }
            }
        }
         stage("Docker User Service Build & Push") {

            steps {
                script {
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: '81f68c87-772f-416e-b1b0-196d3423c436', toolName: 'docker') {
                        sh "docker build -t user-svc ."
                        sh "docker tag user-svc nitesh2611/user-svc:${env.BUILD_NUMBER} "
                        sh "docker push nitesh2611/user-svc:${env.BUILD_NUMBER} "

                    }
                }
            }
        }
        stage('Deploy User Service'){
            steps{

                     sh 'docker run -d --name mysql --network backend -p 3306:3306 nitesh2611/mysql:${env.BUILD_NUMBER}'
                     sh 'sleep 20'
                     sh 'docker run -d --name user-service --network backend -p 3306:3306 nitesh2611/user-svc:${env.BUILD_NUMBER}'

            }
        }

    }
        post {
        success {
            echo 'Build and tests succeeded! Triggering downstream job.'
            build job: 'Hotel-Service-CI'
        }
        always {
            echo 'Cleaning workspace using cleanWs...'
            cleanWs()
            echo 'Workspace cleaned.'
        }

    }
}
