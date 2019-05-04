pipeline {

  agent none

  stages {

    stage('Fetch dependencies') {
      agent {
        docker 'node:8-alpine'
      }
      steps {
        sh 'yarn'
        stash includes: 'node_modules/', name: 'node_modules'
      }
    }


    stage('Build') {
      agent {
        docker 'node:8-alpine'
      }
      steps {
        unstash 'node_modules'
        sh 'yarn build'
        stash includes: 'dist/', name: 'dist'
      }
    }
  }
}
