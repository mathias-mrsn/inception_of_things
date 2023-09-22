Vagrant.configure("2") do |config|
  config.vm.box = "generic/centos8"
  config.vm.synced_folder ".", "/vagrant", type: 'virtualbox'
  #config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
  config.vm.define "xchalleS" do |control|
	control.vm.hostname = "xchalleS"
	control.vm.network :private_network, ip: "192.168.56.110"
	control.vm.provision "shell", path: "./scripts/masterboot.sh"
	control.vm.provider "virtualbox" do |vb|
			vb.name = "xchalleS"
			vb.cpus = 1
			vb.memory = 512
		end
	  end
   config.vm.define "xchalleWS" do |control2|
	control2.vm.hostname = "xchalleWS"
	control2.vm.network :private_network, ip: "192.168.56.111"
	#control2.vm.network "private_network", type: "dhcp", name: "vboxnet1",ip: "192.168.56.111"
	control2.vm.provision "shell", path: "./scripts/workerboot.sh"
	control2.vm.provider "virtualbox" do |vb|
		vb.name = "xchalleWS"
		vb.cpus = 1
		vb.memory = 512
	end
  end
end
