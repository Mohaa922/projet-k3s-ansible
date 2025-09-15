pipeline {
    agent any

    environment {
        IMAGE_NAME = "mohaa9222/wordpress-k3s" // Docker Hub image name
        NAMESPACE = "mjallouli-project1"
        DOMAIN = "wp.20.162.255.135.nip.io"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'test', credentialsId: 'github-secret', url: 'https://github.com/Mohaa922/projet-k3s-ansible.git'
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
                withCredentials([string(credentialsId: 'KUBECONFIG_DEV', variable: 'KUBECONFIG_CONTENT')]) {
                    sh '''
                        echo "$KUBECONFIG_CONTENT" > kubeconfig.yaml
                        export KUBECONFIG=$PWD/kubeconfig.yaml
                        kubectl apply -f k3s/wordpress/ -n $NAMESPACE
                    '''
                }
            }
        }

        stage('Vérifier WordPress') {
            steps {
                sh '''
                    export KUBECONFIG=$PWD/kubeconfig.yaml
                    kubectl get pods -n $NAMESPACE
                    curl -I http://$DOMAIN || true
                '''
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
