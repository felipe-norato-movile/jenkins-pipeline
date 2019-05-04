pipeline {

  agent none
  stages {

    agent {
      docker {
        image 'node:8-alpine'
      }
    }

    stage('Fetch dependencies') {

      steps {
        sh 'yarn'
        stash includes: 'node_modules/', name: 'node_modules'
      }
    }


    stage('Build') {

      steps {
        unstash 'node_modules'
        sh 'yarn build'
        stash includes: 'dist/', name: 'dist'
      }
    }
  }
}
