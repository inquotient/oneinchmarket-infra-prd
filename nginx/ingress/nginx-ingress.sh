sudo kubectl apply -f argocd-ingress.yaml -n argocd
sudo kubectl apply -f gitlab-ingress.yaml -n dev
sudo kubectl apply -f admin-ingress.yaml -n dev
sudo kubectl apply -f kafka-ui-ingress.yaml -n dev