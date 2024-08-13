Para gerar uma imagem para Kubernetes baseada em CRI-O, você normalmente seguirá um processo que envolve a criação de um contêiner e, em seguida, a construção de uma imagem a partir desse contêiner. O CRI-O é um daemon leve para executar contêineres OCI (Open Container Initiative) que é amplamente utilizado no ecossistema Kubernetes.

Aqui estão os passos gerais:

1. Escrever um Dockerfile:
Crie um arquivo chamado Dockerfile no diretório do seu aplicativo.
O Dockerfile contém instruções sobre como construir a imagem.

Dockerfile

FROM alpine:latest
RUN apk --update add nginx
CMD ["nginx", "-g", "daemon off;"]

2. Construir o Contêiner:
Use o comando podman build para construir um contêiner a partir do Dockerfile. O podman é frequentemente usado com CRI-O.

podman build -t my-nginx-image .

3. Executar e Testar o Contêiner:
Execute o contêiner localmente para garantir que ele funcione corretamente.

podman run -d -p 8080:80 my-nginx-image

Isso iniciará um contêiner NGINX em segundo plano e mapeará a porta 8080 do host para a porta 80 do contêiner.

4. Exportar a Imagem:
Use o comando podman save para salvar a imagem como um arquivo tar.

podman save -o my-nginx-image.tar my-nginx-image

5. Carregar a Imagem no Cluster Kubernetes:
Transfira o arquivo tar gerado para o cluster Kubernetes e use o comando podman load para carregar a imagem.

podman load -i my-nginx-image.tar

6. Tag da Imagem e Envio para um Registro (Opcional):
Se você planeja compartilhar a imagem, adicione uma tag e envie-a para um registro de contêiner.

podman tag my-nginx-image registry.example.com/my-nginx-image:v1
podman push registry.example.com/my-nginx-image:v1

7. Implantação no Kubernetes:
Use o nome da imagem e tag que você definiu no seu manifesto de implantação ou pod no Kubernetes.

apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: my-nginx-container
        image: registry.example.com/my-nginx-image:v1

Isso é um exemplo básico, e você precisará ajustar conforme necessário para o seu aplicativo específico. Certifique-se de entender os princípios do Dockerfile e do Kubernetes YAML para criar imagens e implantá-las com sucesso.


## Conclusão

Usei o cri-o mesmo, com crioctl para gerenciar as builds e repositório local de imagens
