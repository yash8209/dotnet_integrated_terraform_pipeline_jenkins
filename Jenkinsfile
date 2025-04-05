pipeline {
    agent any
    environment {
        AZURE_CREDENTIALS_ID = 'azure-dotnet-service-principal'
        RESOURCE_GROUP = 'rg-jenkins'
        APP_SERVICE_NAME = 'webapiyashpjenkins82648'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/yash8209/dotnet_integrated_terraform_pipeline_jenkins.git'
            }
        }

        stage('Test Terraform') {
            steps {
                dir('terraform657') {
                    bat 'terraform --version'
                }
            }
        }

        stage('Terraform Setup') {
            steps {
                dir('terraform657') {
                    bat 'terraform init'
                    bat 'terraform plan -out=tfplan -var="deployment_slot_name=staging"'
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Build') {
            steps {
                dir('pipeline_ex') {
                    bat 'dotnet restore pipeline_ex.sln'
                    bat 'dotnet build pipeline_ex.sln'
                    bat 'dotnet publish -c Release -o ./publish'
                }
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat "az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID"

                    dir('pipeline_ex') {
                        bat "powershell Compress-Archive -Path ./publish/* -DestinationPath ../publish.zip -Force"
                    }

                    bat "az webapp deploy --resource-group $RESOURCE_GROUP --name $APP_SERVICE_NAME --src-path publish.zip --type zip"
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed!'
        }
    }
}

