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
    repo = "khal3d/hello-app"
    localCRIRegistry = "cri-registry-docker-registry.tools.svc.cluster.local:5000"
  }
  
  stages {

    stage('kaniko-build') {
      steps {
        configs()
        container('kaniko') {
          sh '''
          /kaniko/executor --context `pwd` --dockerfile `pwd`/Dockerfile\
          --cache=true --cache-repo=${localCRIRegistry}/${repo}\
          --destination=${localCRIRegistry}/${repo}:${version}\
          --destination=${repo}:${timestamp}-${version}\
          --destination=${repo}:${version}\
          --destination=${repo}:latest
          '''
        }
      }
    }
    
    stage('helm-deploy') {
      steps {
        configs()
        container('helm') {
          sh 'helm -n default list'
          sh "helm lint ./helm"
          sh "helm -n default upgrade --install --wait --timeout 60s --set image.tag=${version} hello-app ./helm"
          sh "helm -n default get values hello-app"
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
