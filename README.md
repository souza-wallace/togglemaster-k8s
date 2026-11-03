# togglemaster-k8s

Manifests Kubernetes do ToggleMaster. É o repositório GitOps que o Argo CD observa.

Cada pasta (`auth-service`, `flag-service`, `targeting-service`, `evaluation-service`, `analytics-service`) tem o que o serviço precisa no cluster: namespace, Deployment, Service, Ingress, ConfigMap e os ExternalSecrets que puxam senhas do Secrets Manager.

Quando o pipeline publica uma imagem nova, ele só atualiza a tag no `deployment.yaml` daqui. O Argo CD compara este Git com o cluster e aplica a diferença.

A infraestrutura (EKS, bancos, filas e o próprio Argo CD) fica no repositório `iac-togglemaster`. O `docker-compose.yml` e a pasta `infra/` sobem as dependências locais para desenvolvimento fora do cluster.
