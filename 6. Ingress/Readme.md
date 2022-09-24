# Ingress

# Demo

1. Install nginx ingress in cluster (Shared by all namespaces)

	```
	kubectl create ns nginx
	helm install ingress -n nginx bitnami/nginx-ingress-controller
	kubectl get all -n nginx
	```

2. Install the sample application and it's services

	```
	 kubectl apply -f https://raw.githubusercontent.com/mahendra-shinde/kubernetes-demos/master/14-ingress/deployment.yml
	 kubectl get pod,svc
	 
	```

3.	Create `routes.yml`

	```yml
	apiVersion: networking.k8s.io/v1
	kind: Ingress
	metadata:
		name: my-app
		labels:
			name: my-app
		annotations:
			nginx.ingress.kubernetes.io/rewrite-target: /$1
	spec:
		ingressClassName: nginx
		rules:
		#- host: <Host>
		- http:
			paths:
			- pathType: Prefix
			  path: "<path>"
			  backend:
			    service:
			      name: <svc-name>
				  port: 
				    number: 80
			- pathType: Prefix
			  path: "<Path>"
			  backend:
			    service:
			      name: <svc-name>
		   		  port: 
				    number: 80
	```

4.	Deploy the ingress

	```
	kubectl apply -f routes.yml
	```
