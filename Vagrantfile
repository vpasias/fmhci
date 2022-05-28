ENV['VAGRANT_EXPERIMENTAL'] = 'typed_triggers'

Vagrant.configure('2') do |config|
  config.vm.provider :libvirt do |config|
    config.management_network_address = "10.0.0.0/24"
    config.management_network_name = "mgm1"
    config.nic_adapter_count = 130
  end

  ##### DEFINE VM for pmx1 #####

  config.vm.define "pmx1" do |device|
    device.vm.box = 'proxmox-ve-amd64'
    device.vm.provider :libvirt do |v|
      v.memory = 16*1024
      v.cpus = 4
      v.cpu_mode = 'host-passthrough'
      v.nested = true
      v.keymap = 'en'
      v.machine_virtual_size = 30
      v.nic_model_type = "e1000"
    end
  config.vm.synced_folder '.', '/vagrant', disabled: true
    
      # link for eth0
      ip = '10.10.10.2'
      device.vm.network :private_network,
            ip: ip,
            auto_config: false,
            libvirt__dhcp_enabled: false,
            libvirt__forward_mode: 'none'
    
      # link for eth1 --> pmx2:eth1
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:01",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '8001',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '9001',
            :libvirt__iface_name => 'eth1',
            auto_config: false

      # link for eth2 --> pmx3:Gig1
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:02",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '8002',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '9002',
            :libvirt__iface_name => 'eth2',
            auto_config: false
    
end

  ##### DEFINE VM for rtr-2 #####
  
  config.vm.define "rtr-2" do |device|
    device.vm.box = 'proxmox-ve-amd64'

    device.vm.provider :libvirt do |v|
      v.memory = 2048
    end
  config.vm.synced_folder '.', '/vagrant', disabled: true

    # NETWORK INTERFACES
      # link for Gig2 --> rtr-2:Gig2
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:03",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '8013',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '9013',
            :libvirt__iface_name => 'Gig2',
            auto_config: false

    # NETWORK INTERFACES
      # link for Gig3 --> rtr-1:Gig01
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:04",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '9001',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '8001',
            :libvirt__iface_name => 'Gig3',
            auto_config: false

    # NETWORK INTERFACES
      # link for Gig4 --> rtr-4:Gig01
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:04",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '9003',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '8004',
            :libvirt__iface_name => 'Gig4',
            auto_config: false

  config.vm.boot_timeout = 400

  config.ssh.forward_agent = true
  config.ssh.guest_port = 22
  config.ssh.insert_key = false
end

  ##### DEFINE VM for rtr-3 #####
  
  config.vm.define "rtr-3" do |device|
    device.vm.box = 'proxmox-ve-amd64'

    device.vm.provider :libvirt do |v|
      v.memory = 2048
    end
  config.vm.synced_folder '.', '/vagrant', disabled: true

    # NETWORK INTERFACES
      # link for Gig2 --> rtr-2:Gig2
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:22",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '9013',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '8013',
            :libvirt__iface_name => 'Gig2',
            auto_config: false

    # NETWORK INTERFACES
      # link for Gig3 --> rtr-1:Gig02
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:04",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '9002',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '8002',
            :libvirt__iface_name => 'Gig3',
            auto_config: false

    # NETWORK INTERFACES
      # link for Gig4 --> rtr-4:Gig02
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:04",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '9004',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '8005',
            :libvirt__iface_name => 'Gig4',
            auto_config: false

  config.vm.boot_timeout = 400

  config.ssh.forward_agent = true
  config.ssh.guest_port = 22
  config.ssh.insert_key = false
end

end
