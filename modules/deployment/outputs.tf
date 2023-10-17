output "app_url" {
  description = "URL para acceder a la aplicación."
  value      = kubernetes_ingress.app.load_balancer_ingress[0].hostname
}
