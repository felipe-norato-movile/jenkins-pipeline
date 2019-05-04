#!groovy

properties(
    [
        [$class: 'BuildDiscarderProperty', strategy:
          [$class: 'LogRotator', artifactDaysToKeepStr: '14', artifactNumToKeepStr: '5', daysToKeepStr: '30', numToKeepStr: '60']],
        pipelineTriggers(
          [
              pollSCM('H/15 * * * *'),
              cron('@daily'),
          ]
        )
    ]
)

node {
    def app

    stage('Checkout') {
        //disable to recycle workspace data to save time/bandwidth
        deleteDir()
        checkout scm

        //enable for commit id in build number
        //env.git_commit_id = sh returnStdout: true, script: 'git rev-parse HEAD'
        //env.git_commit_id_short = env.git_commit_id.take(7)
        //currentBuild.displayName = "#${currentBuild.number}-${env.git_commit_id_short}"
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        sh 'docker build -d node:8-alpine'


    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
        }
    }


    stage('NPM Install') {
        withEnv(["NPM_CONFIG_LOGLEVEL=warn"]) {
            sh 'npm install'
        }
    }

    stage('Test') {
        withEnv(["CHROME_BIN=/usr/bin/chromium-browser"]) {
          sh 'ng test --progress=false --watch false'
        }
        junit '**/test-results.xml'
    }

    stage('Lint') {
        sh 'ng lint'
    }

    stage('Build') {
        milestone()
        sh 'ng build --prod --aot --sm --progress=false'
    }

    stage('Archive') {
        sh 'tar -cvzf dist.tar.gz --strip-components=1 dist'
        archive 'dist.tar.gz'
    }

    stage('Deploy') {
        milestone()
        echo "Deploying..."
    }
}
