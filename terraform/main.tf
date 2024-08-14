provider "local" {
  # O provedor "local" é usado para executar comandos locais, como o Vagrant.
}

resource "null_resource" "vagrant_vm" {
  provisioner "local-exec" {
    command = <<EOT
      # vagrant init hashicorp/bionic64
      cd /home/danielrpgj/dev/src/vagrant-kubeadm-kubernetes/masternode/
      vagrant up
      # TODO: Implements copy join.sh from master to workernodes
      # TODO: Implements install workernode k8s and join to server
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      # vagrant init hashicorp/bionic64
      cd /home/danielrpgj/dev/src/vagrant-kubeadm-kubernetes/masternode/
      vagrant destroy -f
      cd /home/danielrpgj/dev/src/vagrant-kubeadm-kubernetes/workernode/
      vagrant destroy -f
    EOT
  }
}

output "vagrant_vm_status" {
  value = "VM provisionada com sucesso"
}
