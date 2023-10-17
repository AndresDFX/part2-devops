resource "kubernetes_deployment" "app" {
  metadata {
    name = "my-app"
  }

  spec {
    replicas = var.app_replica_count

    selector {
      match_labels = {
        App = "my-app"
      }
    }

    template {
      metadata {
        labels = {
          App = "my-app"
        }
      }

      spec {
        container {
          image = var.app_image
          name  = "my-app"
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "my-app-service"
  }

  spec {
    selector = {
      App = kubernetes_deployment.app.metadata[0].labels.App
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}

resource "kubernetes_ingress" "app" {
  metadata {
    name = "my-app-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "alb"
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
    }
  }

  spec {
    rule {
      http {
        path {
          backend {
            service_name = kubernetes_service.app.metadata[0].name
            service_port = "80"
          }

          path = "/*"
        }
      }
    }
  }

  wait_for_load_balancer = true
}

