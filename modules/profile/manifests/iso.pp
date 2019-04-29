# Make sure the OVM iso is available at /mnt/sio
class profile::iso(
  String $full_source = '/vagrant/modules/software/files/V952529-01.iso'
)
{
  file {'/mnt':
    ensure => 'directory'
  }
  file {'/mnt/iso':
    ensure => 'directory'
  }

  mount { '/mnt/iso':
    ensure  => 'mounted',
    device  => $full_source,
    fstype  => 'iso9660',
    options => 'loop',
  }
}
