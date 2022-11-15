pipeline {
  agent {
    kubernetes {
      yamlFile 'JenkinsSlaveK8SPod.yaml'
      idleMinutes 5
    }
  }
  
  stages {
    stage('pre-build') {
      steps {
        container('hello-php') {
          sh '''
          php -v
          echo "<?php phpinfo();" > hello.php
          ls -alh
          '''
        }
      }
    }
    
    
    stage('kaniko-build') {
      steps {
        container('kaniko') {
          sh '''
          ls -alh
          /kaniko/executor -h
          '''
        }
      }
    }
    
    
  }
}


