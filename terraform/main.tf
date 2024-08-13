provider "local" {
  # O provedor "local" é usado para executar comandos locais, como o Vagrant.
}

resource "null_resource" "vagrant_vm" {
  provisioner "local-exec" {
    command = <<EOT
      # vagrant init hashicorp/bionic64
      cd /home/danielrpgj/dev/src/vagrant-kubeadm-kubernetes/masternode/
      vagrant up
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "vagrant destroy -f"
  }
}

output "vagrant_vm_status" {
  value = "VM provisionada com sucesso"
}
