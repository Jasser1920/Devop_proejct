pipeline {
    agent any

    tools {
        maven 'Maven'   // nom exact dans Manage Jenkins → Tools
    }

    environment {
        SPRING_PROFILES_ACTIVE = 'prod'   // ← c'est ce qui active application-prod.properties
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Récupération du code...'
                git branch: 'main',
                    url: 'https://github.com/Jasser1920/Devop_proejct.git',
                    credentialsId: 'jenkins-github-pat'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean verify -Dspring.profiles.active=prod'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        mvn sonar:sonar \
                          -Dsonar.projectKey=Devop_proejct \
                          -Dsonar.host.url=http://10.0.2.15:9000 \
                          -Dsonar.token=${SONAR_TOKEN} \
                          -Dsonar.qualitygate.wait=true
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'TOUT EST VERT JASSER ! Build + Tests + SonarQube OK !'
        }
        failure {
            echo 'Échec – corrige application-prod.properties'
        }
    }
}
