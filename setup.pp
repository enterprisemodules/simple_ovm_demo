ovm_manager { 'default':
  username    => 'admin',
  password    => 'Password123',
  manager_url => 'https://ovmm.example.com',
  verify_ssl  => false,
  port        => 7002,
}

ovm_server_pool { 'default/server_pool_1':
  ensure          => 'present',
  description     => 'Server Pool Number 1',
  keymap          => 'en-us',
  virtual_ip      => '192.168.56.99',
  vm_start_policy => 'BEST_SERVER',
}

ovm_server { 'default/server_pool_1/ovs01.example.com':
  ensure     => 'present',
  ip_address => '192.168.56.2',
  password   => 'ovsroot',
}

ovm_network { 'default/192.168.56.0':
  ensure => 'present',
  description => 'Test network',
  roles  => ['MANAGEMENT', 'CLUSTER_HEARTBEAT', 'LIVE_MIGRATE', 'VIRTUAL_MACHINE', 'STORAGE'],
}

ovm_file_server { 'default/nfs_server_1':
  ensure          => 'present',
  access_host     => '192.168.56.5',
  admin_servers   => ['ovs01.example.com'],
  uniform_exports => 'true',
  require         => Ovm_server['default/server_pool_1/ovs01.example.com'],
}


ovm_repository { 'default/repo01':
  ensure               => 'present',
  file_system_name     => 'nfs on 192.168.56.5:/var/exports/juno1',
  presented_to_servers => ['ovs01.example.com'],
  require              => [
      Ovm_file_server['default/nfs_server_1'],
      Ovm_server['default/server_pool_1/ovs01.example.com'],
  ]
}

ovm_virtual_disk { 'default/repo01/vm01_disk':
  ensure => 'present',
  size   => '2G',
}

ovm_vm { 'default/repo01/server_pool_1/ovs01.example.com/myvm1':
  ensure                  => 'present',
  boot_order              => ['DISK', 'CDROM'],
  cpu_count               => 2,
  cpu_count_limit         => 2,
  cpu_priority            => 50,
  cpu_utilization_cap     => 100,
  description             => 'Test 1',
  keymap_name             => 'en-us',
  memory                  => 192,
  memory_limit            => 192,
  os_type                 => 'Oracle Linux 7',
  restart_action_on_crash => 'RESTART',
  vm_domain_type          => 'XEN_HVM',
  vm_mouse_type           => 'OS_DEFAULT',
  vm_run_state            => 'RUNNING',
  vm_start_policy         => 'BEST_SERVER',
  virtual_disks           => ['1:repo01/vm01_disk']
}
