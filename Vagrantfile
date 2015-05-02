# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "http://static.gender-api.com/debian-8-jessie-rc2-x64-slim.box"
  config.vm.hostname = "sshkeymanager"

  config.vm.provision :puppet do |puppet|
    puppet.manifest_file = "sshkeymanager.pp"
    puppet.module_path = "modules"
  end
end
