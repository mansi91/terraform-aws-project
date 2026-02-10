 {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Auto-checkout from GitHub repo
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
                archiveArtifacts 'tfplan'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                input 'Apply the plan?'
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    
       stages {
        stage('Install Terraform') {
            steps}
    }
}
