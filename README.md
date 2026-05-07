# DevOps Terraform Task

This repository contains Terraform configurations for deploying Azure infrastructure, including a bastion virtual machine, networking components, and storage resources. The setup is modular and supports multiple environments (dev, uat, prod).

## Directory Structure

```
devops-terraform-task/
├── .github/
│   └── workflows/
│       ├── terraform.yml    # GitHub Actions workflow for CI/CD
├── code/                    # Main Terraform configuration
│   ├── main.tf              # Root module configuration
│   ├── variables.tf         # Variable definitions
│   ├── locals.tf            # Local value definitions
│   ├── provider.tf          # Provider configurations
│   ├── backend.tf           # Backend configuration
│   ├── versions.tf          # Version constraints
│   ├── bastion_vm.tf        # Bastion VM configuration
│   ├── storage.tf           # Storage resources
│   └── env/                 # Environment-specific configs (placeholder)
├── env/                     # Environment configurations
│   ├── dev/
│   │   ├── backend.hcl      # Dev backend config
│   │   └── terraform.tfvars # Dev variables
│   ├── uat/
│   │   ├── backend.hcl      # UAT backend config
│   │   └── terraform.tfvars # UAT variables
│   └── prod/
│       ├── backend.hcl      # Prod backend config
│       └── terraform.tfvars # Prod variables
├── modules/                 # Reusable Terraform modules
│   ├── linux_virtual_machine/
│   ├── network_interface/
│   ├── network_security_group/
│   ├── public_ip/
│   ├── resource_group/
│   ├── storage_account/
│   ├── storage_account_container/
│   ├── storage_account_network_rules/
│   ├── subnet/
│   ├── subnet_network_security_group_association/
│   └── vnet/
└── README.md               
```

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

## CI/CD Security Scan

The repository includes a GitHub Actions workflow that runs a TFSec security scan before Terraform planning. The workflow:

- initializes Terraform for the selected environment
- downloads the TFSec Linux binary
- scans the `code/` directory for Terraform security issues
- generates SARIF output as `tfsec.sarif`
- uploads the SARIF report using `github/codeql-action/upload-sarif@v4`

This gives you GitHub Security tab visibility for Terraform security findings and ensures security scanning occurs before the plan stage.

## Manual Approval for Apply

The GitHub Actions workflow includes manual approval for the apply stage to ensure changes are reviewed before deployment. The apply job is configured with `environment: ${{ matrix.env }}`, which can be set up with required reviewers in GitHub repository settings:

1. Go to your repository Settings > Environments
2. Create environments named `dev`, `uat`, and `prod`
3. For each environment, add required reviewers under "Environment protection rules"
4. Enable "Required reviewers" and select team members who must approve deployments

This ensures that Terraform apply operations require manual approval from designated reviewers before proceeding.

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