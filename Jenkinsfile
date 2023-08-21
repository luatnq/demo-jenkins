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
          sh 'docker build -t luatnq/springboot-jenkins .'
        }
      }
      stage('Login') {
        steps {
          sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
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
        sh 'docker logout'
      }
    }


}
