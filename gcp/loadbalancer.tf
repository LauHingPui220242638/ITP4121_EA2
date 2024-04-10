# resource "google_project" "fit_coral_419306" {
# auto_create_network = true
#   name                = "test"
#   project_id          = "fyp-re"
# }

resource "google_compute_firewall" "default_allow_icmp" {
  allow {
    protocol = "icmp"
  }
  description   = "Allow ICMP from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-icmp"
  network       = google_compute_network.custom-test.self_link
  # network       = google_compute_network.custom-test.self_link
  priority      = 65534
  project       = "fyp-re"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "default_allow_internal" {
  allow {
    ports    = ["0-65535"]
    protocol = "tcp"
  }
  allow {
    ports    = ["0-65535"]
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  description   = "Allow internal traffic on the default network"
  direction     = "INGRESS"
  name          = "default-allow-internal"
  network       = google_compute_network.custom-test.self_link
  priority      = 65534
  project       = "fyp-re"
  source_ranges = ["10.128.0.0/9"]
}

resource "google_compute_firewall" "default_allow_rdp" {
  allow {
    ports    = ["3389"]
    protocol = "tcp"
  }
  description   = "Allow RDP from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-rdp"
  network       = google_compute_network.custom-test.self_link
  priority      = 65534
  project       = "fyp-re"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "default_allow_ssh" {
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  description   = "Allow SSH from anywhere"
  direction     = "INGRESS"
  name          = "default-allow-ssh"
  network       = google_compute_network.custom-test.self_link
  priority      = 65534
  project       = "fyp-re"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "default" {
  name = "website-ip-1"
  provider = google
  region = "asia-east2"
  network_tier = "STANDARD"
}

resource "google_compute_forwarding_rule" "lb_forwarding_rule" {
  ip_address            = google_compute_address.default.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  name                  = "lb-forwarding-rule"
  network               = google_compute_network.custom-test.self_link
  network_tier          = "STANDARD"
  port_range            = "80-80"
  project               = "fyp-re"
  region                = "asia-east2"
  target                = google_compute_region_target_http_proxy.lb_target_proxy.id
}

resource "google_compute_region_backend_service" "backend" {
  connection_draining_timeout_sec = 300
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  locality_lb_policy              = "ROUND_ROBIN"
  name                            = "backend"
  port_name                       = "http"
  project                         = "fyp-re"
  protocol                        = "HTTP"
  region                          = "asia-east2"
  session_affinity                = "NONE"
  timeout_sec                     = 30
  backend {
  group = google_compute_region_network_endpoint_group.pp.self_link
  balancing_mode = "UTILIZATION"
  capacity_scaler = 1.0
 }
}

resource "google_compute_subnetwork" "network" {
  ip_cidr_range              = "10.0.0.0/24"
  name                       = "network"
  network                    = google_compute_network.custom-test.id
  # private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = "fyp-re"
  purpose                    = "REGIONAL_MANAGED_PROXY"
  region                     = "asia-east2"
  role                       = "ACTIVE"
}

resource "google_compute_network" "custom-test" {
  name                    = "test-network123321qwe"
  project                 = "fyp-re"
  auto_create_subnetworks = false
}


resource "google_compute_region_url_map" "lb" {
  default_service = google_compute_region_backend_service.backend.id
  name            = "lb"
  project         = "fyp-re"
  region          = "asia-east2"
}

resource "google_compute_region_target_http_proxy" "lb_target_proxy" {
  name    = "lb-target-proxy"
  project = "fyp-re"
  region  = "asia-east2"
  url_map = google_compute_region_url_map.lb.name
}

resource "google_compute_region_network_endpoint" "region-internet-ip-port-endpoint" {
  region_network_endpoint_group = google_compute_region_network_endpoint_group.pp.name
  region                = "asia-east2"

  ip_address  = "142.251.214.142"
  port        = 80
}


# Network Endpoint Group
resource "google_compute_region_network_endpoint_group" "pp" {
  name                  = "neg"
  network               = google_compute_network.custom-test.id
  region                = "asia-east2"
  network_endpoint_type = "INTERNET_IP_PORT"
}



