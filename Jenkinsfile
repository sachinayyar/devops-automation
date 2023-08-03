appName = "devops-automation"
pipeline {
    agent any
    environment{
        mvnHome = tool 'M3'
    }
    stages {
        stage('checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sachinayyar/devops-automation.git'
            }
        }
        stage('maven-build') {
            steps {
                sh "${mvnHome}/bin/mvn -f pom.xml clean install -DskipTests"
            }
        }
        stage('image-build') {
            steps {
                  def builds = openshift.selector("bc", devops-automation).related('builds')
                }
                }
}
}
