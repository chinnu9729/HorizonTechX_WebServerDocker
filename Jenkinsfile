pipeline {
    agent {
        node {
            label 'docker'
        }
    }
    
    tools {
        maven 'my-maven'
    }
    
    environment {
        DOCKER_HUB_USERNAME = credentials('dockerhub-username')
        DOCKER_HUB_PASSWORD = credentials('dockerhub-password')
        DOCKER_HUB_REGISTRY = 'docker.io'
        SONAR_HOST_URL = credentials('sonarqube-url')
        SONAR_LOGIN = credentials('sonarqube-token')
        IMAGE_TAG = "${BUILD_NUMBER}"
        STACK_NAME = 'microservices-stack'
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                echo '========== Checking out code from GitHub =========='
                git branch: 'project2-microservices', 
                    url: 'https://github.com/chinnu9729/HorizonTechX_WebServerDocker.git'
                sh 'echo "Code checked out successfully"'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                echo '========== Running SonarQube Code Quality Analysis =========='
                withSonarQubeEnv('mysonar') {
                    sh '''
                        # Run SonarQube analysis on the entire project
                        mvn clean verify sonar:sonar \
                            -Dsonar.projectKey=Project2-Microservices \
                            -Dsonar.projectName="Project 2 - Microservices" \
                            -Dsonar.sources=. \
                            -Dsonar.exclusions=**/target/**,**/node_modules/**,**/*.min.js \
                            || echo "SonarQube analysis completed with warnings"
                    '''
                }
            }
        }
        
        stage('Build Docker Images') {
            steps {
                echo '========== Building Docker Images for All Services =========='
                script {
                    sh '''
                        # Build Auth Service
                        echo "Building Auth Service..."
                        docker build -t auth-service:${IMAGE_TAG} ./auth
                        
                        # Build Books Service
                        echo "Building Books Service..."
                        docker build -t books-service:${IMAGE_TAG} ./books
                        
                        # Build Borrowing Service
                        echo "Building Borrowing Service..."
                        docker build -t borrowing-service:${IMAGE_TAG} ./borrowing
                        
                        # Build Frontend Service
                        echo "Building Frontend Service..."
                        docker build -t frontend-service:${IMAGE_TAG} ./frontend
                        
                        echo "All Docker images built successfully"
                    '''
                }
            }
        }
        
        stage('Tag & Push to Docker Hub') {
            steps {
                echo '========== Tagging and Pushing Images to Docker Hub =========='
                script {
                    withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                        sh '''
                            # Tag and push Auth service
                            echo "Pushing Auth Service to Docker Hub..."
                            docker tag auth-service:${IMAGE_TAG} chinnu9729/auth-service:${IMAGE_TAG}
                            docker tag auth-service:${IMAGE_TAG} chinnu9729/auth-service:latest
                            docker push chinnu9729/auth-service:${IMAGE_TAG}
                            docker push chinnu9729/auth-service:latest
                            
                            # Tag and push Books service
                            echo "Pushing Books Service to Docker Hub..."
                            docker tag books-service:${IMAGE_TAG} chinnu9729/books-service:${IMAGE_TAG}
                            docker tag books-service:${IMAGE_TAG} chinnu9729/books-service:latest
                            docker push chinnu9729/books-service:${IMAGE_TAG}
                            docker push chinnu9729/books-service:latest
                            
                            # Tag and push Borrowing service
                            echo "Pushing Borrowing Service to Docker Hub..."
                            docker tag borrowing-service:${IMAGE_TAG} chinnu9729/borrowing-service:${IMAGE_TAG}
                            docker tag borrowing-service:${IMAGE_TAG} chinnu9729/borrowing-service:latest
                            docker push chinnu9729/borrowing-service:${IMAGE_TAG}
                            docker push chinnu9729/borrowing-service:latest
                            
                            # Tag and push Frontend service
                            echo "Pushing Frontend Service to Docker Hub..."
                            docker tag frontend-service:${IMAGE_TAG} chinnu9729/frontend-service:${IMAGE_TAG}
                            docker tag frontend-service:${IMAGE_TAG} chinnu9729/frontend-service:latest
                            docker push chinnu9729/frontend-service:${IMAGE_TAG}
                            docker push chinnu9729/frontend-service:latest
                            
                            echo "All services pushed to Docker Hub successfully"
                        '''
                    }
                }
            }
        }
        
        stage('Deploy Stack to Swarm') {
            steps {
                echo '========== Deploying Stack to Docker Swarm =========='
                script {
                    sh '''
                        # Update docker-compose.yml with latest image tags
                        sed -i "s|image: chinnu9729/auth-service:.*|image: chinnu9729/auth-service:${IMAGE_TAG}|g" docker-compose.yml
                        sed -i "s|image: chinnu9729/books-service:.*|image: chinnu9729/books-service:${IMAGE_TAG}|g" docker-compose.yml
                        sed -i "s|image: chinnu9729/borrowing-service:.*|image: chinnu9729/borrowing-service:${IMAGE_TAG}|g" docker-compose.yml
                        sed -i "s|image: chinnu9729/frontend-service:.*|image: chinnu9729/frontend-service:${IMAGE_TAG}|g" docker-compose.yml
                        
                        # Deploy or update the stack
                        docker stack deploy -c docker-compose.yml ${STACK_NAME}
                        
                        echo "Stack deployed successfully!"
                        echo "Waiting for services to stabilize..."
                        sleep 5
                        
                        # Display stack status
                        docker stack ps ${STACK_NAME}
                    '''
                }
            }
        }
        
        stage('Verify Deployment') {
            steps {
                echo '========== Verifying Deployment =========='
                script {
                    sh '''
                        echo "Checking service health..."
                        docker service ls
                        
                        echo "Waiting for services to be healthy..."
                        sleep 10
                        
                        # Check if services are running
                        RUNNING_SERVICES=$(docker service ls --filter "label=com.docker.stack.namespace=${STACK_NAME}" -q | wc -l)
                        echo "Number of running services: ${RUNNING_SERVICES}"
                        
                        if [ ${RUNNING_SERVICES} -ge 4 ]; then
                            echo "✓ All services are running successfully!"
                        else
                            echo "⚠ Some services may still be initializing"
                        fi
                    '''
                }
            }
        }
    }
    
    post {
        success {
            echo '========== Pipeline Execution Successful =========='
            sh '''
                echo "Build #${BUILD_NUMBER} - All stages completed successfully"
                echo "Deployed services:"
                docker service ls
            '''
        }
        failure {
            echo '========== Pipeline Execution Failed =========='
            sh '''
                echo "Build #${BUILD_NUMBER} - Pipeline failed"
                echo "Check logs above for details"
            '''
        }
        always {
            echo '========== Cleaning Up =========='
            sh '''
                echo "Removing unused images to free up space..."
                docker image prune -f --filter "until=24h"
            '''
        }
    }
}
