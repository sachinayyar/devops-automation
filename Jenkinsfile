#! /usr/bin/env groovy

pipeline {

  agent {
    label 'maven'
  }

  stages {
    stage('Build') {
      steps {
        echo 'Building..'
        
        sh 'mvn clean package'
      }
    }
    stage('Create Container Image') {
      steps {
        echo 'Create Container Image..'
        
        script {

          openshift.withCluster() { 
  openshift.withProject("jenkins") {
  
    def buildConfigExists = openshift.selector("bc", "codelikethewind").exists() 
    
    if(!buildConfigExists){ 
      openshift.newBuild("--name=codelikethewind", "--docker-image=quay.io/sachinayyar/jen-pipeline", "--binary") 
    } 
    
    openshift.selector("bc", "codelikethewind").startBuild("--from-file=target/devops-integration.jar", "--follow") } }

        }
      }
    }


       
  }
}
