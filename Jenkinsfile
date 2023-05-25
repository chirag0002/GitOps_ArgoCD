pipeline{

    agent any

    environment{

        DOCKERHUB_USERNAME = "chirag0101010101"
        APP_NAME = "gitops_arogocd"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/${APP_NAME}"
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

        stage ('Build Docker Image'){

            steps{
                script{
                    docker_image = docker.build "${IMAGE_NAME}"
                }
            }
        }

        stage ('Push Docker Image'){

            steps{
                script{
                    docker.withRegistry('', REGISTRY_CREDS){
                        docker_image.push("$BUILD_NUMBER")
                        docker_image.push("latest")
                    }
                }
            }
        }

        stage ('Delete Docker Images'){

            steps{
                script{
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
                }
            }
        }

        stage ('Update Kubernetes Deployment'){

            steps{
                script{
                    sh """
                    cat deployment.yml
                    sed -i 's/${APP_NAME}.*/${APP_NAME}:${IMAGE_TAG}/g' deployment.yml
                    cat deployment.yml
                    """
                }
            }
        }

        stage ('Push changed deployment to GitHub'){ 
            steps{
                script{
                    sh """
                      git config --global user.email "varshneychirag34@gmail.com"
                      git config --global user.name "chirag0002"
                      git add deployment.yml
                      git commit -m "Updated deployment"
                    """

                    withCredentials([gitUsernamePassword(credentialsId: 'GitHub', gitToolName: 'Default')]) {
                        git push "https://github.com/chirag0002/GitOps_ArgoCD.git" main
                    }  
                }
            }
        }
    }
}