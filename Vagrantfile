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
    lv.storage :file, :size => '120G'
    lv.nic_model_type = "e1000"
    config.vm.synced_folder '.', '/vagrant', type: 'nfs', nfs_version: '4.2', nfs_udp: false
  end

  ##### DEFINE VM for pmx1 #####

  config.vm.define "pmx1" do |device|
      device.vm.hostname = "pmx1"
      ip = '10.0.0.101'
      lo0 = 'fc00::1'
      rid = '0.0.0.1'
      # link for eth1    
      device.vm.network :private_network,
        ip: ip,
        auto_config: false,
        libvirt__dhcp_enabled: false,
        libvirt__forward_mode: 'none'
      # link for eth2 --> pmx2:eth2
      device.vm.network :private_network,
        :libvirt__tunnel_type => 'udp',
        :libvirt__tunnel_local_ip => '127.0.0.1',
        :libvirt__tunnel_local_port => "1122",
        :libvirt__tunnel_ip => '127.0.0.1',
        :libvirt__tunnel_port => '1111',
        :libvirt__iface_name => "vif_pmx1_2"
      # link for eth3 --> pmx3:eth2
      device.vm.network :private_network,
        :libvirt__tunnel_type => 'udp',
        :libvirt__tunnel_local_ip => '127.0.0.1',
        :libvirt__tunnel_local_port => "1133",
        :libvirt__tunnel_ip => '127.0.0.1',
        :libvirt__tunnel_port => '1111',
        :libvirt__iface_name => "vif_pmx1_3"
      device.vm.provision :shell, path: 'provision.sh', args: [ip, lo0]
      device.vm.provision :shell, path: 'provision-pveproxy-certificate.sh', args: ip
      device.vm.provision :shell, path: 'frr.sh', args: rid
      device.vm.provision :shell, path: 'summary.sh', args: ip
end

  ##### DEFINE VM for pmx2 #####
  
  config.vm.define "pmx2" do |device|
      device.vm.hostname = "pmx2"
      # link for eth0
      ip = '10.0.0.102'
      lo0 = 'fc00::2'
      rid = '0.0.0.2'
      device.vm.network :private_network,
        ip: ip,
        auto_config: false,
        libvirt__dhcp_enabled: false,
        libvirt__forward_mode: 'none'
      # link for eth1 --> pmx1:eth2
      device.vm.network :private_network,
        :libvirt__tunnel_type => 'udp',
        :libvirt__tunnel_local_ip => '127.0.0.1',
        :libvirt__tunnel_local_port => "1122",
        :libvirt__tunnel_ip => '127.0.0.1',
        :libvirt__tunnel_port => '2222',
        :libvirt__iface_name => "vif_pmx2_2"
      # link for eth2 --> pmx3:eth3
      device.vm.network :private_network,
        :libvirt__tunnel_type => 'udp',
        :libvirt__tunnel_local_ip => '127.0.0.1',
        :libvirt__tunnel_local_port => "2233",
        :libvirt__tunnel_ip => '127.0.0.1',
        :libvirt__tunnel_port => '2222',
        :libvirt__iface_name => "vif_pmx2_3"
      device.vm.provision :shell, path: 'provision.sh', args: [ip, lo0]
      device.vm.provision :shell, path: 'provision-pveproxy-certificate.sh', args: ip
      device.vm.provision :shell, path: 'frr.sh', args: rid
      device.vm.provision :shell, path: 'summary.sh', args: ip
end

  ##### DEFINE VM for pmx3 #####
  
  config.vm.define "pmx3" do |device|
      device.vm.hostname = "pmx3"    
      # link for eth0
      ip = '10.0.0.103'
      lo0 = 'fc00::3'
      rid = '0.0.0.3'    
      device.vm.network :private_network,
        ip: ip,
        auto_config: false,
        libvirt__dhcp_enabled: false,
        libvirt__forward_mode: 'none'
      # link for eth1 --> pmx1:eth3
      device.vm.network :private_network,
        :libvirt__tunnel_type => 'udp',
        :libvirt__tunnel_local_ip => '127.0.0.1',
        :libvirt__tunnel_local_port => "1133",
        :libvirt__tunnel_ip => '127.0.0.1',
        :libvirt__tunnel_port => '3333',
        :libvirt__iface_name => "vif_pmx3_2"
      # link for eth2 --> pmx2:eth3
      device.vm.network :private_network,
        :libvirt__tunnel_type => 'udp',
        :libvirt__tunnel_local_ip => '127.0.0.1',
        :libvirt__tunnel_local_port => "2233",
        :libvirt__tunnel_ip => '127.0.0.1',
        :libvirt__tunnel_port => '3333',
        :libvirt__iface_name => "vif_pmx3_3"
      device.vm.provision :shell, path: 'provision.sh', args: [ip, lo0]
      device.vm.provision :shell, path: 'provision-pveproxy-certificate.sh', args: ip
      device.vm.provision :shell, path: 'frr.sh', args: rid    
      device.vm.provision :shell, path: 'summary.sh', args: ip       
end

end
