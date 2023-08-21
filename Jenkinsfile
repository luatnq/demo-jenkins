pipeline {
    agent any
    tools {
        maven 'my-maven'
    }
    stages {
        stage('Packaging/Pushing image') {
            steps {
                withDockerRegistry(credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/') {
                    sh 'docker build -t luatnq/springboot-jenkins .'
                    sh 'docker push luatnq/springboot-jenkins'
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy Application to DEV') {
            steps {
                echo 'Deploying to DEV...'

                // Pull the updated Docker image
                sh 'docker pull luatnq/springboot-jenkins'

                // Stop and remove the existing container (if running)
                sh 'docker stop springboot-jenkin-container || echo "this container does not exist" '
                sh 'docker rm springboot-jenkin-container || echo "this container does not exist"'

                // Start the application container using the new image
                sh 'docker run -d --name springboot-jenkin-container -p 8080:8080 luatnq/springboot-jenkins'
            }
        }
    }
    post {
        // Clean after build
        always {
             cleanWs()
        }
    }

}
