job "basic" {
    datacenters = ["dc1"]
    node_pool = "app_pool"
    type = "service"
    
    update {
        stagger = "30s"
        max_parallel = 1
    }

    group "basic" {
        count = 1

        network {
            mode = "bridge"
            port "http" {
                to = 3000
            }
        }

        service {
            name = "basic"
            tags = ["urlprefix-/basic strip=/basic"]
            port = "http"
            provider = "consul"

            check {
                type     = "http"
                path     = "/version"
                interval = "30s"
                timeout  = "30s"
            }
        }

        task "basic" {
            driver = "docker"

            config {
                image = "glendmaatita/exercise-app:latest"
                ports = ["3000"]
            }
        }
    }
}