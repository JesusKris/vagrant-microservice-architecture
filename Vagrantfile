# -*- mode: ruby -*-
# vi: set ft=ruby :


# All Vagrant configuration is done below. Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  
  config.vagrant.plugins = ["vagrant-env"]
  config.env.enable
  config.vm.box = ENV['VAGRANT_BOX']


  #billing-vm
  config.vm.define "billing" do |billing|
    
    billing.vm.box = ENV['VAGRANT_BOX']

    billing.vm.hostname = "billing-app"

    billing.vm.network "private_network", ip: ENV['BILLING_PRIVATE_NET_IP']

    billing.vm.synced_folder ".", "/vagrant/", type: "rsync",
    rsync__args: ["-r", "--include=src", "--exclude=src/billing-app/node_modules", "--exclude=src/billing-app/package-lock.json", "--include=src/billing-app/***", "--exclude=*"]

    billing.vm.synced_folder ".", "/vagrant/src/billing-app", type: "rsync", rsync__args: ["-r", "--include=.env","--exclude=*"]

    billing.vm.provision "shell", privileged: false, path: "./scripts/setup_node_server.sh", args: ["/vagrant/src/billing-app", "billing-app"]
    
    billing.vm.provision "shell", path: "./scripts/setup_rabbitmq.sh", args: [ENV['RABBITMQ_NET_IP'], ENV['RABBITMQ_PORT'], ENV['RABBITMQ_USER'], ENV['RABBITMQ_PASSWORD']], privileged: false
    
    billing.vm.provision "shell", path: "./scripts/setup_pg.sh", args: [ENV["POSTGRES_USERNAME"], ENV["POSTGRES_PASSWORD"], ENV["BILLING_POSTGRES_DATABASE"]]
    
    billing.vm.provision "shell", path: "./scripts/run_migrations.sh", args: ["/vagrant/src/billing-app/data/"]
  end


  # # #inventory-vm
  config.vm.define "inventory" do |inventory|

    inventory.vm.box = ENV['VAGRANT_BOX']

    inventory.vm.hostname = "inventory-app"

    inventory.vm.network "private_network", ip: ENV['INVENTORY_PRIVATE_NET_IP']

    inventory.vm.synced_folder ".", "/vagrant/", type: "rsync",
   rsync__args: ["-r", "--include=src", "--exclude=src/inventory-app/node_modules", "--exclude=src/inventory-app/package-lock.json", "--include=src/inventory-app/***", "--exclude=*"]

    inventory.vm.synced_folder ".", "/vagrant/src/inventory-app", type: "rsync", rsync__args: ["-r", "--include=.env","--exclude=*"]

    inventory.vm.provision "shell", path: "./scripts/setup_pg.sh", args: [ENV["POSTGRES_USERNAME"], ENV["POSTGRES_PASSWORD"], ENV["INVENTORY_POSTGRES_DATABASE"]]
   
    inventory.vm.provision "shell", privileged: false, path: "./scripts/setup_node_server.sh", args: ["/vagrant/src/inventory-app", "inventory-app"]
   
    inventory.vm.provision "shell", path: "./scripts/run_migrations.sh", args: ["/vagrant/src/inventory-app/data/"]
  end


  # #gateway-vm
  config.vm.define "gateway" do |gateway|

   gateway.vm.box = ENV['VAGRANT_BOX']

   gateway.vm .hostname = "api-gateway"

   gateway.vm.network "forwarded_port", guest: ENV['EXPRESS_PORT'], host: 8080

   gateway.vm.network "private_network", ip: ENV['GATEWAY_PRIVATE_NET_IP']

   gateway.vm.synced_folder ".", "/vagrant/", type: "rsync",
    rsync__args: ["-r", "--include=src", "--exclude=src/api-gateway/node_modules", "--exclude=src/api-gateway/package-lock.json", "--include=src/api-gateway/***", "--exclude=*"]

   gateway.vm.synced_folder ".", "/vagrant/src/api-gateway", type: "rsync",
    rsync__args: ["-r", "--include=.env","--exclude=*"]

   gateway.vm.provision "shell", privileged: false, path: "./scripts/setup_node_server.sh", args: ["/vagrant/src/api-gateway", "api-gateway"]
  end

  
end