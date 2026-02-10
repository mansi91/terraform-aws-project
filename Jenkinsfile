pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo '✅ Checking out Terraform code from GitHub'
                checkout scm
            }
        }
        
        stage('Terraform Init') {
            steps {
                echo '🔄 Initializing Terraform...'
                sh '''
                    terraform init -input=false
                '''
            }
        }
        
        stage('Terraform Validate') {
            steps {
                echo '✅ Validating Terraform config...'
                sh '''
                    terraform validate
                '''
            }
        }
        
        stage('Terraform Plan') {
            steps {
                echo '📋 Creating execution plan...'
                sh '''
                    terraform plan -input=false -out=tfplan
                '''
                archiveArtifacts artifacts: 'tfplan', fingerprint: true, allowEmptyArchive: true
            }
        }
        
        stage('Waiting for Approval') {
            steps {
                timeout(time: 7, unit: 'DAYS') {
                    input message: 'Approve deployment?', ok: '🚀 Deploy Now'
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                echo '🚀 Deploying to AWS...'
                sh '''
                    terraform apply -input=false tfplan
                '''
            }
        }
    }
    
    post {
        always {
            echo '🏁 Pipeline completed!'
            cleanWs()
        }
    }
}
