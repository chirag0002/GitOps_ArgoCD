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
                    url: 'https://github.com/chirag0002/GitOps_Argo_CI.git',
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

        stage ('trigger congig CD changes'){
            steps{
                script{
                    sh "curl -v -k -user chirag:11b5fc0958c09d3380e33c97d64cb619e0 -X POST -H 'cache-control: no-cache' -H 'content-type: application/x-ww-form-urlencoded' -data 'IMAGE_TAG=${IMAGE_TAG}' 'http://13.233.0.44:8080/job/GitOps_CD/buildWithParameters?token=token'"
                }
            }
        }
    }
}