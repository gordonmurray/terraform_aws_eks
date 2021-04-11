resource "kubernetes_ingress" "ingress" {
  metadata {
    labels = {
      app                               = "ingress-nginx"
    }
    name = "api-ingress"
    namespace = "hello-world-namespace"
    annotations = {
      "kubernetes.io/ingress.class": "nginx-hello-world-namespace"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/"
          backend {
            service_name = "hello-world-example"
            service_port = 3000
          }
        }
      }
    }
  }
}