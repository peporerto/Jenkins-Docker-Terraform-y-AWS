pipeline {
    agent any

    parameters {
        choice(name: 'TerraformAction', choices: 'Deploy\nDestroy', description: 'Selecciona la acción a ejecutar')
    }

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-credentials')  
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials')
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Clonar el código de Terraform desde GitHub
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[url: 'https://github.com/mathesh-me/aws-ha-deployment-jenkins-terraform.git']]
                    ])
                }
            }
        }

        stage('Terraform Init and Plan') {
            when {
                expression {
                    return params.TerraformAction == 'Deploy'
                }
            }
            steps {
                script {
                    // Inicializar Terraform y generar el plan
                    sh 'terraform init'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression {
                    return params.TerraformAction == 'Deploy'
                }
            }
            steps {
                script {
                    // Aplicar la infraestructura con Terraform
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression {
                    return params.TerraformAction == 'Destroy'
                }
            }
            steps {
                script {
                    // Eliminar la infraestructura con Terraform
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        success {
            script {
                echo "✅ ${params.TerraformAction} completado con éxito"
            }
        }
        failure {
            script {
                echo "❌ ${params.TerraformAction} falló"
            }
        }
    }
}
