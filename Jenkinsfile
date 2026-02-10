pipeline {
    agent none
    
    stages {
        stage('Terraform') {
            agent {
                docker {
                    image 'hashicorp/terraform:latest'
                    args '-u root --entrypoint=""'
                }
            }
            
            stages {
                stage('Checkout') {
                    steps {
                        echo '✅ Checking out Terraform code'
                        checkout scm
                    }
                }
                
                stage('Terraform Init') {
                    steps {
                        echo '🔄 Initializing Terraform...'
                        sh 'terraform init -input=false'
                    }
                }
                
                stage('Terraform Validate') {
                    steps {
                        echo '✅ Validating config...'
                        sh 'terraform validate'
                    }
                }
                
                stage('Terraform Plan') {
                    steps {
                        echo '📋 Creating plan...'
                        sh '''
                            terraform workspace new or select default
                            terraform plan -input=false -out=tfplan
                        '''
                        archiveArtifacts artifacts: 'tfplan', allowEmptyArchive: false
                    }
                }
                
                stage('Approval') {
                    steps {
                        input message: '🚀 Deploy to AWS?', ok: 'Approve'
                    }
                }
                
                stage('Terraform Apply') {
                    steps {
                        echo '🚀 Deploying infrastructure...'
                        sh 'terraform apply -input=false -auto-approve tfplan'
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo '🏁 Pipeline completed!'
        }
    }
}
