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
        always {

            emailext(
                to: 'andrewakram75@gmail.com',
                subject: "Jenkins Build: ${currentBuild.fullDisplayName}",
                body: """
                <p>Build finished with status: <b>${currentBuild.currentResult}</b></p>
                <p>Job: ${env.JOB_NAME}</p>
                <p>Build Number: ${env.BUILD_NUMBER}</p>
                <p>Check console output: <a href='${env.BUILD_URL}'>here</a></p>
                """,
                mimeType: 'text/html'
            )
        }
    }
}