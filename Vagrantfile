# -*- mode: ruby -*-
# vi: set ft=ruby :

### configuration parameters ###
# New user name
NEWUSER = "alumno"
NEWUSERPASSWORD = "alumno"

Vagrant.configure("2") do |config|
  VAGRANT_COMMAND = ARGV[0]
  if VAGRANT_COMMAND == "ssh"
      config.ssh.username = NEWUSER
  end

  config.vm.box = "ubuntu/focal64"

  # Forwarding port from host 9922 to guest 22
  config.vm.network 'forwarded_port', guest: 22, host: 9922, id: 'ssh', auto_correct: true
  
  config.vm.hostname = "pythonvm"
  config.vm.synced_folder '.', '/vagrant', disabled: true

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
    vb.customize ['modifyvm', :id, '--uartmode1', 'disconnected']
  end

  # Update repositories
  config.vm.provision :shell, inline: "sudo apt update -y"

  # Upgrade installed packages
  config.vm.provision :shell, inline: "sudo apt upgrade -y"

  # Remove ubuntu user
  config.vm.provision :shell, inline: "sudo deluser --remove-home ubuntu"

  # Create new user and use it to run commands
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    # Create new user and use it to run commands
    USER=#{NEWUSER}
    PASSWORD=#{NEWUSERPASSWORD}
    useradd -m -s /bin/bash -U $USER -u 666 -p $(openssl passwd -1 $PASSWORD) --groups sudo
    cp -pr /home/vagrant/.ssh /home/$USER/
    chown -R $USER:$USER /home/$USER
    echo "%$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER
  SHELL

  # Install required packages
  config.vm.provision 'shell', privileged: false, path: 'provision/xfce4.sh', name: 'xfce4.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/vboxadds.sh', name: 'vboxadds.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/utils.sh', name: 'utils.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/atom.sh', name: 'atom.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/vscode.sh', name: 'vscode.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/local.sh', name: 'local.sh'
  config.vm.provision 'shell', privileged: false, path: 'provision/python310.sh', name: 'python310.sh'

  # Prepare NEWUSER desktop
  config.vm.provision "file", source: "./desktop_launchers/.", destination: "/tmp/Desktop/"
  config.vm.provision "shell", inline: <<-SHELL
    echo "Prepare NEWUSER desktop"
    mkdir -p /home/#{NEWUSER}/Desktop/
    sudo cp /tmp/Desktop/*.desktop /home/#{NEWUSER}/Desktop/
    sudo chown -R #{NEWUSER}:#{NEWUSER} /home/#{NEWUSER}/Desktop
    sudo chmod +x /home/#{NEWUSER}/Desktop/*.desktop
  SHELL

  # Add logo to NEWUSER desktop
  config.vm.provision "file", source: "./desktop_launchers/python_logo.png", destination: "/tmp/.face"
  config.vm.provision :shell, privileged: true, inline: "echo 'Copy user logo';mv /tmp/.face /home/#{NEWUSER}/.face"
  config.vm.provision :shell, privileged: true, inline: "echo 'Add user logo';chown #{NEWUSER}:#{NEWUSER} /home/#{NEWUSER}/.face"
  
  # Disable login for vagrant user
  config.vm.provision :shell, privileged: true, inline: "echo -e '[User]\nSystemAccount=true' > /var/lib/AccountsService/users/vagrant"

  # Restart
  config.vm.provision :shell, inline: "sudo shutdown -r now"

end
