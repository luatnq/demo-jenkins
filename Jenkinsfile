pipeline {
    agent any
    tools {
        maven 'my-maven'
        jdk 'jdk-17'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn --version'
                sh 'java --version'
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }

}
