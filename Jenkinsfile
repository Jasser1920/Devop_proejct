pipeline {
    agent any

    tools {
        maven 'Maven'           // ← vérifie le nom exact dans Manage Jenkins → Tools
        jdk   'JDK17'           // ← si tu as configuré un JDK dans Jenkins, sinon supprime cette ligne
    }

    environment {
        // Profil H2 pour que les tests passent sans MySQL
        SPRING_PROFILES_ACTIVE = 'prod'

        // Configuration SonarQube (obligatoire)
        SONAR_HOST_URL = 'http://10.0.2.15:9000'  // ← Remplace par l'IP de ta machine Jenkins/Sonar
        SONAR_TOKEN    = credentials('sonarqube-token')  // on créera cette credential juste après
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
                echo 'Compilation + tests unitaires'
                sh 'mvn clean verify'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Analyse SonarQube en cours...'
                sh '''
                    mvn sonar:sonar \
                      -Dsonar.projectKey=Devop_proejct \
                      -Dsonar.host.url=${SONAR_HOST_URL} \
                      -Dsonar.login=${SONAR_TOKEN} \
                      -Dsonar.projectName="Student Management - Jasser" \
                      -Dsonar.qualitygate.wait=true
                '''
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }
    }

    post {
        always {
            echo '=== Pipeline terminé ==='
        }
        success {
            echo '
            EXCELLENT JASSER !
            Build + Tests + SonarQube → TOUT VERT !
            Va voir ton rapport sur http://10.0.2.15:9000'
                
        }
        failure {
            echo 'Échec du pipeline – regarde les logs !'
        }
    }
}
