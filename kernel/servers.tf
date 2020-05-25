
resource "vultr_server" "servers" {
  count                  = 1
  # amsterdam 7, frankfurt=9, New Jersey=1
  region_id              = "7" 
  # 203=2 cores, 100=baremetal
  plan_id                = "201"
  os_id                  = "352"
  label                  = "kernel-${count.index + 1}"
  hostname               = "kernel-${count.index + 1}"
  ssh_key_ids            = ["${vultr_ssh_key.setup_key.id}"]
  notify_activate        = false
  enable_private_network = true

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${tls_private_key.vult_ssh_key.private_key_pem}"
    host        = "${self.main_ip}"
  }

  provisioner "file" {
    source      = "provision/setup.sh"
    destination = "/tmp/setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup.sh",
      "/tmp/setup.sh",
    ]
  }
}

output "ip_addr" {
  value = "${vultr_server.servers.*.main_ip}"
}
