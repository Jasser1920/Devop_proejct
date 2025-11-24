pipeline {
    agent any

    tools {
        // Change ici avec le nom EXACT que tu vois dans 
        // Manage Jenkins → Tools → Maven installations
        // La plupart du temps c’est "Maven" ou "maven-3.9.6" ou "M3"
        maven 'Maven'      // ← à vérifier/adapter si besoin
    }

    environment {
        // Ce profil sera activé automatiquement sur Jenkins
        SPRING_PROFILES_ACTIVE = 'prod'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Récupération du code GitHub'
                git branch: 'main',
                    url: 'https://github.com/Jasser1920/Devop_proejct.git',
                    credentialsId: 'jenkins-github-pat'
            }
        }

        stage('Build & Test') {
            steps {
                echo 'Lancement de Maven : compilation + tests'
                // On ne skippe plus les tests : on veut que ça passe vraiment
                sh 'mvn clean verify'
            }
        }

        stage('Packaging') {
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
            SUCCESS
            BRAVO JASSER ! Ton pipeline est VERT sur Jenkins !'
        }
        failure {
            echo 'ÉCHEC – regarde les logs ci-dessus pour corriger'
        }
    }
}
