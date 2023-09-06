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

      steps {
        withDockerRegistry(credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/') {
          sh 'docker push luatnq/springboot-jenkins'
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
