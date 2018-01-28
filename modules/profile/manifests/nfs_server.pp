# Make the node into an NFS server
class profile::nfs_server(
  Array[String]  $exports,
)
{
  file{ '/exports':
    ensure => 'directory',
    mode   => '0777',
  }

  file {$exports:
    ensure => 'directory',
    mode   => '0777',
  }

  file {'/exports/repos/repo01':
    ensure => 'directory',
    mode   => '0777',
  }

  service {'firewalld':
    ensure   => 'stopped',
    provider => 'systemd'
  }

  class { '::nfs':
    server_enabled       => true,
    storeconfigs_enabled => false,
  }

  nfs::server::export { $exports:
    ensure  => 'unmounted',
    clients => '*(rw,sync,no_subtree_check,no_root_squash)',
  }
}
