pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('optitcloud-dockerhub-credentials')
    }
    parameters {
        string(name: 'GIT_REPO', defaultValue: 'https://github.com/srajasimman/sample-projects.git', description: 'Git repo')
        string(name: 'GIT_BRANCH', defaultValue: 'java-springboot-maven', description: 'Git branch')
        string(name: 'DOCKER_REPO', defaultValue: 'docker.io/optitcloud', description: 'Docker Container Registry')
        string(name: 'DOCKER_IMAGE', defaultValue: 'java-springboot-maven', description: 'Docker Image Name')
        string(name: 'DOCKER_TAG', defaultValue: 'latest', description: 'Docker Image Tag')
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    git (url: "${params.GIT_REPO}", branch: "${params.GIT_BRANCH}")
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    sh (script: "docker build -t ${params.DOCKER_REPO}/${params.DOCKER_IMAGE}:${params.DOCKER_TAG} .")
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('', 'optitcloud-dockerhub-credentials') {
                        sh (script: "docker push ${params.DOCKER_REPO}/${params.DOCKER_IMAGE}:${params.DOCKER_TAG}")
                    }
                }
            }
        }
    }
}