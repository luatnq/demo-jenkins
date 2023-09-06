pipeline {
    agent any
    tools {
        maven 'maven'
    }

    environment {
      DOCKERHUB_CREDENTIALS = credentials('docker-hub')
    }

    stages {
      stage('Build') {
        steps {
          sh 'docker build -t luatnq/springboot-jenkins .'
        }
      }

      stage('Push') {
        steps {
           withDockerRegistry(credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/') {
             sh 'docker push luatnq/springboot-jenkins'
           }
        }
      }

      stage('Deploy Spring Boot to DEV') {
          steps {
             echo 'Deploying and cleaning'
             sh 'docker image pull luatnq/springboot-jenkins'
             sh 'docker container stop springboot-jenkins || echo "this container does not exist" '
             sh 'docker network create dev || echo "this network exists"'
             sh 'echo y | docker container prune '
             sh 'docker container run -d --rm --name springboot-jenkins -p 8081:8080 --network dev luatnq/springboot-jenkins'
          }
      }


    }

    post {
      always {
        // Logout from Docker Hub
        sh 'docker logout'
      }
    }
}
