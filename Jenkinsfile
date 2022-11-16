pipeline {
  agent {
    kubernetes {
      yamlFile 'JenkinsSlaveK8SPod.yaml'
      idleMinutes 5
    }
  }
  
  environment {
    app = "hello-app"
    version="revision-${env.GIT_COMMIT[0..6]}"
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
    
    stage('helm-deploy') {
      steps {
        configs()
        container('helm') {
          sh '''
          ls -alh
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
