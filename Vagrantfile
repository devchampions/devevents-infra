
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.40.140"
  config.vm.provider "virtualbox" do |vb|
    vb.name = "control-machine"
  end
  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end
  config.vm.provision "shell", name: "set-dns", inline: "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
  config.vm.provision "shell", name: "update-apt", inline: "apt-get update -qq -y -o=Dpkg::Use-Pty=0"
  config.vm.provision "shell", name: "install-tools", inline: "apt-get install -qq -y -o=Dpkg::Use-Pty=0 curl zip apt-transport-https ca-certificates software-properties-common jq"
  config.vm.provision "shell", name: "download-terraform", inline: "curl -s -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.9.6/terraform_0.9.6_linux_amd64.zip"
  config.vm.provision "shell", name: "install-terraform", inline: "unzip -q -o -d /usr/bin /tmp/terraform.zip"
  config.vm.provision "shell", name: "add-ansible-repo", inline: "apt-add-repository -y ppa:ansible/ansible && apt-get -y -qq update -o=Dpkg::Use-Pty=0"
  config.vm.provision "shell", name: "install-python-pip", inline: "apt-get -y -qq install -o=Dpkg::Use-Pty=0 python-pip"
  config.vm.provision "shell", name: "install-aws-cli", inline: "pip install awscli"
  config.vm.provision "shell", name: "install-ansible", inline: "apt-get -y -qq install -o=Dpkg::Use-Pty=0 ansible"
end


