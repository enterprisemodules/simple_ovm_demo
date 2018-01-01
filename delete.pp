# ovm_manager{ 'default':
#   ensure => 'absent'
# }
$resources = ['ovm_vm', 'ovm_virtual_disk', 'ovm_server_pool', 'ovm_network', 'ovm_file_server', 'ovm_repository', 'ovm_server']
resources { $resources:
  purge => true,
}


# ovm_vm { 'default/repo01/server_pool_1/ovmserver01.example.com/myvm1':
#   ensure => 'absent',
# }

# ovm_virtual_disk { 'default/repo01/vm01_disk':
#   ensure => 'absent',
# }

# ovm_server_pool { 'default/server_pool_1':
#   ensure => 'absent',
# }

# ovm_network { 'default/192.168.56.0':
#   ensure => 'absent',
# }

# ovm_file_server { 'default/nfs_server_1':
#   ensure => 'absent',
# }

# ovm_repository { 'default/repo01':
#   ensure => 'absent',
# }

# ovm_server { 'default/server_pool_1/ovmserver01.example.com':
#   ensure => 'absent',
# }

