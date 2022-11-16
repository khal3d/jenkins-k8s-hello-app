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
    stage('kaniko-build') {
      steps {
        configs()
        container('kaniko') {
          sh '''
          /kaniko/executor --context `pwd` --dockerfile `pwd`/Dockerfile --cache=true --cache-repo=${registry} --destination=${registry}:${timestamp}-${version} --destination=${registry}:latest
          '''
        }
      }
    }
    
  }
}



def configs(){
    script{
        env.timestamp=sh(script: 'date "+%Y%m%d%H%M%S"',  returnStdout: true).trim()
    }
}
