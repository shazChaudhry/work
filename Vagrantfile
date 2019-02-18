# -*- mode: ruby -*-
# vi: set ft=ruby :

$install_python_and_pip = <<SCRIPT
# https://www.rosehosting.com/blog/how-to-install-python-3-6-4-on-centos-7/
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum update
export PYTHON_VERSION=36u
yum install -y python${PYTHON_VERSION} python${PYTHON_VERSION}-libs python${PYTHON_VERSION}-devel python${PYTHON_VERSION}-pip
pip3.6 install --upgrade pip
pip3.6 install virtualenv
pip3.6 install awscli
SCRIPT

$install_ruby = <<SCRIPT
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel
yum install -y libyaml-devel libffi-devel openssl-devel make
yum install -y bzip2 autoconf automake libtool bison iconv-devel
runuser -l  vagrant -c 'curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -'
runuser -l  vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable --ruby'
runuser -l  vagrant -c 'source /home/vagrant/.rvm/scripts/rvm'
runuser -l  vagrant -c 'rvm install 2.3.1'
runuser -l  vagrant -c 'gem install bundler'
runuser -l  vagrant -c 'rvm rvmrc warning ignore allGemfiles'
SCRIPT

$install_terraform = <<SCRIPT
export TERRAFORM_VERSION=0.11.11
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin/
rm -f terraform*
SCRIPT

Vagrant.configure("2") do |config|

	config.vm.box 									= "bento/centos-7.6"
	config.vm.synced_folder 				".", "/vagrant", type: "virtualbox"
	config.hostmanager.enabled 			= true
	config.hostmanager.manage_host 	= true
	config.hostmanager.manage_guest = true

	config.vm.provision "shell", 	name: "enable epel", 							inline: "yum install -y epel-release"
	config.vm.provision "shell", 	name: "additional tools", 				inline: "yum install -y jq unzip net-tools bind-utils"
	# config.vm.provision :shell, 	name: "Install python and pip", 	inline: $install_python_and_pip
	# config.vm.provision :shell, 	name: "Install aws-profile", 			inline: "pip3.6 install aws-profile"
	# config.vm.provision :shell, 	name: "Install ruby",  						inline: $install_ruby
	# config.vm.provision "shell", 	name: "install ansible", 			  	inline: "yum install --nogpgcheck --assumeyes ansible"
	config.vm.provision :shell,		name: "install terraform", 				inline: $install_terraform

	config.vm.define "work", primary: true do |work|
		work.vm.hostname = 'work'
		work.vm.network :private_network, ip: "192.168.99.201"
		work.vm.provider :virtualbox do |v|
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			v.customize ["modifyvm", :id, "--memory", 3000]
			v.customize ["modifyvm", :id, "--name", "work"]
			v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
		end
		work.vm.provision "file", 	source: "~/.ssh", destination: "$HOME/.ssh"
    work.vm.provision "shell", 	inline: "chmod 600 /home/vagrant/.ssh/*"
		work.vm.provision "file", 	source: "~/.aws", destination: "$HOME/.aws"
    work.vm.provision "shell", 	inline: "chmod 600 /home/vagrant/.aws/*"
	end
	# config.vm.provision "docker"
	# config.vm.provision "shell", 	name: "Initialize swarm manager",
	# 		inline: "docker swarm init --advertise-addr 192.168.99.201 --listen-addr 192.168.99.201:2377"
end
