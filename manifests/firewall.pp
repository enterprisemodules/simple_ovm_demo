class ovm,_config::firewall
{
  firewall { '400 accept OVMM port 7001':
    proto  => 'tcp',
    dport  => 7002,
    state  => ['NEW'],
    action => 'accept',
  }

  firewall { '410 accept OVMM port 123':
    proto  => 'udp',
    dport  => 123,
    state  => ['NEW'],
    action => 'accept',
  }

  firewall { '420 accept OVMM port 10000':
    proto  => 'udp',
    dport  => 10000,
    state  => ['NEW'],
    action => 'accept',
  }

}
