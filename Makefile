MINIKUBE_PROFILE ?= minikube
MINIKUBE_NODES   ?= 2
MINIKUBE_CPUS    ?= 4
MINIKUBE_MEMORY  ?= 4096

.PHONY: bootstrap ensure-cluster ensure-ingress-proxy disable-ingress-proxy

bootstrap: ensure-cluster
	terraform -chdir=terraform init
	terraform -chdir=terraform apply -target=helm_release.argocd -auto-approve
	terraform -chdir=terraform apply -auto-approve
	@echo ""
	@echo "=== Bootstrap complete ==="
	@echo "Admin password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
	$(MAKE) ensure-ingress-proxy

ensure-cluster:
	@if ! minikube status -p $(MINIKUBE_PROFILE) >/dev/null 2>&1; then \
		minikube start -p $(MINIKUBE_PROFILE) \
			--nodes=$(MINIKUBE_NODES) \
			--cpus=$(MINIKUBE_CPUS) \
			--memory=$(MINIKUBE_MEMORY) \
			--driver=docker; \
	fi
	@kubectl config use-context $(MINIKUBE_PROFILE) >/dev/null

ensure-ingress-proxy:
	@NODE_IP=$$(minikube ip -p $(MINIKUBE_PROFILE)); \
	HTTP_PORT=$$(kubectl get svc -n ingress-nginx ingress-nginx-controller -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}'); \
	HTTPS_PORT=$$(kubectl get svc -n ingress-nginx ingress-nginx-controller -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}'); \
	docker rm -f ingress-proxy-http ingress-proxy-https >/dev/null 2>&1 || true; \
	docker run -d --restart unless-stopped --name ingress-proxy-http  --network $(MINIKUBE_PROFILE) -p 80:8080  alpine/socat TCP-LISTEN:8080,fork,reuseaddr TCP:$$NODE_IP:$$HTTP_PORT; \
	docker run -d --restart unless-stopped --name ingress-proxy-https --network $(MINIKUBE_PROFILE) -p 443:8443 alpine/socat TCP-LISTEN:8443,fork,reuseaddr TCP:$$NODE_IP:$$HTTPS_PORT

disable-ingress-proxy:
	docker rm -f ingress-proxy-http ingress-proxy-https 2>/dev/null || true

.PHONY: apply destroy

apply:
	terraform -chdir=terraform apply -auto-approve

destroy:
	terraform -chdir=terraform destroy -auto-approve

.PHONY: up down

up:
	minikube start -p $(MINIKUBE_PROFILE)
	$(MAKE) ensure-ingress-proxy

down:
	minikube stop -p $(MINIKUBE_PROFILE)
	$(MAKE) disable-ingress-proxy