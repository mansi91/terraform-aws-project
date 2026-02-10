pipeline {
    agent any
    
    stages {
        stage('Checkout & List Files') {
            steps {
                checkout scm
                sh '''
                    ls -la
                    terraform --version || echo "Terraform not available"
                '''
            }
        }
        
        stage('Run Terraform Locally') {
            steps {
                sh '''
                    echo "Terraform CLI not available in base Jenkins image"
                    echo "Download: https://developer.hashicorp.com/terraform/install"
                    exit 0
                '''
            }
        }
    }
}