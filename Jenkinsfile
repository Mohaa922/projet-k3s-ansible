pipeline {
    agent any

    environment {
        IMAGE_NAME = "mohaa922/wordpress-k3s" // Remplace si nécessaire
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'test', credentialsId: 'github-token', url: 'https://github.com/Mohaa922/projet-k3s-ansible.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest -f Dockerfile ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Déployer WordPress sur K3s') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f k3s/wordpress/'
                }
            }
        }

        stage('Vérifier WordPress') {
            steps {
                sh 'kubectl get pods -n mjallouli-project1'
                sh 'curl -I http://wp.20.162.255.135.nip.io || true'
            }
        }
    }

    post {
        failure {
            echo "❌ Échec de la pipeline. Vérifie les logs."
        }
        success {
            echo "✅ Déploiement WordPress terminé avec succès."
        }
    }
}
