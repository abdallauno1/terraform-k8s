resource "kubernetes_deployment" "resumeapp" {
  metadata {
    name = "resumeapp"
  }
  spec {
    selector {
      match_labels = {
        "app" = "resumeapp"
      }
    }
    replicas = 2
    template {
      metadata {
      labels = {
        "app" = "resumeapp"
       }
      }
    spec {
          container {
              name  = "resumeapp"
              image = "abdallauno1/resumeapp:v1"
              port {
                  container_port = 5000
              }
          }
          
        }
      }
    
    }
}