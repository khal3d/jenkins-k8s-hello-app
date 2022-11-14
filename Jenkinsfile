pipeline {
  agent any {
    kubernetes {
      yamlFile 'JenkinsSlaveK8SPod.yaml'
      idleMinutes 5
    }
  }
  
  stages {
    stage('build') {
      steps {
        sh 'php --version'
      }
    }
  }
}
