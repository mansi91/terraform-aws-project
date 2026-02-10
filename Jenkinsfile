pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                                 credentialsId: 'aws-terraform']]) {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                                 credentialsId: 'aws-terraform']]) {
                    sh 'terraform plan -out=tfplan'
                }
                archiveArtifacts artifacts: 'tfplan'
            }
        }
        
        stage('Approval') {
            steps {
                input message: 'Deploy to AWS?', ok: 'Approve'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                                 credentialsId: 'aws-terraform']]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
}
