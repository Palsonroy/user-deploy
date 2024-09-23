        pipeline {
        agent {
        node {
            label 'AGENT'
            
        }
    }
    // environment { 
    //         packageVersion = ''
    //         nexusUrl = '172.31.80.240:8081'
    //     }
    options {
        // Timeout counter starts AFTER agent is allocated
        timeout(time: 1 , unit: 'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
     parameters {
        string(name: 'version', defaultValue: '', description: 'What is the artifact version?')
        string(name: 'environment', defaultValue: 'dev', description: 'What is the environment?')
        booleanParam(name: 'Destroy', defaultValue: 'false', description: 'What is the destroy?')
        booleanParam(name: 'Create', defaultValue: 'false', description: 'What is the create?')
    }
    
    stages {
        stage('Print version') {
             steps {
                sh """
                    echo "version: ${params.version}"
                    echo "environment: ${params.environment}"
                """
                }
            }
            stage('Init') {
                steps {
                    sh """
                        cd terraform
                        terraform init --backend-config=${params.environment}/backend.tf -reconfigure
                    """
                    }
                }
            stage('Plan') {
                when{
                    expression{
                        params.Create
                    }
                }
                steps {
                    sh """
                        cd terraform
                        terraform plan -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}"
                    """
                    }
                }
            stage('Apply') {
                when{
                    expression{
                        params.Create
                    }
                }
                steps {
                    sh """
                        cd terraform
                        terraform apply -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
                    """
                    }
                }
                }
            stage('Destroy') {
                when{
                    expression{
                        params.Destroy
                    }
                }
                steps {
                    sh """
                        cd terraform
                        terraform destroy -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve
                    """
                    }
                }    
        
        }

        post { 
            always { 
                echo 'I will always say Hello again!'
                deleteDir()
            }
        }
    }