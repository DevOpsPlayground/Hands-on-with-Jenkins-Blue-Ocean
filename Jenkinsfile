pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Initiating maven build'
        sh 'mvn clean install -Dlicense.skip=true'
        echo 'Maven build complete'
      }
    }

    stage('Testing') {
          parallel {
            stage('SonarQube Test') {
            steps {
              echo 'Initiating SonarQube test'
              sh 'mvn sonar:sonar -Dsonar.host.url=http://<IP address>:8081 -Dlicense.skip=true'
              echo 'SonarQube test Complete'
            }
          }

            stage('Print Tester credentials') {
              steps {
                sleep 10
                echo "The tester is ${TESTER}"
              }
            }
            stage('Print Build Number') {
              steps {
                sleep 20
                echo "This is build number ${BUILD_ID}"
              }
            }
          }
        }

    stage('JFrog Push') {
      steps {
        echo 'Starting JFrog push'
        script {
          def server = Artifactory.server "artifactory"
          def buildInfo = Artifactory.newBuildInfo()
          def rtMaven = Artifactory.newMavenBuild()

          rtMaven.tool = 'maven'
          rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'

          buildInfo = rtMaven.run pom: 'pom.xml', goals: "clean install -Dlicense.skip=true"
          buildInfo.env.capture = true
          buildInfo.name = 'jpetstore-6'
          server.publishBuildInfo buildInfo
        }
echo 'JFrog push complete'
    }
}
    stage('Deploy prompt') {
      steps {
        input 'Deploy to Production?'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Initiating Deployment'
        echo 'Deployment Complete'
      }
    }
  }
  tools {
    maven 'maven'
  }
  environment {
    TESTER = 'placeholder'
  }
}
