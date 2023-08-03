pipeline {
    agent any

    environment {
        // Set your OpenShift credentials
        OPENSHIFT_CREDENTIALS = credentials('jenkins-dockercfg-dmqq2')
        OPENSHIFT_PROJECT = 'jenkins'
        OPENSHIFT_APP_NAME = 'devops-automation'
        DOCKER_REGISTRY_CREDENTIALS = credentials('docker-hub')
        DOCKER_IMAGE_NAME = 'docker.io/ayyarsachin/jen-pipeline'
        DOCKER_IMAGE_TAG = 'latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Assuming you have your source code in a Git repository
                // Replace the repository URL with your actual repository URL
                echo "checkout"
            }
        }

        stage('Build Maven Project') {
            steps {
                // Assuming you have a Maven `pom.xml` in the root of your repository
                // Replace the goals and options with your specific Maven build commands
                sh 'mvn clean package'
            }
        }

        stage('Build Image') {
            steps {
                script {
                    // Log in to OpenShift using the provided credentials
                    openshift.withCluster(credentials: OPENSHIFT_CREDENTIALS) {
                        openshift.withProject(OPENSHIFT_PROJECT) {
                            // Build the Docker image using S2I (Source-to-Image) strategy
                            openshiftBuild(buildConfig: OPENSHIFT_APP_NAME, showBuildLogs: 'true', waitTime: '10000')
                        }
                    }
                }
            }
        }

        stage('Push Image to Registry') {
            steps {
                // Assuming you want to push the image to a Docker registry
                // Replace the registry URL and credentials with your actual ones
                withCredentials([string(credentialsId: DOCKER_REGISTRY_CREDENTIALS, variable: 'DOCKER_CREDS')]) {
                    sh "docker login -u your-docker-username -p \$DOCKER_CREDS your-docker-registry"
                    sh "docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} your-docker-registry/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    sh "docker push your-docker-registry/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        }
    }

    post {
        always {
            // Clean up and delete resources
            script {
                openshift.withCluster(credentials: OPENSHIFT_CREDENTIALS) {
                    openshift.withProject(OPENSHIFT_PROJECT) {
                        openshift.deleteBuildConfig(OPENSHIFT_APP_NAME)
                    }
                }
            }
        }
    }
}
