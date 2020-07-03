locals {
    b_region = keys(var.region_zone_map)[0]
    b_zone = var.region_zone_map[local.b_region][0]
}

resource "google_compute_address" "bastion-ip" {
    name      = "db-bastion-ip"
    address_type = "EXTERNAL"
    region    = "us-west1"
}

resource "google_compute_instance" "bastion" {
    name   = format("%$-db-bastion", var.environment)
    machine_type = "n1-standard-1"
    zone   = local.b_zone

    boot_disc {
        initialize_params {
            image = "debian-cloud/debian-9"
            type = "pd-ssd"
        }
    }
}
