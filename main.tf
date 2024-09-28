terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}


provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = "MyResourceGroup"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKSCluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "myakscluster"

  default_node_pool {
    name                        = "default"
    temporary_name_for_rotation = "tempdefault"
    node_count                  = 1
    vm_size                     = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "myContainerRegistryTechChallenge"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  admin_enabled       = true
}


resource "kubernetes_config_map_v1" "api_config" {
  metadata {
    name      = "api-config"
    namespace = "default"
  }

  data = {
    DBServer = var.db_server
    DBPort   = var.db_port
    Database = var.db_name
  }
}


resource "kubernetes_secret" "api_secrets" {
  metadata {
    name      = "api-secrets"
    namespace = "default"
  }

  data = {
    DBUser     = base64encode(var.db_user)
    DBPassword = base64encode(var.db_password)
  }

  type = "Opaque"
}

resource "kubernetes_horizontal_pod_autoscaler" "api_hpa" {
  metadata {
    name      = "api-hpa"
    namespace = "default"
  }

  spec {
    max_replicas = 10
    min_replicas = 2

    scale_target_ref {
      kind        = "Deployment"
      name        = "api"
      api_version = "apps/v1"
    }

    target_cpu_utilization_percentage = 50
  }
}

