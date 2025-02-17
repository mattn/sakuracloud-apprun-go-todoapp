terraform {
  required_providers {
    sakuracloud = {
      source = "sacloud/sakuracloud"

      version = "~> 2"
    }
  }
}

provider "sakuracloud" {
}
