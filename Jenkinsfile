pipeline {
    agent any

    tools {
        maven 'Maven'   // vérifie que c’est bien ce nom dans Manage Jenkins → Tools
    }

    environment {
        // Profil H2 pour éviter l'erreur MySQL
        SPRING_PROFILES_ACTIVE = 'prod'

        // IP exacte de ta VM Ubuntu (celle que tu viens de trouver)
        SONAR_HOST_URL = 'http://10.0.2.15:9000'

        // Token SonarQube (on le récupère via credentials Jenkins)
        SONAR_TOKEN = credentials('sonarqube-token')
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Récupération du code depuis GitHub'
                git branch: 'main',
                    url: 'https://github.com/Jasser1920/Devop_proejct.git',
                    credentialsId: 'jenkins-github-pat'
            }
        }

        stage('Build & Test') {
            steps {
                echo 'Compilation + tests unitaires (H2 en mémoire)'
                sh 'mvn clean verify'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Envoi du code à SonarQube pour analyse qualité'
                sh '''
                    mvn sonar:sonar \
                      -Dsonar.projectKey=Devop_proejct \
                      -Dsonar.projectName="Student Management - Jasser" \
                      -Dsonar.host.url=${SONAR_HOST_URL} \
                      -Dsonar.token=${SONAR_TOKEN} \
                      -Dsonar.qualitygate.wait=true
                '''
            }
        }

        stage('Package') {
            steps {
                echo 'Génération du JAR final'
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
            PARFAIT JASSER !
            Build réussi
            Tests OK
            Rapport SonarQube envoyé avec succès
            Va voir ton projet ici → http://10.0.2.15:9000'
        }
        failure {
            echo 'Échec – regarde les logs ci-dessus'
        }
    }
}
