pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building project...'

            }
        }
    }

    post {
        success {
            emailext(
                subject: "jenkins Build Successful",
                body: "Hey,Your Jenkins build completed successfully!",
                to: "andrewakram75@gmail.com"
            )
        }
        failure {
            emailext(
                subject: "jenkins build failed",
                body: "Hey,Your Jenkins build failed. Check the Jenkins console output for details.",
                to: "andrewakram75@gmail.com"
            )
        }
    }
}