pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'ls -la'
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh '''
                    terraform init
                '''
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh '''
                    terraform plan -out=tfplan
                '''
                archiveArtifacts artifacts: 'tfplan', allowEmptyArchive: true
            }
        }
        
        stage('Approval') {
            steps {
                input message: 'Deploy to AWS?', ok: 'Approve'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                sh '''
                    terraform apply -auto-approve tfplan
                '''
            }
        }
    }
}
