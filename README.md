# Prover infraestrutura basica

#### Implantar vms virtualboxes com vagrant: scripts & docs

1) Implantar k8s nos scripts vagrant
2) Implantar k8s + monitoring nos scripts vagrant

#### Implantar Istio em K8S

1) Implantar Istio em K8S

#### Implantar monitoramento de rede Mesh com Kiali 

Seguir os passos do artigo abaixo:

https://istio.io/latest/docs/examples/bookinfo/ (Solução composta por diversos microservicoes em tecnologia distinta para testar diversas funcionalidades do Istio e Kiali)

https://istio.io/latest/docs/tasks/observability/kiali/ (Exemplo de Uso do Kiali como visualizador de rede mesh com informações estatísticas)

https://kiali.io/docs/installation/installation-guide/install-with-helm/ (Instalação Kiali com Helm)

https://istio.io/latest/docs/tasks/observability/distributed-tracing/jaeger/ (Uso do tracing do Jaeger para pegar tempos em uma cadeia de chamadas)

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
