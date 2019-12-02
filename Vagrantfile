VAGRANT_API_VERSION  = "2"

Vagrant.configure(VAGRANT_API_VERSION) do |config|

	config.vagrant.plugins = "vagrant-disksize"
        config.vm.box = "ubuntu/bionic64"
	config.disksize.size = '50GB'

        config.vm.provider "virtualbox" do |vb|
                vb.name = "Developer machine"
                vb.cpus = 2
                vb.memory = 4096
				config.ssh.forward_agent = true
        config.ssh.forward_x11 = true
        
        vb.customize ["modifyvm", :id, "--vram", "128"]
				vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]								
        vb.gui = true
        end
		
       config.vm.provision "shell", path:"init.sh"		

end
