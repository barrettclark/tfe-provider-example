terraform {
  required_version = "~> 1.4"
  cloud {
    organization = "barretto"
    workspaces {
      name = "provider-master"
    }
  }

  required_providers {
    tfe = {
      version = "~> 0.44.0"
    }
  }
}

# This needs to be set in TFC so the provider can use it to do it's work
# The user token should be in the owners group to create organizations
variable "token" {}
provider "tfe" {
  token = var.token
}

# Create an organization
variable "organization_name" {}
variable "organization_email" {}
resource "tfe_organization" "tfc-organization" {
  name  = var.organization_name
  email = var.organization_email
}

# Create a workspace
variable "workspace_name" {}
resource "tfe_workspace" "tfc-workspace" {
  name         = var.workspace_name
  organization = tfe_organization.tfc-organization.name
  tag_names    = ["test", "app"]
}
