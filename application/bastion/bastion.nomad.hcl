// job's name 
job "bastion" {
    // set a datacenter where the job will be deployed
    datacenters = ["dc1"]
    node_pool = "app_pool"

    // set the type of the job
    type = "service"
    
    // define how the job will be updated
    update {
        stagger = "30s"
        max_parallel = 1
    }

    group "bastion" {
        count = 1
        task "bastion" {
            driver = "docker"

            config {
                image = "glendmaatita/bastion:latest"
            }

            resources {
                cpu = 50
                memory = 100
            }
        }
    }
}