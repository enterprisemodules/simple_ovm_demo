# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant file dedicated for development purposes
# This setup creates 2 VMs
# One ovm_host with installed manager IP 172.28.128.3
# One ovm_server for management purposes IP 172.28.128.19

Vagrant.configure(2) do |config|
  config.vm.define :ovm_host do |ovm_host|
    ovm_host.ssh.forward_agent = true

    # Oracle linux box
    ovm_host.vm.box = "mleonard87/oracle-linux-70-uek-x64"

    ovm_host.vm.provider "virtualbox" do |v|
      v.memory = 16384
      v.cpus = 2
      v.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    end

    ovm_host.ssh.insert_key = false

    # Setup port forwarding
    ovm_host.vm.hostname = 'ovmm.example.com'
    ovm_host.vm.network "private_network", ip: "172.28.128.3"

    # Hosts and fqdn settings
    ovm_host.vm.provision :shell, inline: <<-EOD.gsub(/^\s*/, '')
      cat > /etc/hosts<< "EOF"
      127.0.0.1 localhost.localdomain localhost4 localhost4.localdomain4
      127.0.0.1 localhost.localdomain localhost localhost.localdomain
      127.0.0.1 localhost.localdomain localhost localhost.localdomain
      127.0.0.1 ovmm.example.com puppet master
      EOF
    EOD

    # Add GitHub to known hosts
    ovm_host.vm.provision :shell, privileged: false, inline:  "ssh-keyscan -H github.com >> ~/.ssh/known_hosts"

    # Installation of Puppet
    ovm_host.vm.provision :shell, inline:  "/bin/sh /vagrant/vm-scripts/install_puppet.sh"
    # Installation of r10k
    ovm_host.vm.provision :shell, inline:  "/bin/sh /vagrant/vm-scripts/install_r10k.sh"
    # Installation of Puppet Modules
    ovm_host.vm.provision :shell, privileged: false, inline:  "/bin/sh /vagrant/vm-scripts/setup_puppet.sh"
    # Setup of Puppet Module Paths
    ovm_host.vm.provision :shell, inline:  "/bin/sh /vagrant/vm-scripts/puppet_paths.sh"

    # Installation of dependent libraries for Oracle VM Manager
    # and setup for Oracle Databases
    ovm_host.vm.provision :shell, inline: <<-EOD.gsub(/^\s*/, '')
      sudo -i;
      sudo useradd oracle;
      sudo groupadd dba;
      sudo usermod -a -G dba oracle;
      yum install -y zip unzip libaio net-tools perl-Data-Dumper iptables-services expect expect-dev;
      yum remove -y mariadb-libs;
      cd /vagrant/software;
      mkdir /mnt/iso;
      mount -t iso9660 -o loop V952529-01.iso /mnt/iso;
      bash /mnt/iso/createOracle.sh
    EOD

    # Installation of Oracle VM Manager
    ovm_host.vm.provision :shell, inline: 'sudo -i; sudo bash /mnt/iso/runInstaller.sh --config=/vagrant/config.yml --assumeyes --installtype=Install'

    # Apply ovm config
    ovm_host.vm.provision :shell, inline: 'sudo -i; puppet apply /vagrant/manifests/ovm_manager.pp'

    # Set firewall
    ovm_host.vm.provision :shell, inline: <<-EOD.gsub(/^\s*/, '')
      sudo -i;
      service iptables stop;
      chkconfig iptables off;
      iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 7001 -j ACCEPT;
      iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 7002 -j ACCEPT;
      iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 15901 -j ACCEPT;
      iptables -A INPUT -m state --state NEW -m udp -p udp --dport 123 -j ACCEPT;
      service iptables save
    EOD
  end

  config.vm.define :nfs_server_1 do |nfs_server_1|
    nfs_server_1.vm.box = "openstack-user/nfs-server"

    nfs_server_1.vm.hostname = 'nfsserver1.example.com'
    nfs_server_1.vm.network "private_network", ip: "172.28.128.49"

    # Disabled folder syncing
    nfs_server_1.vm.synced_folder '.', '/vagrant', disabled: true

    nfs_server_1.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 1
      v.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
    end
  end
end
