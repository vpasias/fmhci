ENV['VAGRANT_EXPERIMENTAL'] = 'typed_triggers,disks'

Vagrant.configure('2') do |config|
  config.vm.box = 'proxmox-ve-amd64'
  config.vm.provider :libvirt do |lv, config|
    lv.nic_adapter_count = 8
    lv.memory = 16*1024
    lv.cpus = 4
    lv.cpu_mode = 'host-passthrough'
    lv.nested = true
    lv.keymap = 'en'
    lv.machine_virtual_size = 30
    lv.nic_model_type = "e1000"
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
            :libvirt__tunnel_type => "udp",
            :libvirt__tunnel_local_ip => "127.1.1.1",
            :libvirt__tunnel_local_port => "1002",
            :libvirt__tunnel_ip => "127.1.2.1",
            :libvirt__tunnel_port => "1002",
            auto_config: false
      # link for eth2 --> pmx3:eth1
      device.vm.network "private_network",
            :libvirt__tunnel_type => "udp",
            :libvirt__tunnel_local_ip => "127.1.1.2",
            :libvirt__tunnel_local_port => "1003",
            :libvirt__tunnel_ip => "127.1.3.1",
            :libvirt__tunnel_port => "1003",
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
            :libvirt__tunnel_type => "udp",
            :libvirt__tunnel_local_ip => "127.1.2.1",
            :libvirt__tunnel_local_port => "1002",
            :libvirt__tunnel_ip => "127.1.1.1",
            :libvirt__tunnel_port => "1002",
            auto_config: false
      # link for eth2 --> pmx3:eth2
      device.vm.network "private_network",
            :libvirt__tunnel_type => "udp",
            :libvirt__tunnel_local_ip => "127.1.2.2",
            :libvirt__tunnel_local_port => "2003",
            :libvirt__tunnel_ip => "127.1.3.2",
            :libvirt__tunnel_port => "2003",
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
            :libvirt__tunnel_type => "udp",
            :libvirt__tunnel_local_ip => "127.1.3.1",
            :libvirt__tunnel_local_port => "1003",
            :libvirt__tunnel_ip => "127.1.1.2",
            :libvirt__tunnel_port => "1003",
            auto_config: false
      # link for eth2 --> pmx2:eth2
      device.vm.network "private_network",
            :libvirt__tunnel_type => "udp",
            :libvirt__tunnel_local_ip => "127.1.3.2",
            :libvirt__tunnel_local_port => "2003",
            :libvirt__tunnel_ip => "127.1.2.2",
            :libvirt__tunnel_port => "2003",
            auto_config: false
end

end
