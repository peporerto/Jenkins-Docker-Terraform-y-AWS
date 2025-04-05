pipeline {
    agent any

    parameters {
        choice(name: 'TerraformAction', choices: ['Deploy', 'Destroy'], description: 'Selecciona la acción a ejecutar')
    }

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[url: 'https://github.com/peporerto/Jenkins-Docker-Terraform-y-AWS.git']]
                    ])
                }
            }
        }

        stage('Terraform Init & Validate') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh 'terraform init'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            when { expression { params.TerraformAction == 'Deploy' } }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when { expression { params.TerraformAction == 'Deploy' } }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when { expression { params.TerraformAction == 'Destroy' } }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo "✅ ${params.TerraformAction} completado con éxito"
        }
        failure {
            echo "❌ ${params.TerraformAction} falló"
        }
    }
}
