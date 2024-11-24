Vagrant.configure("2") do |config|
  config.vm.box = "generic/oracle8"
  config.vm.box_version = "4.3.12"

  config.vm.provider "virtualbox" do |vbox|
    vbox.gui = true
    vbox.cpus = 2
    vbox.memory = 2048
  end

  config.vm.provider "libvirt" do |v|
    v.cpus = 2
    v.memory = 2048
  end

  config.vm.provision "shell", path: "./provision.sh"
end
