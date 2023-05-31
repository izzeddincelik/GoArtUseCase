#!/bin/bash

echo
echo "GitHub repo clone'lanıyor..."
sleep 2
git clone https://github.com/roofstacks/case-study-pool.git
cd case-study-pool/infrastructure-developer/mini-cluster/sample-app

# sample-app.csproj dosyasının adını güncelle (troubleshooting)
mv sample-app.csproj sample_app.csproj

echo
echo "Dockerfile oluşturuluyor..."
cat <<EOF > Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# .csproj dosyalarını kopyala ve restore et
COPY *.csproj ./
RUN dotnet restore

# Geri kalan dosyaları kopyala ve build et
COPY . ./
RUN dotnet publish -c Release -o out

# Runtime Image oluştur
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .

EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "sample_app.dll"]
EOF

echo "Docker imajı oluşturuluyor..."
echo "docker build -t izzeddincelik/sample_app ."
sleep 2
echo
echo "Image DockerHub'a  push ediliyor..."
echo "docker push izzeddincelik/sample_app"
sleep 2
echo

echo "Kubernetes definition file oluşturuluyor..."
echo
cat <<EOF > k8s-goart-definition-file.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sampleapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: sampleapp
  template:
    metadata:
      labels:
        app: sampleapp
    spec:
      containers:
        - name: sampleapp
          image: izzeddincelik/sample_app
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: sampleappservice
spec:
  selector:
    app: sampleapp
  type: LoadBalancer
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30070
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: sample-app-ingress
spec:
  rules:
    - http:
        paths:
          - path: /WeatherForecast
            pathType: Prefix
            backend:
              service:
                name: sampleappservice
                port:
                  number: 80
EOF

echo "Kubernetes Deployment - SVC - Ingress oluşturuluyor..."
sleep 2
kubectl apply -f k8s-goart-definition-file.yml

# Uygulama erişimini kontrol etme
echo
echo "Uygulama erişimi için Minikube Tunnel'in açık olduğundan emin olunuz..."
sleep 4

echo
echo "IP adresi ve port bilgileri alınıyor..."
IP=$(kubectl get svc sampleappservice -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
PORT=$(kubectl get svc sampleappservice -o jsonpath='{.spec.ports[0].port}')

# Uygulamayı test et
echo
echo "curl http://$IP:$PORT/WeatherForecast"
echo
curl http://$IP:$PORT/WeatherForecast