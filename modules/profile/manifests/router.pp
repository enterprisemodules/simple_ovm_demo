# Make sure this node can work like a router
class profile::router(
  String $inside_device,
  String $outside_device,
)
{
  sysctl { 'net.ipv4.ip_forward':
    ensure  => present,
    value   => '1',
    comment => 'Makle sure we can route IP4 packages',
  }

  # firewalld_direct_rule {'Routing postrouting':
  #   ensure        => 'present',
  #   inet_protocol => 'ipv4',
  #   table         => 'nat',
  #   chain         => 'POSTROUTING',
  #   priority      => 0,
  #   args          => "-o ${outside_device} -j MASQUERADE",
  # }

  # firewalld_direct_rule {'Routing from inside to outside':
  #   ensure        => 'present',
  #   inet_protocol => 'ipv4',
  #   table         => 'filter',
  #   chain         => 'FORWARD',
  #   priority      => 0,
  #   args          => "-i ${inside_device} -o ${outside_device} -j ACCEPT",
  # }

  # firewalld_direct_rule {'Routing from outside to intside':
  #   ensure        => 'present',
  #   inet_protocol => 'ipv4',
  #   table         => 'filter',
  #   chain         => 'FORWARD',
  #   priority      => 0,
  #   args          => "-i ${outside_device} -o ${inside_device} -m state --state RELATED,ESTABLISHED -j ACCEPT",
  # }


}
