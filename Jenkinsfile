pipeline {
    agent any
    environment {
        TFVARS_FILE = 'terraform.tfvars'
        GCP_CREDENTIALS_FILE = credentials('gcp-service-account') // Configure your Jenkins credential for GCP Service Account
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -var-file=${TFVARS_FILE}'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply -var-file=${TFVARS_FILE} -auto-approve'
                }
            }
        }
    }
    post {
        always {
            script {
                sh 'terraform state list || true'
            }
        }
    }
}
