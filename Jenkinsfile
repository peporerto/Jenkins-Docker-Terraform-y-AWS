pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Preparar Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Clonar repo') {
            steps {
                sshagent(['github-jenkins-key']) {
                    sh 'git clone git@github.com:peporerto/Jenkins-Docker-Terraform-y-AWS.git'
                }
            }
        }

        stage('Inicializar Terraform') {
            steps {
                dir('Jenkins-Docker-Terraform-y-AWS') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('Jenkins-Docker-Terraform-y-AWS') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('Jenkins-Docker-Terraform-y-AWS') {
                    sh 'terraform apply -auto-approve'
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
