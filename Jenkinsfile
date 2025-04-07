pipeline {
    agent any

    environment {
        REMOTE_HOST = '13.203.198.127'
        REMOTE_USER = 'viswa'
        REMOTE_DIR  = '/home/viswa/laravel'
    }

    stages {
        stage('Deploy to EC2') {
            steps {
                sshagent(['ssh_laravel-server']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} '
                            echo "Pulling latest code..."
                            cd ${REMOTE_DIR} && git pull origin master
                        '
                    """
                }
            }
        }

        stage('Docker Build') {
            steps {
                sshagent(['ssh_laravel-server']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} '
                            echo "Running docker-compose build and up..."
                            cd ${REMOTE_DIR} && docker-compose down  && docker-compose up --build -d
                        '
                    """
                }
            }
        }
    }
}
