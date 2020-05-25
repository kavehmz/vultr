resource "local_file" "servers" {
  content = templatefile("servers.tmpl", {servers = vultr_server.servers.*.main_ip})
  filename        = "./ssh/servers.sh"
  file_permission = "0750"
}
