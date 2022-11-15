pipeline {
  agent {
    kubernetes {
      yamlFile 'JenkinsSlaveK8SPod.yaml'
      idleMinutes 5
    }
  }
  
  environment {
      APP="hello-app"
      VERSION="1.0.0-snapshot"
  }
  stages {
    stage('pre-build') {
      steps {
        container('hello-php') {
          sh '''
          echo "<?php phpinfo();" > hello.php
          '''
        }
      }
    }

    stage('kaniko-build') {
      steps {
        container('kaniko') {
          sh '''
          ls -alh /kaniko/.docker
          /kaniko/executor --context `pwd` --dockerfile `pwd`/Dockerfile --destination=khal3d/${APP}:${timestamp}-${VERSION}
          '''
        }
      }
    }
    
  }
}


