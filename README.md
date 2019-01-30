# Continuous Integration with Blue Ocean
![](images/BlueOceanOverview.png)

- [Overview](#overview)
- [Hands On](#hands-on)
    - [Pre-check](#pre-check)
        - [Check Jenkins is running](#check-jenkins-is-running)
        - [Check Artifactory is running](#check-artifactory-is-running)
        - [Check Sonarqube is running](#check-sonarqube-is-running)
    - [Setup](#setup)
        - [Fork the JPetstore Repository](#fork-the-jpetstore-repository)
        - [Prepare the JPetstore pom file](#prepare-the-jpetstore-pom-file)
        - [Prepare Artifactory](#prepare-artifactory)
        - [Prepare Jenkins](#prepare-jenkins)
    - [Building the Pipeline](#building-the-pipeline)
        - [Connecting Jenkins to the GitHub Repository](#connecting-jenkins-to-the-github-repository)
        - [Defining the Jenkinsfile](#defining-the-jenkinsfile)
- [Conclusion](#conclusion)
- [Jenkins training](#jenkins-training)
- [Resources](#resources)
- [Appendix](#appendix)
    - [Setting up the Playground Environment](#setting-up-the-playground-environment)
    - [Tearing down the Playground Environment](#tearing-down-the-playground-environment)
    - [Jenkinsfile code](#jenkinsfile-code)

# Overview

Cloudbees Jenkins is the most popular open source software orchestration tool on the market due to its wealth of plugins and easy set-up of infrastructure as code. Yet where does one begin using the Jenkinsfile for setting up new project and DevOps pipeline?

Let Blue Ocean take the hassle of setting up a Jenkinsfile from scratch by providing an intuitive, modern coat of paint on Jenkins user interface. With its modern design and intuitive features, Blue Ocean is here to facilitate a quick and easy setup of new Jenkins pipeline with minimal hassle.

In this playground, we will see how easy it is to set up a new Jenkins maven Job using the Blue Ocean plugin and the intuitive feedback it provides through its modern design.


# Hands-on

## Pre-check

### Check Jenkins is running

In a separate tab, navigate to http://\<IP\>:8080 and confirm Jenkins is up.

![](images/JenkinsMainPageBase.png)

### Check Artifactory is running

In a separate tab, navigate to http://\<IP\>:8081 and confirm Artifactory is up.

![](images/ArtifactoryMainPage.png)

(If you wish to login, default username and password is admin/password)

### Check SonarQube is running

In a separate tab, navigate to http://\<IP\>:8081 and confirm SonarQube is up.

![](images/SonarqubeMainPage.png)

(If you wish to login, default username and password is admin/password)

## Setup

### Fork the JPetstore Repository

1. Log into GitHub

2. Fork the [JPetstore repository](https://github.com/mybatis/jpetstore-6)

![](images/GithubJpetstoreRepo.png)

### Prepare the JPetstore pom file

Updates to the JPetstore pom file have been known to build errors. To pre-empt one such error, please remove **-SNAPSHOT** from the version field of the parent.

![](images/PetstorePomXml.png)

### Prepare Artifactory

1. Go to Artifactory and login as admin; admin/password

2. Go to the admin section on the left of the interface and click local

    ![](images/ArtifactoryAdminPage.png)

3. Create 2 new maven repositories with the repository Key field as **libs-snapshot-local** and **libs-release-local** respectively. You may leave the rest of the fields as is.

![](images/ArtifactoryNewRepo.png)

### Prepare Jenkins

1. In the Jenkins tab, click Manage Jenkins

    ![](images/JenkinsMainPageManageJenkins.png)

2. Click Configure Systems and scroll to the Artifactory subsection

    ![](images/JenkinsConfigureSystem.png)

3. Fill in the fields as follow:

  * Server ID: artifactory (all lowercase)
  * URL: http://<Ip address>:8081/artifactory
  * Username: admin
  * Password: password

    ![](images/JenkinsArtifactoryConfiguration.png)

4. Return back to Manage Jenkins page, click the Global Tool Configuration and scroll to the Maven subsection.

    ![](images/JenkinsGlobalToolConfiguration.png)

5. Fill in the fields as follow:

  * Name: maven (all lowercase)
  * MAVEN_HOME: /var/lib/apache-maven-3.6.0

![](images/JenkinsMavenToolConfiguration.png)

## Building the Pipeline

### Connecting Jenkins to the GitHub Repository

1. Click Open Blue ocean

    ![](images/JenkinsMainPageBlueOcean.png)

2. Click login on the top right with the credentials admin/password

3. Click Create a new pipeline

    ![](images/BlueOceanMainPage.png)

4. Select GitHub and click 'create an access token here'

    ![](images/BlueOceanCreatePipeline1.png)

  * You may need to log in to your GitHub account again

5. Fill in an appropriate description such as 'Playground_token'. You may review the permissions this token permits. Click Generate token when done

    ![](images/GithubAccessTokenCreation.png)

6. Copy the newly created token to the clipboard and paste it into Jenkins

    ![](images/GithubTokenPage.png)

7. After clicking connect, select the organisation you forked the JPetstore repository into.

    ![](images/BlueOceanCreatePipeline2.png)

8. Select the JPetstore repository

    ![](images/BlueOceanCreatePipeline3.png)

9. Click Create Pipeline and wait for Jenkins to create the Jenkinsfile

    ![](images/BlueOceanPipelinePage.png)

### Defining the Jenkinsfile

1. Click the plus sign and name the stage 'Build'

2. Click Add steps to create the steps for the stages

3. Select 'shellscript' and copy the following command: `mvn clean install -Dlicense.skip=true`

  * You may include Print message steps for ease of viewing and logging

    ![](images/BlueOceanPipelineBuild1.png)

4. Create a new stage called 'Testing' with the following 'shellscript' step command: `mvn sonar:sonar -Dsonar.host.url=http://<IP address>:8081 -Dlicense.skip=true`

5. To introduce parallel stages, click the plus sign beneath the testing stage

    ![](images/BlueOceanPipelineBuild2.png)

6. Before continuing, click the dot representing testing and rename it to 'SonarQube Test'

    ![](images/BlueOceanPipelineBuild3.png)

7. Select the newly created parallel stage and name it 'Print Tester Credentials' with steps 'Print message' with `The tester is ${TESTER}` and 10s sleep.

    ![](images/BlueOceanPipelineBuild4.png)

9. Create another parallel stage called 'Print build number', with steps 'Print message' with `This is build number ${BUILD_ID}` and 20s sleep.

    ![](images/BlueOceanPipelineBuild5.png)

10. Bring up the pipeline editor by pressing ctrl+s for window users and command+s for MacOS users.

11. Replace the single quotes of the previous 2 print steps, seen as echo in the Jenkinsfile, with double quotes

  * Without this step, Jenkins will be unable to inject Environmental values into the Build.

12. Add the maven tool definition before the final curly brace in the Jenkinsfile; `tools {maven 'maven'}`

    ![](images/BlueOceanPipelineBuild6.png)

13. Click Update to close the editor

14. Create an environmental value using the interface on the right with the fields for 'Name' and 'Value' as 'TESTER' and 'your name' respectively

    ![](images/BlueOceanPipelineBuild7.png)

15. Create a new stage called JFrog push and search for the 'Run arbitrary Pipeline script’ step and insert the following code

    ```
    def server = Artifactory.server "artifactory"
    def buildInfo = Artifactory.newBuildInfo()
    def rtMaven = Artifactory.newMavenBuild()

    rtMaven.tool = 'maven'
    rtMaven.deployer server: server, releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local'

    buildInfo = rtMaven.run pom: 'pom.xml', goals: "clean install -Dlicense.skip=true"
    buildInfo.env.capture = true
    buildInfo.name = 'jpetstore-6'
    server.publishBuildInfo buildInfo
    ```

    ![](images/BlueOceanPipelineBuild8.png)

16. Add a new stage called 'Deploy prompt', selecting the 'Wait for interactive input' as the step, with the message field filled as 'Deploy to Production?'

    ![](images/BlueOceanPipelineBuild9.png)

17. For the final stage, name it Deployment and add placeholder 'Print message' steps.

    ![](images/BlueOceanPipelineBuild10.png)

18. To save and upload the Jenkinsfile to the GitHub repository, click Save on the top right, with an appropriate description for the change like 'initial Jenkinsfile creation'.

19. Click save and run to upload the file and trigger the Jenkins Build.

    ![](images/BlueOceanPipelineBuild10.png)

20. When completed, you may go to the respective URLs for Artifactory and SonarQube to see the Artefacts and test results respectively.

# Conclusion

In this playground we had an environment containing a build server (Jenkins) and a code review platform (SonarQube), along with another server containing a package repository (Artifactory). We built a CI pipeline using the Blue Ocean plugin and saved it as code; pipeline as code. We also saw how to inject custom and pre-determined Jenkins Environmental values into the script.

There are plenty of options available for building on top of the playground such as:

* Preparing a proper Deployment stage to automate the deployment process of the Jenkins Project.
* Setting up email notifications that automatically gets triggered and sent when a job succeeds or fails.
* Implement other automated testing stages to run in parallel to the SonarQube test.
* Run the build processes in other Operating systems and using other Java versions in parallel.

# Jenkins Training

If you would like to further your knowledge with the Jenkins product suite. Consider booking a training course with one of ECS Digital certified Jenkins trainers.

For more information check out the link below:

https://ecs-digital.co.uk/what-we-do/training

# Resources
### Hashicorp Terraform

Product Details
https://www.terraform.io/

Documentation
https://www.terraform.io/docs/index.html


### Jenkins

Product Details
https://jenkins.io/

Documentation
https://jenkins.io/doc/


### Blue Ocean

Product Details
https://jenkins.io/projects/blueocean/

Documentaion
https://jenkins.io/doc/book/blueocean/


### Artifactory

Product Details
https://jfrog.com/artifactory/

Documentation
https://www.jfrog.com/confluence/pages/viewpage.action?pageId=46107472


### SonarQube

Product Details
https://www.sonarqube.org/

Documentation
https://docs.sonarqube.org/latest/


### Maven

Product Details
https://maven.apache.org/

Documentation
https://maven.apache.org/guides/index.html


# Appendix

### Setting up the Playground Environment

Ensure you have the latest version of terraform installed.

Set the following environment variables:

```
$export AWS_ACCESS_KEY_ID=<YOUR KEY ID>
$export AWS_SECRET_ACCESS_KEY=<YOUR ACCESS KEY>
```

Navigate to the _setup directory and execute:

```
$terraform init
```

Then execute:
```
$terraform plan
```

Finally, apply the plan:

```
$terraform apply
```


### Tearing down the Playground Environment

Navigate to the _setup directory and execute:

```
$terraform destroy
```

### Jenkinsfile code

```
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


```
