ENV['VAGRANT_EXPERIMENTAL'] = 'typed_triggers'

Vagrant.configure('2') do |config|
  config.vm.box = 'proxmox-ve-amd64'
  config.vm.provider :libvirt do |lv, config|
    lv.management_network_address = "10.0.0.0/24"
    lv.management_network_name = "mgm1"
    lv.nic_adapter_count = 130
    lv.memory = 16*1024
    lv.cpus = 4
    lv.cpu_mode = 'host-passthrough'
    lv.nested = true
    lv.keymap = 'en'
    lv.machine_virtual_size = 30
    config.vm.synced_folder '.', '/vagrant', disabled: true
  end
  ip = '10.10.10.2'
  config.vm.network :private_network,
    ip: ip,
    auto_config: false,
    libvirt__dhcp_enabled: false,
    libvirt__forward_mode: 'none'
  config.vm.provision :shell, path: 'provision.sh', args: ip
  config.vm.provision :shell, path: 'provision-pveproxy-certificate.sh', args: ip
  config.vm.provision :shell, path: 'summary.sh', args: ip
 ##### DEFINE VM for rtr-1 #####

  config.vm.define "rtr-1" do |device|
    device.vm.box = 'proxmox-ve-amd64'

    device.vm.provider :libvirt do |v|
      v.memory = 2048
      v.nic_model_type = "e1000"
    end
  config.vm.synced_folder '.', '/vagrant', disabled: true

    # NETWORK INTERFACES
      # link for Gig01 --> rtr-2:Gig3
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:01",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '8001',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '9001',
            :libvirt__iface_name => 'Gig01',
            auto_config: false

      # link for Gig02 --> rtr-3:Gig3
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:02",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '8002',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '9002',
            :libvirt__iface_name => 'Gig02',
            auto_config: false

  config.vm.boot_timeout = 400

  config.ssh.forward_agent = true
  config.ssh.guest_port = 22
  config.ssh.insert_key = false

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
