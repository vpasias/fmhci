ENV['VAGRANT_EXPERIMENTAL'] = 'typed_triggers'

Vagrant.configure('2') do |config|
  config.vm.provider :libvirt do |config|
    config.vm.box = 'proxmox-ve-amd64'
    config.management_network_address = "10.0.0.0/24"
    config.management_network_name = "mgm1"
    config.nic_adapter_count = 130
    config.memory = 16*1024
    config.cpus = 4
    config.cpu_mode = 'host-passthrough'
    config.nested = true
    config.keymap = 'en'
    config.machine_virtual_size = 30
    config.nic_model_type = "e1000"
    config.vm.synced_folder '.', '/vagrant', disabled: true
  end

  ##### DEFINE VM for pmx1 #####

  config.vm.define "pmx1" do |device|
      # link for eth0
      ip = '10.0.0.101'
      device.vm.network :private_network,
            ip: ip,
            auto_config: false,
            libvirt__dhcp_enabled: false,
            libvirt__forward_mode: 'none'
      # link for eth1 --> pmx2:eth1
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:01",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.1.1.1',
            :libvirt__tunnel_local_port => '1002',
            :libvirt__tunnel_ip => '127.1.2.1',
            :libvirt__tunnel_port => '1002',
            :libvirt__iface_name => 'eth1',
            auto_config: false
      # link for eth2 --> pmx3:eth1
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:02",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.1.1.2',
            :libvirt__tunnel_local_port => '1003',
            :libvirt__tunnel_ip => '127.1.3.1',
            :libvirt__tunnel_port => '1003',
            :libvirt__iface_name => 'eth2',
            auto_config: false
end

  ##### DEFINE VM for pmx2 #####
  
  config.vm.define "pmx2" do |device|
      # link for eth0
      ip = '10.0.0.102'
      device.vm.network :private_network,
            ip: ip,
            auto_config: false,
            libvirt__dhcp_enabled: false,
            libvirt__forward_mode: 'none'
      # link for eth1 --> pmx1:eth1
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:03",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.1.2.1',
            :libvirt__tunnel_local_port => '1002',
            :libvirt__tunnel_ip => '127.1.1.1',
            :libvirt__tunnel_port => '1002',
            :libvirt__iface_name => 'eth1',
            auto_config: false
      # link for eth2 --> pmx3:eth2
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:04",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.1.2.2',
            :libvirt__tunnel_local_port => '2003',
            :libvirt__tunnel_ip => '127.1.3.2',
            :libvirt__tunnel_port => '2003',
            :libvirt__iface_name => 'eth2',
            auto_config: false
end

  ##### DEFINE VM for pmx3 #####
  
  config.vm.define "pmx3" do |device|
      # link for eth0
      ip = '10.0.0.103'
      device.vm.network :private_network,
            ip: ip,
            auto_config: false,
            libvirt__dhcp_enabled: false,
            libvirt__forward_mode: 'none'  
      # link for eth1 --> pmx1:eth2
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:05",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.1.3.1',
            :libvirt__tunnel_local_port => '1003',
            :libvirt__tunnel_ip => '127.1.1.2',
            :libvirt__tunnel_port => '1003',
            :libvirt__iface_name => 'eth1',
            auto_config: false
      # link for eth2 --> pmx2:eth2
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:06",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.1.3.2',
            :libvirt__tunnel_local_port => '2003',
            :libvirt__tunnel_ip => '127.1.2.2',
            :libvirt__tunnel_port => '2003',
            :libvirt__iface_name => 'eth2',
            auto_config: false
end

end
