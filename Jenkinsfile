pipeline {
  agent any

  environment {
    IMAGE_NAME = "mohaa9222/wordpress-k3s" // à adapter avec ton compte Docker Hub
    KUBECONFIG = credentials('KUBECONFIG_DEV')
    NAMESPACE = "mjallouli-project1"
    DOMAIN = "wp.20.162.255.135.nip.io"
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/Mohaa922/projet-k3s-ansible.git', branch: 'test'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${IMAGE_NAME}:latest -f Dockerfile ."
      }
    }

    stage('Push Docker Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
          sh "docker push ${IMAGE_NAME}:latest"
        }
      }
    }

    stage('Déployer WordPress sur K8s') {
      steps {
        sh '''
          kubectl apply -f k3s/mysql/mysql-pv-pvc.yml -n $NAMESPACE
          kubectl apply -f k3s/mysql/mysql-service.yml -n $NAMESPACE
          kubectl apply -f k3s/mysql/mysql-deployment.yml -n $NAMESPACE

          kubectl apply -f k3s/wordpress/wordpress-pv-pvc.yml -n $NAMESPACE
          kubectl apply -f k3s/wordpress/wordpress-configmap.yml -n $NAMESPACE
          kubectl apply -f k3s/wordpress/wordpress-service.yml -n $NAMESPACE
          kubectl apply -f k3s/wordpress/wordpress-deployment.yml -n $NAMESPACE
          kubectl apply -f k3s/wordpress/ingress.yml -n $NAMESPACE
        '''
      }
    }

    stage('Vérifier WordPress') {
      steps {
        sh '''
          echo "Attente 30s que les pods démarrent..."
          sleep 30

          echo "Tester accès WordPress :"
          curl -I http://$DOMAIN || true
        '''
      }
    }
  }

  post {
    success {
      echo '✅ Pipeline terminée avec succès. WordPress est en ligne !'
    }
    failure {
      echo '❌ Échec de la pipeline. Vérifie les logs.'
    }
  }
}
