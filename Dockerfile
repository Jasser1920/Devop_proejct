# Étape 1 : Image de base avec Java 17
FROM openjdk:17-jdk-slim

# Créer un répertoire dans le conteneur
WORKDIR /app

# Copier le JAR généré par Maven
COPY target/*.jar app.jar

# Exposer le port (par défaut Spring Boot = 8080)
EXPOSE 8080

# Commande de démarrage
ENTRYPOINT ["java", "-jar", "app.jar"]
