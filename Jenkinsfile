pipeline {
  agent any
  stages {
    stage('docker build') {
      steps {
        sh 'docker build -t ${DOCKER_REGISTRY_HOST}/${NAME}:${TAG} .'
      }
    }
    stage('docker push') {
      steps {
        sh 'docker login -u ${DOCKER_REGISTRY_CREDS_USR} -p ${DOCKER_REGISTRY_CREDS_PSW} ${DOCKER_REGISTRY_HOST}'
        sh 'docker push ${DOCKER_REGISTRY_HOST}/${NAME}:${TAG}'
      }
    }
    stage('deploy') {
      agent {
        docker {
          image 'lwolf/helm-kubectl-docker'
        }

      }
      steps {
        sh 'mkdir -p ~/.kube'
        sh 'echo ${K8S_CONFIG} | base64 -d > ~/.kube/config'
        sh 'sed -i "s#{{IMAGE}}#${DOCKER_REGISTRY_HOST}/${NAME}:${TAG}#g" ./kubernetes.yaml'
        sh 'cat ./kubernetes.yaml'
        sh 'kubectl get pod | wc -l'
        sh 'kubectl delete -f ./kubernetes.yaml > /dev/null 2>&1'
        sh 'kubectl apply -f ./kubernetes.yaml'
        sh 'kubectl get -f ./kubernetes.yaml'
      }
    }
  }
  environment {
    DOCKER_REGISTRY_CREDS = credentials('docker-hub-registry-auth-id')
    K8S_CONFIG = credentials('kubernetes-config-secret-id')
    DOCKER_REGISTRY_HOST = 'docker.io'
    NAME = 'tomoncleshare/jenkins-python'
    TAG = 'v1.0'
  }
}
