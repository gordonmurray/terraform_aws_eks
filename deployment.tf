resource "kubernetes_deployment" "hello_world_deployment" {
  metadata {
    name      = "kubernetes-example-deployment"
    namespace = "hello-world-namespace"
    labels = {
      app = "hello-world-example"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "hello-world-example"
      }
    }
    template {
      metadata {
        labels = {
          app = "hello-world-example"
        }
      }
      spec {
        container {
          image = "heroku/nodejs-hello-world"
          name  = "hello-world"
        }
      }
    }
  }
}