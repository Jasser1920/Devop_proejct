pipeline {
    agent any

    stages {
        stage('Récupération du code') {
            steps {
                echo '=== Récupération du code depuis GitHub ==='
                git url: 'https://github.com/Jasser1920/Devop_proejct.git', 
                    branch: 'main'
            }
        }

        stage('Compilation') {
            steps {
                echo '=== Compilation du projet Maven ==='
                sh 'mvn compile'
            }
        }

        stage('Tests unitaires') {
            steps {
                echo '=== Exécution des tests unitaires ==='
                sh 'mvn test'
            }
        }

        stage('Packaging') {
            steps {
                echo '=== Création du JAR ==='
                sh 'mvn package'
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminé avec succès !'
            archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
        }
        failure {
            echo 'Échec du pipeline - corrigez les erreurs'
        }
    }
}
