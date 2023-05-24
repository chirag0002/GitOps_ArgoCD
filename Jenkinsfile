pipeline{

    agent any

    environment{

        DOCKERHUB_USERNAME = "chirag0101010101"
        APP_NAME = "GitOps_ArogoCD"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/${APP_NAME}:${IMAGE_TAG}"
        REGISTRY_CREDS = "dockerhub"
    }

    stages{

        stage('Cleanup Workspace'){
            
            steps{
                script{
                    cleanWs()
                }
            }
        }

        stage ('Checkout'){

            steps{
                script{
                    git credentialsId: 'GitHub',
                    url: 'https://github.com/chirag0002/GitOps_ArgoCD',
                    branch: 'main'
                }
            }
        }
    }
}