resource "kubernetes_service" "hello_world_service" {
  depends_on = [kubernetes_deployment.hello_world_deployment]

  metadata {
    labels = {
      app = "hello-world-example"
    }
    name      = "hello-world-example"
    namespace = "hello-world-namespace"
  }

  spec {
    port {
      name        = "api"
      port        = 3000
      target_port = 3000
    }
    selector = {
      app = "hello-world-example"
    }
    type = "ClusterIP"
  }
}