.PHONY: bootstrap destroy status

# Terraform providers are configured against the kubeconfig at plan time,
# but the minikube cluster (and thus a valid kubeconfig context) doesn't
# exist until null_resource.minikube_cluster has run. So the first apply
# is targeted to just stand up the cluster; the second apply does
# everything else (argocd + root app) against a now-reachable cluster.
bootstrap:
	terraform -chdir=terraform init
	terraform -chdir=terraform apply -target=null_resource.minikube_cluster -target=kubernetes_namespace.ai_assistant -auto-approve
	terraform -chdir=terraform apply -target=helm_release.argocd -auto-approve
	terraform -chdir=terraform apply -auto-approve
	@echo ""
	@echo "=== Bootstrap complete ==="
	@echo "ArgoCD UI: kubectl port-forward -n argocd svc/argocd-server 8080:443"
	@echo "Admin password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"

destroy:
	terraform -chdir=terraform destroy -auto-approve

status:
	kubectl get applications -n argocd
	kubectl get pods -n ai-assistant