# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # forwarding de puerto desde el puerto host al puerto de la vm:
  config.vm.network 'forwarded_port', guest: 22, host: 9922, id: 'ssh', auto_correct: true
  
  config.vm.hostname = "pythonvm"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
    vb.cpus = 2
    # vb.memory = "4096"
    # vb.cpus = 4
    vb.name = "pythonvm"
    vb.customize ['modifyvm', :id, '--vram', '256']
    vb.customize ['modifyvm', :id, '--accelerate2dvideo', 'off']
    vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end

  # Update repositories
  config.vm.provision :shell, inline: "sudo apt update -y"

  # Upgrade installed packages
  config.vm.provision :shell, inline: "sudo apt upgrade -y"

  # # Add desktop environment
  config.vm.provision 'shell', privileged: false, path: 'provision/xfce4.sh', name: 'xfce4.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/vboxadds.sh', name: 'vboxadds.sh'
  # # Add `vagrant` to Administrator
  # config.vm.provision :shell, inline: "sudo usermod -a -G sudo vagrant"
      
  config.vm.provision 'shell', privileged: false, path: 'provision/utils.sh', name: 'utils.sh'
  
  config.vm.provision 'shell', privileged: false, path: 'provision/atom.sh', name: 'atom.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/vscode.sh', name: 'vscode.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/fonts.sh', name: 'fonts.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/local.sh', name: 'local.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/python310.sh', name: 'python310.sh'

  ## Copiamos los launchers del escritorio
  config.vm.provision "file", source: "./desktop_launchers/.", destination: "$HOME/Desktop/"
  config.vm.provision :shell, inline: "sudo chown vagrant:vagrant /home/vagrant/Desktop/*.desktop"
  config.vm.provision :shell, inline: "sudo chmod +x /home/vagrant/Desktop/*.desktop"

  # Restart
  config.vm.provision :shell, inline: "sudo shutdown -r now"

end
