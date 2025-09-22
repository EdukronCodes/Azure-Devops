#!/bin/bash

# Azure Resource Deployment Script
# Deploys infrastructure resources for Flask + React application

set -e

# Configuration
RESOURCE_GROUP="flask-react-rg"
LOCATION="East US"
APP_NAME="flask-react-app"
ENVIRONMENT=${1:-dev}

echo "🚀 Starting Azure resource deployment for environment: $ENVIRONMENT"

# Login to Azure (if not already logged in)
echo "🔐 Checking Azure login status..."
if ! az account show &> /dev/null; then
    echo "Please login to Azure CLI"
    az login
fi

# Create resource group
echo "📦 Creating resource group: $RESOURCE_GROUP"
az group create \
    --name $RESOURCE_GROUP \
    --location "$LOCATION" \
    --tags Environment=$ENVIRONMENT Application=$APP_NAME

# Deploy ARM template
echo "🏗️ Deploying ARM template..."
az deployment group create \
    --resource-group $RESOURCE_GROUP \
    --template-file azure-config/arm-template.json \
    --parameters \
        appName=$APP_NAME \
        environment=$ENVIRONMENT \
        location="$LOCATION" \
    --output table

# Get deployment outputs
echo "📋 Getting deployment outputs..."
CONTAINER_REGISTRY=$(az deployment group show \
    --resource-group $RESOURCE_GROUP \
    --name azure-config/arm-template.json \
    --query properties.outputs.containerRegistryName.value -o tsv)

WEB_APP_NAME=$(az deployment group show \
    --resource-group $RESOURCE_GROUP \
    --name azure-config/arm-template.json \
    --query properties.outputs.webAppName.value -o tsv)

KEY_VAULT_NAME=$(az deployment group show \
    --resource-group $RESOURCE_GROUP \
    --name azure-config/arm-template.json \
    --query properties.outputs.keyVaultName.value -o tsv)

echo "✅ Deployment completed successfully!"
echo "Container Registry: $CONTAINER_REGISTRY"
echo "Web App Name: $WEB_APP_NAME"
echo "Key Vault: $KEY_VAULT_NAME"

# Configure Application Insights
echo "📊 Configuring Application Insights..."
APP_INSIGHTS_NAME="${APP_NAME}-insights-${ENVIRONMENT}"
az monitor app-insights component create \
    --app $APP_INSIGHTS_NAME \
    --location "$LOCATION" \
    --resource-group $RESOURCE_GROUP

# Get Application Insights key
APP_INSIGHTS_KEY=$(az monitor app-insights component show \
    --app $APP_INSIGHTS_NAME \
    --resource-group $RESOURCE_GROUP \
    --query instrumentationKey -o tsv)

# Store secrets in Key Vault
echo "🔐 Storing secrets in Key Vault..."
az keyvault secret set \
    --vault-name $KEY_VAULT_NAME \
    --name "app-insights-key" \
    --value "$APP_INSIGHTS_KEY"

# Generate random secret key
SECRET_KEY=$(openssl rand -base64 32)
az keyvault secret set \
    --vault-name $KEY_VAULT_NAME \
    --name "flask-secret-key" \
    --value "$SECRET_KEY"

# Database password
DB_PASSWORD=$(openssl rand -base64 16)
az keyvault secret set \
    --vault-name $KEY_VAULT_NAME \
    --name "database-password" \
    --value "$DB_PASSWORD"

# Configure App Service to use Key Vault
echo "🔧 Configuring App Service..."
az webapp config appsettings set \
    --resource-group $RESOURCE_GROUP \
    --name $WEB_APP_NAME \
    --settings \
        "@Microsoft.KeyVault(SecretUri=https://$KEY_VAULT_NAME.vault.azure.net/secrets/app-insights-key/)" \
        "@Microsoft.KeyVault(SecretUri=https://$KEY_VAULT_NAME.vault.azure.net/secrets/flask-secret-key/)" \
        "@Microsoft.KeyVault(SecretUri=https://$KEY_VAULT_NAME.vault.azure.net/secrets/database-password/)"

# Enable continuous deployment
echo "🔄 Configuring continuous deployment..."
az webapp deployment container config \
    --resource-group $RESOURCE_GROUP \
    --name $WEB_APP_NAME \
    --enable-cd true

# Configure scaling
echo "📈 Configuring auto-scaling..."
az monitor autoscale create \
    --resource-group $RESOURCE_GROUP \
    --resource $WEB_APP_NAME \
    --resource-type Microsoft.Web/sites \
    --name "${APP_NAME}-autoscale-${ENVIRONMENT}" \
    --min-count 1 \
    --max-count 10 \
    --count 2

# Configure alert rules
echo "🚨 Configuring alert rules..."
az monitor metrics alert create \
    --name "${APP_NAME}-high-cpu-${ENVIRONMENT}" \
    --resource-group $RESOURCE_GROUP \
    --scopes "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Web/sites/$WEB_APP_NAME" \
    --condition "avg Percentage CPU > 80" \
    --description "High CPU usage alert" \
    --evaluation-frequency 1m \
    --window-size 5m \
    --severity 2

az monitor metrics alert create \
    --name "${APP_NAME}-high-memory-${ENVIRONMENT}" \
    --resource-group $RESOURCE_GROUP \
    --scopes "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Web/sites/$WEB_APP_NAME" \
    --condition "avg MemoryPercentage > 80" \
    --description "High memory usage alert" \
    --evaluation-frequency 1m \
    --window-size 5m \
    --severity 2

# Configure backup
echo "💾 Configuring backup..."
az webapp config backup update \
    --resource-group $RESOURCE_GROUP \
    --webapp-name $WEB_APP_NAME \
    --frequency 1d \
    --retain-one-backup true

# Output deployment summary
echo ""
echo "🎉 Deployment Summary:"
echo "====================="
echo "Resource Group: $RESOURCE_GROUP"
echo "Location: $LOCATION"
echo "Environment: $ENVIRONMENT"
echo "Container Registry: $CONTAINER_REGISTRY"
echo "Web App: $WEB_APP_NAME"
echo "Key Vault: $KEY_VAULT_NAME"
echo "Application Insights: $APP_INSIGHTS_NAME"
echo ""
echo "Next steps:"
echo "1. Build and push Docker image to $CONTAINER_REGISTRY"
echo "2. Configure Azure DevOps pipeline variables"
echo "3. Run the CI/CD pipeline"
echo ""
echo "✅ Azure resources deployed successfully!"
