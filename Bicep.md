# 📘 Azure Bicep templates creation

to deploy resources from a bicep file 
```bash
az deployment group create --resource-group <resource-group> --template-file <template-file>
```
example

>> az deployment group create --resource-group packt-dev-resource-rg --template-file deploy_envt.bicep

---

# 📘 Azure Service Principal (SP) & `--sdk-auth` Notes

create a service principal and configure access
[doc*](docs.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest)


```bash
az ad sp create-for-rbac --name github-devops-app --role contributor --scopes /subscriptions/<SubscriptionID>/resourceGroups/packt-dev-resource-rg --sdk-auth
```

Azure CLI responded:

> **Option `--sdk-auth` has been deprecated and will be removed in a future release.**

### ✔ Why?

`--sdk-auth` generates a JSON file for Azure SDK authentication (useful for CI/CD).
Microsoft is transitioning to **modern authentication**, especially **OpenID Connect (OIDC)** for GitHub Actions.
The flag still works **for now**, but will eventually disappear.

---

## ✅ What is “SP” (Service Principal)?

A **Service Principal** is:

* A non-human identity for apps, scripts, CI/CD, automation.
* An identity that can authenticate to Azure.
* Assigned Azure RBAC roles such as Contributor, Reader, etc.

Think of it like a *robot account* for automation.

---

## ✅ What is “AD” (Azure Active Directory / Entra ID)?

`az ad` refers to Azure Active Directory (now **Microsoft Entra ID**).
It manages:

* Users
* Groups
* Apps
* Service Principals

`az ad sp create-for-rbac` → Create an SP + assign RBAC permissions.

---

# 🎚️ Common Roles for Service Principals

Azure has **200+ built-in roles**, but these are the **major categories and the most common roles** used for SPs.

---

## 🌐 **General Roles**

| Role            | Description                                      |
| --------------- | ------------------------------------------------ |
| **Owner**       | Full control, including role assignment.         |
| **Contributor** | Full resource management; *cannot* assign roles. |
| **Reader**      | View-only access.                                |

---

## 🌟 **Most Common SP Roles (CI/CD, DevOps, Automation)**

| Role                              | Description                                   |
| --------------------------------- | --------------------------------------------- |
| **Contributor**                   | Most widely used for deployment pipelines.    |
| **Reader**                        | Useful for read-only scripts.                 |
| **User Access Administrator**     | Can manage role assignments.                  |
| **Storage Blob Data Contributor** | Needed for uploading artifacts to storage.    |
| **Storage Blob Data Reader**      | Read-only blob access.                        |
| **Storage Account Contributor**   | Manage storage account configuration.         |
| **Key Vault Contributor**         | Manage Key Vault resources (but not secrets). |
| **Key Vault Administrator**       | Full access to Key Vault including secrets.   |
| **Key Vault Secrets User**        | Read only secrets.                            |
| **AcrPush**                       | Push images to Azure Container Registry.      |
| **AcrPull**                       | Pull images from ACR.                         |
| **AcrDelete**                     | Delete images from ACR.                       |
| **WebSite Contributor**           | Manage App Service apps.                      |
| **Function App Contributor**      | Manage Function Apps.                         |

---

## 🛡️ **Security & Identity**

| Role                                  | Description                             |
| ------------------------------------- | --------------------------------------- |
| **Security Reader**                   | View security alerts & recommendations. |
| **Security Admin**                    | Manage security settings.               |
| **Identity Governance Administrator** | Identity-related admin tasks.           |

---

## 🔧 **Networking**

| Role                     | Description                              |
| ------------------------ | ---------------------------------------- |
| **Network Contributor**  | Manage VNets, NSGs, Load Balancers, etc. |
| **DNS Zone Contributor** | Manage DNS zones and records.            |

---

## 📦 **Compute**

| Role                                    | Description                     |
| --------------------------------------- | ------------------------------- |
| **Virtual Machine Contributor**         | Manage VMs but not access them. |
| **Virtual Machine Administrator Login** | Login to VMs.                   |
| **Virtual Machine User Login**          | Limited VM login permissions.   |

---

## 🧰 **Container / Kubernetes**

| Role                                     | Description                    |
| ---------------------------------------- | ------------------------------ |
| **Azure Kubernetes Service Contributor** | Manage AKS clusters.           |
| **Kubernetes Cluster Admin**             | Admin-level cluster access.    |
| **Kubernetes Cluster User**              | User-level access to clusters. |

---

## 📊 **Data Services**

| Role                              | Description                  |
| --------------------------------- | ---------------------------- |
| **SQL DB Contributor**            | Manage SQL databases.        |
| **Cosmos DB Account Contributor** | Manage Cosmos DB accounts.   |
| **EventGrid Contributor**         | Manage Event Grid resources. |
| **EventHub Data Owner**           | Full Event Hub access.       |
| **Data Factory Contributor**      | Manage Azure Data Factory.   |

---

# 📌 Notes

* An SP can be assigned **multiple roles**.
* Roles can be scoped to **subscription**, **resource group**, or **individual resource**.
* For GitHub Actions and other CI/CD: **OIDC** is now preferred instead of secrets from `--sdk-auth`.

