pipeline {
    agent any
    tools {
        maven 'my-maven'
    }

    stages {
            stage('Print User Info') {
                steps {
                    script {
                        def userId = env.BUILD_USER_ID
                        if (userId) {
                            echo "Pipline được chạy bởi: ${userId}"
                        } else {
                            echo "Không thể xác định người dùng đang chạy pipeline."
                        }
                    }
                }
       }
    }
}
