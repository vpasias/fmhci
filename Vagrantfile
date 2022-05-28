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
end
