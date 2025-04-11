pipeline {
    agent any

    
    options {
        skipDefaultCheckout(true)
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {
        stage('Limpiar Workspace') {
            steps {
                deleteDir() // Limpia TODO para empezar desde cero
            }
        }

        stage('Clonar repo desde GitHub') {
            steps {
                sshagent(['github-jenkins-key']) {
                    sh 'ssh -T git@github.com || true'
                    sh 'git clone git@github.com:peporerto/Jenkins-Docker-Terraform-y-AWS.git'
                }
            }
        }

        stage('Inicializar Terraform') {
            steps {
                dir('Jenkins-Docker-Terraform-y-AWS') {
                    sh 'echo "🔧 Iniciando terraform init..."'
                    sh 'terraform init -input=false -no-color'
                    sh 'echo "✅ Terraform init terminado"'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('Jenkins-Docker-Terraform-y-AWS') {
                    sh 'echo "📌 Ejecutando terraform plan..."'
                    sh 'terraform plan -input=false -no-color'
                    sh 'echo "✅ Terraform plan terminado"'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('Jenkins-Docker-Terraform-y-AWS') {
                    sh 'terraform apply -auto-approve -input=false -no-color'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Terraform se ejecutó correctamente'
        }
        failure {
            echo '❌ Hubo un error al ejecutar Terraform'
        }
    }
}
