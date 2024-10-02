# TechChallengeFiap - Kubernetes com terraform - IAC

Este repositório contém os arquivos necessários para provisionar um cluster Kubernetes no Azure (AKS) utilizando o Terraform, bem como para configurar recursos como deploy de serviços, secrets, configMaps, e Horizontal Pod Autoscaler (HPA).

## Descrição

O projeto visa criar uma infraestrutura de Kubernetes no Azure, utilizando o Terraform para o gerenciamento dos recursos de maneira automatizada. Após o provisionamento do cluster AKS, também são aplicados recursos de Kubernetes como Deployment, Services, ConfigMaps, Secrets e Horizontal Pod Autoscaler (HPA).

## Tecnologias Utilizadas

- **Terraform**: Ferramenta de infraestrutura como código para provisionar e gerenciar os recursos.
- **Azure Kubernetes Service (AKS)**: Serviço gerenciado de Kubernetes do Azure.
- **Azure Container Registry (ACR)**: Repositório para armazenar e gerenciar imagens de contêineres Docker.
- **Kubernetes**: Sistema de orquestração de contêineres para gerenciar o ciclo de vida das aplicações.
- **ConfigMap e Secrets**: Recursos do Kubernetes para gerenciar variáveis de configuração e dados sensíveis.
- **Horizontal Pod Autoscaler (HPA)**: Mecanismo de escalabilidade automática de pods com base em métricas de uso.

## Recursos Provisionados

### Terraform

1. **Resource Group**: Grupo de recursos no Azure para organizar os recursos criados.
2. **Azure Kubernetes Service (AKS)**: Cluster Kubernetes com uma pool de nós de tamanho `Standard_B2s`.
3. **Azure Container Registry (ACR)**: Registro para armazenar imagens Docker usadas no Kubernetes.
   
### Kubernetes

1. **Deployment**: Define o aplicativo e seu comportamento dentro do cluster, como número de réplicas e imagem do contêiner.
2. **Service**: Configuração para expor o aplicativo dentro ou fora do cluster Kubernetes.
3. **ConfigMap**: Usado para passar variáveis de configuração não sensíveis para o contêiner.
4. **Secrets**: Gerenciamento de credenciais e outras informações sensíveis necessárias ao contêiner.
5. **Horizontal Pod Autoscaler (HPA)**: Escalabilidade automática de pods com base em métricas de utilização.
