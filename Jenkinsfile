pipeline {
  agent {
    kubernetes {
      yamlFile 'JenkinsSlaveK8SPod.yaml'
      idleMinutes 5
    }
  }
  
  environment {
    app = "hello-app"
    version = "1.0.0-snapshot"
    registry = "khal3d/hello-app"
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
          /kaniko/executor --cache=true --cache-ttl=6h --context `pwd` --dockerfile `pwd`/Dockerfile --destination=${registry}:${timestamp}-${version}
          '''
        }
      }
    }
    
  }
}


