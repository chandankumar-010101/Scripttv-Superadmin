pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "your-docker-registry.com"
        AWS_DEFAULT_REGION = "us-east-1"
        ECS_CLUSTER_NAME = "your-ecs-cluster-name"
        BACKEND_TASK_FAMILY = "your-backend-task-family"
        FRONTEND_TASK_FAMILY = "your-frontend-task-family"
        BACKEND_CONTAINER_NAME = "backend-container"
        FRONTEND_CONTAINER_NAME = "frontend-container"
        BACKEND_CONTAINER_PORT = "8080"
        FRONTEND_CONTAINER_PORT = "80"
    }
    
    stages {
        stage('Build Backend Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'your-registry-creds', usernameVariable: 'DOCKER_REGISTRY_USERNAME', passwordVariable: 'DOCKER_REGISTRY_PASSWORD')]) {
                        def backendImage = docker.build("${DOCKER_REGISTRY}/backend:${env.BUILD_NUMBER}", "./backend")
                        docker.withRegistry("${DOCKER_REGISTRY}", "docker") {
                            backendImage.push()
                        }
                        sh "aws ecs update-service --cluster ${ECS_CLUSTER_NAME} --service ${BACKEND_TASK_FAMILY} --force-new-deployment --region ${AWS_DEFAULT_REGION} --task-definition ${BACKEND_TASK_FAMILY}:${env.BUILD_NUMBER}"
                    }
                }
            }
        }
        
        stage('Build Frontend Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'your-registry-creds', usernameVariable: 'DOCKER_REGISTRY_USERNAME', passwordVariable: 'DOCKER_REGISTRY_PASSWORD')]) {
                        def frontendImage = docker.build("${DOCKER_REGISTRY}/frontend:${env.BUILD_NUMBER}", "./frontend")
                        docker.withRegistry("${DOCKER_REGISTRY}", "docker") {
                            frontendImage.push()
                        }
                        sh "aws ecs update-service --cluster ${ECS_CLUSTER_NAME} --service ${FRONTEND_TASK_FAMILY} --force-new-deployment --region ${AWS_DEFAULT_REGION} --task-definition ${FRONTEND_TASK_FAMILY}:${env.BUILD_NUMBER}"
                    }
                }
            }
        }
    }
}
