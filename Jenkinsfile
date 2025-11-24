pipeline {
    agent any

    tools {
        maven 'Maven'    // le nom exact que ton prof a configuré dans "Global Tool Configuration"
    }

    environment {
        // On force le profil H2 uniquement sur Jenkins
        SPRING_PROFILES_ACTIVE = 'prod'   // ou 'ci' si tu as nommé le fichier application-ci.properties
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',  // ou 'main'
                    url: 'https://github.com/Jasser1920/Devop_proejct.git',
                    credentialsId: 'jenkins-github-pat'   // à créer si besoin
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean verify'  
                // ou si tu veux être encore plus safe :
                // sh 'mvn clean verify -Dspring.profiles.active=prod'
            }
        }
    }

    post {
        always {
            echo "=== Fin du pipeline ==="
        }
        success {
            echo "BRAVO ! Le build a réussi"
        }
        failure {
            echo "Échec du build"
        }
    }
}
