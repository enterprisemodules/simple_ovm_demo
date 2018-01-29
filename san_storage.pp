ovm_storage_array { 'default/openfiler.example.org':
  ensure         => 'present',
  storage_type   => 'ISCSI',
  admin_servers  => ['ovs01.example.com'],
  access_hosts   => [
  {
    'hostname' => '192.168.56.10',
    'port'     => 3260,
  }],
  description    => 'My OpenFiler',
}
