Vagrant.configure("2") do |config|
  config.vm.box = "roboxes/oracle8"
  config.vm.box_version = "4.3.12"

  config.vm.provider "virtualbox" do |vbox|
    vbox.gui = false
    vbox.cpus = 2
    vbox.memory = 2048

    config.vm.synced_folder __dir__, '/vagrant', type: 'virtualbox'
  end

  config.vm.provider "libvirt" do |v|
    v.cpus = 2
    v.memory = 2048
    v.memorybacking :access, :mode => "shared"

    config.vm.synced_folder __dir__, '/vagrant', type: 'virtiofs'
  end

  config.vm.provision "shell", path: "./provision.sh"
end
