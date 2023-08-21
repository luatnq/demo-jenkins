pipeline {
    agent any
    tools {
        maven 'my-maven'
    }

    environment {
      DOCKERHUB_CREDENTIALS = credentials('docker-hub')
    }

    stages {
      stage('Build') {
        steps {
          echo "$USER"
          sh 'docker build -t luatnq/springboot-jenkins .'
        }
      }

      stage('Login') {
        steps {
          script {
            // Retrieve Docker Hub credentials
            def dockerHubUser = credentials('docker-hub').username
            def dockerHubPass = credentials('docker-hub').password
            // Login to Docker Hub
            sh "echo $dockerHubPass | docker login -u $dockerHubUser --password-stdin"
          }
        }
      }

      stage('Push') {
        steps {
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
