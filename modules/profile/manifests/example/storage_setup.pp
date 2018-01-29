# Base storage setup
class profile::example::storage_setup()
{
  ovm_file_server { 'default/nfs_server_1':
    ensure          => 'present',
    access_host     => '192.168.56.4',
    admin_servers   => ['ovs01.example.com'],
    uniform_exports => 'true',
    require         => Ovm_server['default/server_pool_1/ovs01.example.com'],
  }


  ->ovm_repository { 'default/repo01':
    ensure               => 'present',
    share_path           => '/repo01/',
    file_system_name     => 'nfs on 192.168.56.4:/exports/repos',
    presented_to_servers => ['ovs01.example.com'],
    require              => [
        Ovm_file_server['default/nfs_server_1'],
        Ovm_server['default/server_pool_1/ovs01.example.com'],
    ]
  }

  # For the next version
  # ->ovm_virtual_disk { 'default/repo01/CentOS-7-x86_64-Minimal-1708.iso':
  #   ensure      => 'present',
  #   description => 'minimal image of CentOS 7',
  #   disk_type   => 'VIRTUAL_CDROM',
  #   shareable   => true,
  #   urls        => ['http://ftp.pbone.net/pub/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso'],
  #   async       => false,
  # }

}
