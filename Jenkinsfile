pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/logan-177/SpringbootFinal.git'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Upload to Nexus') {
            steps {
                sh '''
                curl -v -u admin:admin123 --upload-file target/*.jar \
                http://nexus:8081/repository/maven-releases/logan/springbootfinal/1.0.0/springbootfinal-1.0.0.jar
                '''
            }
        }
    }
}
