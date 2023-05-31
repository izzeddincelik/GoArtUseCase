# GoArtUseCase
This repo used for GoArt use case. Then it's open source and copyright-free for your developments.

Ön Gereksinimler
---
[minikube]([url](https://minikube.sigs.k8s.io/docs/start/))

[git]([url](https://git-scm.com/downloads))

Gerekli Ayarlamalar
---
**Minikube** ayağa kaldırıldı. **VSCode** kullanıldı. **Git** yüklendi. **Docker Desktop** yüklendi. **HyperV Integrated** çalışacak şekilde ayarlandı.

Öncelikle uygulama **troubleshooting** edilerek çalışmaya engel olabilecek ifadeler tespit edildi.

.csproj dosyasının ismi ile dll uyumsuzluğu **tespit** edildi ve gerekli düzeltmeler yapıldı.

Repo **git clone** olarak github üzerinden indirildi ve ilgili directory altına gidildi.

**Dockerfile** oluşturuldu ve build edildi.

Daha sonra DockerHub a push edildi. [izzeddincelik/sample_app:latest]([url](https://hub.docker.com/layers/izzeddincelik/sample_app/latest/images/sha256-b8f98060559f60b16fb3a885acc262fe026200f49c3ac4488b32a27af102ac15?context=repo))

**k8s-goart-definition-file.yml** yaml dosyası oluşturuldu. Detaylı olarak;

- Bir **deployment**, bir **servis** ve bir **ingress** objesi oluşturulması,
- Deployment objesi **2** replica ve containerPort'u **80** olacak şekilde gerekli labeling ile tanımlanması,
- Servis objesi selector'ü deployment objesi olacak şekilde **LoadBalancer** tipinde ayağa kaldırılması,
- Minikube tunnel aktif edilerek **ClusterIP -> External_IP** yönlendirmesi yapılması,
- Bu sayede **http://{{EXTERNAL_IP}}:{{PORT}}/WeatherForecast** olacak şekilde erişim sağlanması,
- Ingress objesi oluşturularak dışardan **80(HTTP)** portu üzerinden any erişim sağlanabilmesi,
- Bu erişim curl ile sh'ın sonunda çıktı şeklinde kontrol edilmesi şeklinde söylenebilir.