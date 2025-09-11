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
- \`roles/\` → rôles Ansible NFS
- \`k3s/\` → manifestes Kubernetes (MySQL, WordPress, Jenkins)
- \`monitoring/\` → à compléter
- \`Jenkinsfile\` → pipeline de déploiement
EOF
