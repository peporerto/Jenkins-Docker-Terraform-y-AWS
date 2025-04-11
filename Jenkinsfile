pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Clonar repo') {
            steps {
                sshagent(['134a2345-7c8f-44e7-a9d5-6ce69ca4c6bc']) {
                    sh 'git clone git@github.com:peporerto/Jenkins-Docker-Terraform-y-AWS.git'
                }
            }
        }

        stage('Inicializar Terraform') {
            steps {
                script {
                    echo "🔧 Iniciando terraform init..."
                    sh 'terraform init -input=false -no-color'
                    echo "✅ Terraform init terminado"
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    echo "📌 Ejecutando terraform plan..."
                    sh 'terraform plan -input=false -no-color'
                    echo "✅ Terraform plan terminado"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    echo "🚀 Ejecutando terraform apply..."
                    sh 'terraform apply -auto-approve -input=false -no-color'
                    echo "✅ Terraform apply terminado"
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
