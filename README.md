# CST8918 - DevOps_FinalProject: Infrastructure as Code  
**Final Project: Terraform, Azure AKS, and GitHub Actions**  
**Group Name:** Group 11  
**Category:** FP  
**Professor:** Robert McKenney  

---

## 📌 Overview

It is a culminating project that demonstrates some of the concepts learned on Infrastructure as Code (IaC) during the term. We developed the Remix Weather Application which we had already done in week 3 and we used Terraform to work with Azure resources to create an Azure Kubernetes Service (AKS) clusters and managed Redis DB. The Terraform runs, application builds and deployments are done automatically via GitHub Actions.

The configuration has been handled in **Azure Blob Storage backend** and is divided into **modules** so that it would be possible to maintain it. This is a simulation of a real life scenario in which multiple members would be on a team in various environments (dev, test, prod).

---

## 👥 Team Members

| Name | GitHub Profile |
|------|---------------|
| Meet Prajapati | [praj0080](https://github.com/praj0080) |



---

## 📂 Repository Structure

```
.
├── app/                  # Remix Weather Application code
│   ├── backend/
│   ├── frontend/
│   └── Dockerfile
├── infra/                # Terraform code
│   ├── modules/
│   │   ├── backend/      # Azure Blob Storage backend
│   │   ├── network/      # Virtual network & subnets
│   │   ├── aks/          # AKS cluster configurations
│   │   ├── acr/          # Azure Container Registry
│   │   ├── redis/        # Azure Cache for Redis
│   │   └── weather-app/  # Kubernetes manifests
│   ├── dev/
│   ├── test/
│   └── prod/
├── .github/
│   └── workflows/        # GitHub Actions workflows
└── README.md
```

---

## 🛠️ Defined Resources

### **Terraform Backend**
- An Azure Blob Storage backend based state management.

### **Network Infrastructure**
- Resource Group: `cst8918-final-project-group-11`
- Virtual Network: `10.0.0.0/14`
- Subnets:
  - **prod:** `10.0.0.0/16`
  - **test:** `10.1.0.0/16`
  - **dev:** `10.2.0.0/16`
  - **admin:** `10.3.0.0/16`

### **AKS Clusters**
- **Test:**
  - 1 node
  - VM size: Standard B2s
  - Kubernetes v1.32
- **Prod:**
  - Min 1 node, Max 3 nodes
  - VM size: Standard B2s
  - Kubernetes v1.32

### **Application Resources**
(ACR) of Docker images.
Controlled Redis DB (Azure Cache for Redis) at both levels, the test and production level.
Remix Weather app deployments and services in a Kubernetes.

---

## ⚙️ GitHub Actions Workflows

1. **Static Analysis** (on push to any branch):
   - `terraform fmt`
   - `terraform validate`
   - `tfsec`

2. **PR Checks** (on pull request to main):
   - `tflint`
   - `terraform plan`
   - Build & deploy app to **test** environment (if app code changes).

3. **Deploy Infra** (on push to main):
   - `terraform apply`

4. **App Deployment**:
   - **Test:** On PR to main (app code changes).
   - **Prod:** On merge to main (app code changes).
   - Build Docker image, push to ACR, tag with commit SHA.

---

## 🚀 Deployment Flow

1. The development of feature or fix is carried out in a different branch.
2. Main triggers to PR:
   Infra PR -> Terraform plan & lint checks.
   App PR -> Build & deploy to testim.
3. Combining PR to main triggers:
   Infra changes ->Deploy to Azure.
   App changes - > Deploy to prod.

---

## 🖥️ Running the Project

### **Prerequisites**
-The right subscription was logged into through the Azure CLI.
-Locally installed terraform.
-Hello, federated identity in GitHub repository.
-Local builds installed docker.

### **Steps**
1. Clone the repository:
   ```bash
   git clone (https://github.com/praj0080/CST8918_FinalProject.git)
   cd CST8918_FinalProject
   ```
2. Initialize Terraform:
   ```bash
   cd infra
   terraform init
   ```
3. Plan & Apply:
   ```bash
   terraform plan
   terraform apply
   ```
4. Build & push Docker image:
   ```bash
   docker build -t <acr-name>.azurecr.io/weather-app:<tag> ./app
   docker push <acr-name>.azurecr.io/weather-app:<tag>
   ```

---

## 📸 Screenshot Example

Include screenshots of:
- GitHub Actions workflow runs.
- AKS service external IP in `kubectl get svc`.

---

## 🧹 Clean Up

To avoid charges:
```bash
az group delete --name cst8918-final-project-group-11 --yes --no-wait
```

---

