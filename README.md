# DevOps Terraform Task

This repository contains Terraform configurations for deploying Azure infrastructure, including a bastion virtual machine, networking components, and storage resources. The setup is modular and supports multiple environments (dev, uat, prod).

## Architecture

The infrastructure is designed to provision a secure Azure environment with the following key components:

- **Resource Group**: A dedicated resource group for organizing resources.
- **Virtual Network (VNet)**: A virtual network with public and private subnets.
- **Subnets**: 
  - Public subnet for bastion VM access.
  - Private subnet for internal resources, with service endpoints for storage.
- **Bastion VM**: A Linux virtual machine in the public subnet, configured with a public IP, network interface, and network security group (NSG) for secure access.
- **Storage**: Storage accounts and containers for data persistence.
- **Modules**: Reusable Terraform modules for each resource type (e.g., VM, network interface, NSG, etc.), promoting code reusability and maintainability.

The architecture follows Azure best practices for isolation, security, and scalability.

## Multi-Environment Strategy

This project supports multiple environments: development (dev), user acceptance testing (uat), and production (prod). Each environment is configured separately using:

- **Environment-specific variables**: Defined in `env/{env}/terraform.tfvars` files.
- **Backend configuration**: Each environment uses its own Azure backend (storage account) for state management, specified in `env/{env}/backend.hcl`.

### Resource Group vs. Subscription Rationale

We use **resource groups per environment** within the same Azure subscription instead of separate subscriptions for the following reasons:

- **Cost Management**: Easier to manage billing and costs at the subscription level while isolating resources via resource groups.
- **Access Control**: Resource groups allow fine-grained RBAC without the overhead of managing multiple subscriptions.
- **Simplicity**: For this setup, resource groups provide sufficient isolation without the complexity of cross-subscription dependencies.
- **Scalability**: If the project grows, migrating to separate subscriptions is feasible, but resource groups suffice for current needs.

This approach balances isolation with operational simplicity.

## Running Locally

To deploy the infrastructure locally:

1. **Prerequisites**:
   - Install Terraform (version specified in `versions.tf`).
   - Azure CLI installed and authenticated (`az login`).
   - Access to the Azure subscription.

2. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd devops-terraform-task
   ```

3. **Navigate to the Code Directory**:
   ```bash
   cd code
   ```

4. **Initialize Terraform** (for a specific environment, e.g., dev):
   ```bash
   terraform init -backend-config=../env/dev/backend.hcl
   ```

5. **Plan the Deployment**:
   ```bash
   terraform plan -var-file=../env/dev/terraform.tfvars
   ```

6. **Apply the Changes**:
   ```bash
   terraform apply -var-file=../env/dev/terraform.tfvars
   ```

7. **Destroy Resources** (when needed):
   ```bash
   terraform destroy -var-file=../env/dev/terraform.tfvars
   ```

Note: Ensure the `backend.hcl` and `terraform.tfvars` files are configured with appropriate values for your Azure environment.

## Tagging Enforcement

Tagging is enforced through Terraform variables and module configurations:

- **Common Tags**: Defined in `variables.tf` as `common_tags_primary` and `common_tags_secondary`, which include environment-specific metadata.
- **Resource-Specific Tags**: Each module merges common tags with resource-specific tags (e.g., `Name`, `resource_type`).
- **Enforcement**: Tags are applied consistently across all resources via the `merge()` function in module calls, ensuring compliance and easier resource management.

Example from `main.tf`:
```hcl
tags = merge(
  var.common_tags_primary,
  {
    Name          = "rg-${local.common_name}-001"
    resource_type = "Resource Group"
  }
)
```

## Code Quality Tools

To maintain high code quality, consider adding the following tools:

- **TFLint**: A linter for Terraform that checks for syntax errors, best practices, and potential issues.
- **TFSec**: A security scanner for Terraform code that identifies security vulnerabilities and compliance issues.
- **Terraform-Docs**: A tool to generate documentation from Terraform modules, keeping READMEs and docs in sync with code changes.

Integrate these into your CI/CD pipeline for automated checks.