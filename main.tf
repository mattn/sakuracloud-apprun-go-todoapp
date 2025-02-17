variable "database_url" {
  type = string
}

variable "sakuracr_apprun_username" {
  type = string
}

variable "sakuracr_apprun_password" {
  type = string
}

resource "sakuracloud_apprun_application" "go-todoapp" {
  name            = "go-todoapp"
  timeout_seconds = 300
  port            = 8989
  min_scale       = 0
  max_scale       = 1
  components {
    name       = "go-todoapp"
    max_cpu    = "1"
    max_memory = "2Gi"
    deploy_source {
      container_registry {
        image    = "mattn.sakuracr.jp/go-todoapp:latest"
        server   = "mattn.sakuracr.jp"
        username = var.sakuracr_apprun_username
        password = var.sakuracr_apprun_password
      }
    }
    env {
      key   = "DATABASE_URL"
      value = var.database_url
    }
  }
  traffics {
    version_index = 0
    percent       = 100
  }

  lifecycle {
    ignore_changes = [
      components[0].deploy_source[0].container_registry[0].image,
    ]
  }
}
