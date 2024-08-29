# Prover infraestrutura basica

#### Implantar vms virtualboxes com vagrant: scripts & docs

1) Implantar k8s nos scripts vagrant
2) Implantar k8s + monitoring nos scripts vagrant

#### Implantar o Helm Package Manager (Masternode)

1) Ver matriz de suportabilidade de versões
https://helm.sh/docs/topics/version_skew/

K8S 1.28 - Helm 3.13.x
K8S 1.27 - Helm ?

#### Setup Podman - Criação de imagens para containers CRI-O

Para rodar as apps usadas no treinamento, devemos realizar o setup do ambiente envolvido:

a. Dimensionamento da máquina host usada para provisionar as vms usadas para os ambientes guests do treinamento. 

Aqui, devemos imaginar o quanto de disk size, memory e cpu devemos alocar na máquina guest virtualbox usada pelo vagrant do treinamento. 
Evita erros de provisionamento do k8s durante aplicação de yamls de deployment das apps do treinamento. 

- 15GB disk size
- 2cpu 
- 4096 MB memorycd

#### Implantar Apps em K8S 

Após testar imagens a partir do 'podman run' e confirmar que a app esta rodando em container CRI-O/PODMAN, fazer o deploy em k8s:

a. Entrar na máquina guest que hospeda o(s) node(s) que executa(m) os containers das apps

b. Fazer o build da imagem das apps envolvidas no treinamento e tagger a imagem para que fique compatível com o YAML de deployment em kubernetes.

c. Fazer deployment da app em kubernetes, criando os pods e demais componentes

d. Testar app

  - Fazer o ssh port forward para acessar a app na porta configurada no container/pod. 
  ssh -L 8080:localhost:8080 vagrant@192.168.56.102

  - Chamar app no browser da máquina host dos guests
  http://localhost:8080/sayhello/Daniel

  Erro dentro da app ao chamar o microservico service-b. 
  TODO: Validar app internamente, entrar no container da app e chamar via curl ou wget. 
  TODO: Validar externamente via podman run + port-forwarding, chamando via curl ou wget de dentro do guest onde o container esta rodando

#### Implantar JAEGER Tracing (Masternode)

Passos

1) Instalar o cert-manager 

a. helm repo add jetstack https://charts.jetstack.io --force-update

Listar todas as versoes de chart instalado no repo:

helm search repo jetstack/cert-manager --versions

Confirmar a versão compatível de acordo com a tabela de matriz de compatibilidade abaixo.

b. helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.15.3 \
  --set crds.enabled=true


c. Confirmar instalação

helm list -A
kubectl get pods -n cert-manager

https://cert-manager.io/docs/releases/#kubernetes-supported-versions
https://cert-manager.io/docs/releases/
CERT-MANAGER 1.15 ==> K8S 1.24 → 1.30

2) Instalar o Jaeger Operator usando CRDs

Pegar a versão correta do jaeger operator e ajustar a url para refletir a versão. 

a. kubectl create namespace observability
b. kubectl delete -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.57.0/jaeger-operator.yaml -n observability 
c. kubectl create -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.57.0/jaeger-operator.yaml -n observability 

Respeitar a matrix de compatibilidade 
- https://github.com/jaegertracing/jaeger-operator/blob/main/COMPATIBILITY.md (Jaeger Distributed Tracing - Cert Matrix to correct installs)

Referencias

- https://medium.com/opentracing/take-opentracing-for-a-hotrod-ride-f6e3141f7941 (Tutorial Sample OpenTracing with Jaeger)
- https://github.com/jaegertracing/jaeger-operator (Notas importantes para o treinamento: Configuração do ingress para acessar o Jaeger UI)


3) Instalar o Ingress Controller (nao funcionou, usei port-forward)

a. helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

b. kubectl get pods --namespace=ingress-nginx

c. Validação da instalação do Ingress (passo a)

kubectl create deployment demo --image=httpd --port=80
kubectl expose deployment demo

d. Cria uma ingress resource para roteamento para a app a ser instalada e utilizada pela ingress

kubectl create ingress demo-localhost --class=nginx \
  --rule="demo.localdev.me/*=demo:80"

e. Configurar uma port forward para a porta do ingress

kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80

f. Fazer uma requisição para a app utilizando a port forward criada

curl --resolve demo.localdev.me:8080:127.0.0.1 http://demo.localdev.me:8080

Referencia:
https://kubernetes.github.io/ingress-nginx/deploy/#quick-start

4. Deploy do de instância do Jaeger modo allinone 

a. Deploy da instância AllInOne

kubectl apply -n observability -f - <<EOF
apiVersion: jaegertracing.io/v1
kind: Jaeger
metadata:
  name: simplest
EOF

b. Validações

kubectl get jaegers -n observability 
kubectl get ingress -n observability 
kubectl get pods -l app.kubernetes.io/instance=simplest -n observability
kubectl get all -n observability 

c. Criação do ingress rule para o Jaeger UI 

obs: Pular este item, o ingress nao esta funcionando. 
Acesso realizado direto no container da app jaeger ui usando port-forward.

#kubectl delete ingress jaeger-ui-localhost

#kubectl create ingress jaeger-ui-localhost --class=nginx \
  --rule="www.jaeger.ui/*=simplest-query:16686" FAIL - Apontar para o service simplest-query, porta 16686

#kubectl create ingress jaeger-ui-localhost --class=nginx \
  --rule="www.jaeger.ui/*=simplest:16686" 

d. Criação do port-forward para o Ingress Controller 

obs: Pular este item, o ingress nao esta funcionando. 
Acesso realizado direto no container da app jaeger ui usando port-forward.

e. Testa acessibilidade da UI

Executar na máquina Guest (Masternode)

kubectl port-forward --namespace=observability service/simplest-query 16686:16686

Executar na máquina Host (VirtualBox), ssh port-forward para acesso à UI do Jaeger
Redirecionar as conexões http na porta local 16686 para a porta 16686 da maquina guest masternode.

ssh -L 16686:localhost:16686 danielrpgj@192.168.56.101

curl http://localhost:16686/

#### Implantar aplicações com instrumentação opentelemetry implementadas

#### Implantar Istio em K8S

1) Implantar Istio em K8S

2) Implantar monitoramento de rede Mesh com Kiali 

Seguir os passos do artigo abaixo:

https://istio.io/latest/docs/examples/bookinfo/ (Solução composta por diversos microservicoes em tecnologia distinta para testar diversas funcionalidades do Istio e Kiali)

https://istio.io/latest/docs/tasks/observability/kiali/ (Exemplo de Uso do Kiali como visualizador de rede mesh com informações estatísticas)

https://kiali.io/docs/installation/installation-guide/install-with-helm/ (Instalação Kiali com Helm)

https://istio.io/latest/docs/tasks/observability/distributed-tracing/jaeger/ (Uso do tracing do Jaeger para pegar tempos em uma cadeia de chamadas)


#### Gateways em ambientes Bare Metals (Ingress Controlers)
https://kubernetes.github.io/ingress-nginx/deploy/baremetal/

#### Implantar infraestrutura com Terraform, automatizando scripts vagrant

# Prover Aplicações & Arquiteturas 

#### Implantar apps de arquitetura (x e y a definir) utilizando Ansible

# Histórico GIT

>> branch b_fix_terraform_provisioning_morevms

Criei branch b_fix_terraform_provisioning_morevms para conter problema e solução de provisionamento de cluster k8s. Neste branche
contém erro na criação do workernode pois o join.sh não é gerado com o token correto. Logo, kubeadm join trava por um tempo até
estourar erro de token no final. 

Criação de dois TODOS: para apontar resolução do problema. 

>> branch b_fix_k8s_131

Branch com solução na instalação dos pacotes do k8s no Ubuntu 22.04. Aqui, o erro é a URL de pacotes apt. Ela quebrou, não existe mais. 
Como ajuste a ser implementado, retirar o apontamento de versão nos pacotes k8s e ajustar urls do repositório apt.

>> branch b_fix_terraform_provisioning_k8scluster

Branch criado para corrigir o Join do workernode, provisionado pelo terraform. O token não é atualizado com base no masternode, o que gera erro de conectividade no kubeadm join. Coloquei apenas TODOS. 

>> branch b_change_vagrant_box

Branch criado para troca de imagem da box (virtualbox vm) de bento para danielrpgj(minha), que subi no vagrant cloud. Imagem de ubuntu 22.04 live server. 
