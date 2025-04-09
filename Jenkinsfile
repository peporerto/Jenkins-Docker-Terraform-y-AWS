pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Clonar repo') {
            steps {
                sshagent(['github-jenkins-key']) {
                    sh 'git clone git@github.com:peporerto/Jenkins-Docker-Terraform-y-AWS.git'
                }
            }
        }

        stage('Preparar Terraform') {
            steps {
                script {
                    sh 'docker exec terraform-container terraform init'
                }
            }
        }

        stage('Ejecutar Terraform Plan') {
            steps {
                script {
                    sh 'docker exec terraform-container terraform plan'
                }
            }
        }

        stage('Aplicar Terraform') {
            steps {
                script {
                    sh 'docker exec terraform-container terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform ha sido ejecutado correctamente'
        }
        failure {
            echo 'Hubo un error al ejecutar Terraform'
        }
    }
}
