# GoArtUseCase
This repo used for GoArt use case. Then it's open source and copyright-free for your developments.

Ön Gereksinimler/Prerequisites
---
[minikube](https://minikube.sigs.k8s.io/docs/start/)

[git](https://git-scm.com/downloads)

Gerekli Ayarlamalar
---

- **Minikube** up durumda olmalı. (**> minikube start**)
- **VSCode** kullanabilirsiniz. 
- **Git** ve **Docker Desktop** yüklenmeli. 
- **HyperV Integrated** çalışacak şekilde ayarlanabilir.

Kurulum
---

**Windows için** -> **Git Bash ya da WSL2** üzerinden **./one-click-install.sh** olarak çağırmanız yeterli olacaktır.

**Unix için** -> Repoyu indirdikten sonra **./one-click-install.sh** çalıştırmanız yeterli olacaktır.

---

Öncelikle, uygulama **troubleshooting** edilerek çalışmaya engel olabilecek ifadeler tespit edildi.

.csproj dosyasının ismi ile dll uyumsuzluğu **tespit** edildi ve gerekli düzeltmeler yapıldı.

Repo **git clone** olarak github üzerinden indirildi ve ilgili directory altına gidildi.

**Dockerfile** oluşturuldu ve build edildi.

Daha sonra DockerHub a push edildi. [izzeddincelik/sample_app:latest](https://hub.docker.com/layers/izzeddincelik/sample_app/latest/images/sha256-b8f98060559f60b16fb3a885acc262fe026200f49c3ac4488b32a27af102ac15?context=explore)

**k8s-goart-definition-file.yml** yaml dosyası oluşturuldu. Detaylı olarak;

- Bir **deployment**, bir **servis** ve bir **ingress** objesi oluşturulması,
- Deployment objesi **2** replica ve containerPort'u **80** olacak şekilde gerekli labeling ile tanımlanması,
- Servis objesi selector'ü deployment objesi olacak şekilde **LoadBalancer** tipinde ayağa kaldırılması,
- Minikube tunnel aktif edilerek **ClusterIP -> External_IP** yönlendirmesi yapılması,
- Bu sayede **http://{{EXTERNAL_IP}}:{{PORT}}/WeatherForecast** olacak şekilde erişim sağlanması,
- Ingress objesi oluşturularak dışardan **80(HTTP)** portu üzerinden any erişim sağlanabilmesi,
- Bu erişim **curl** ile sh'ın sonunda çıktı şeklinde kontrol edilmesi şeklinde söylenebilir.

---
Required Settings
---

- **Minikube** should be running. (**> minikube start**)
- You can use **VSCode**.
- **Git and Docker Desktop** should be installed.
- **HyperV Integration** can be set to work.

---
Installation
---

**For Windows** -> After downloading the repo, simply run **./one-click-install.sh** via **Git Bash** or **WSL2**.

**For Unix** -> After downloading the repo, just run **./one-click-install.sh**.

---
First, the application was **troubleshooted** to identify any statements that could prevent it from running.

An inconsistency between the .csproj file name and the DLL was **identified** and necessary corrections were made.

The repository was cloned from GitHub using 'git clone' and the relevant directory was accessed.

A Dockerfile was created and built.

Then, it was pushed to DockerHub: [izzeddincelik/sample_app:latest](https://hub.docker.com/layers/izzeddincelik/sample_app/latest/images/sha256-b8f98060559f60b16fb3a885acc262fe026200f49c3ac4488b32a27af102ac15?context=explore)

A yaml file named **k8s-goart-definition-file.yml** was created. In detail:

- A **deployment**, a **service**, and an **ingress** object were created.
- The deployment object was defined with **2** replicas, **containerPort** set to **80**, and appropriate labeling.
- The service object was set up with the selector as the deployment object, using the **LoadBalancer** type.
- **Minikube** **tunnel** was activated to redirect **ClusterIP** to **External_IP**.
- This allows access to **http://{{EXTERNAL_IP}}:{{PORT}}/WeatherForecast**.
- An ingress object was created to allow external access through port **80 (HTTP)**.
- This access can be verified using **curl**, and the output should be displayed at the end of the sh script.
