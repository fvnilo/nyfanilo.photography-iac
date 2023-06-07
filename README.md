# nyfanilo.photography IaC
> Simple Terraform Configuration For nyfanilo.photography

## Getting Started

### Initialize

1. Create a file called `backend.tfvars` and fill it with this content:

    ```
    bucket  = "<bucket-name>"
    key     = "<tf-state-filename"
    region  = "<region>"
    encrypt = true
    ```

2. Run `terraform init -backend-config=backend.tfvars`

### Apply

1. Run `terraform apply`
