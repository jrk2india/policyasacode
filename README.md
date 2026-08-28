# Policy as Code

Terraform configuration for provisioning a demonstration Google Compute Engine virtual machine.

## Structure

- `vm/main.tf` — Terraform and Google provider configuration plus the VM resource.
- `vm/variables.tf` — Input variables and their default values.

## Prerequisites

- Terraform `>= 1.5.0`
- A Google Cloud project with billing enabled
- Google Cloud credentials configured for Terraform
- The Compute Engine API enabled in the project

Authenticate locally with Application Default Credentials if needed:

```text
gcloud auth application-default login
```

## Usage

From the `vm` directory, initialize Terraform and review the planned changes:

```text
terraform init
terraform plan -var="project_id=YOUR_PROJECT_ID"
```

Apply the configuration:

```text
terraform apply -var="project_id=YOUR_PROJECT_ID"
```

When the VM is no longer needed, remove it with:

```text
terraform destroy -var="project_id=YOUR_PROJECT_ID"
```

## Variables

| Variable | Description | Default |
| --- | --- | --- |
| `project_id` | Google Cloud project ID | Required |
| `region` | Google Cloud region | `asia-south1` |
| `zone` | Google Cloud zone | `asia-south1-a` |
| `vm_name` | Name of the VM | `atlantis-demo-vm` |
| `machine_type` | GCE machine type | `e2-medium` |
| `boot_image` | Boot disk image | `debian-cloud/debian-12` |
| `boot_disk_size` | Boot disk size in GB | `20` |
| `environment` | Environment label | `dev` |

Example using a variable file:

```hcl
project_id = "your-gcp-project-id"
region     = "asia-south1"
zone       = "asia-south1-a"
```

Save the values as `terraform.tfvars` in `vm/`, then run `terraform plan` or `terraform apply`.

## Resources

The configuration creates:

- One `google_compute_instance` resource
- A balanced persistent boot disk
- A network interface attached to the GCP `default` network
- Labels identifying the environment, Terraform management, and demo purpose
