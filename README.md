cat <<EOF > README.md
# Projet K3s Ansible CI/CD

Ce projet déploie une infrastructure complète :
- K3s (master + workers)
- NFS (partagé pour MySQL, WordPress, Jenkins)
- Services Kubernetes (MySQL, WordPress, Jenkins)
- CI/CD avec Jenkins + GitHub
- Monitoring  (Prometheus/Grafana)

## Structure
- \`ansible/\` → playbooks d'installation
- \`ansible/`roles/\` → rôles Ansible NFS
- \`ansible/inventory\` → Declaration hosts noeuds (k3s-master,k3s-worker1,k3s-worker2)
- \`k3s/\` → manifestes Kubernetes (MySQL, WordPress, Jenkins)
- \`monitoring/\` → Prometheus + Grafana
-  \`Jenkinsfile\` → pipeline de déploiement
EOF
