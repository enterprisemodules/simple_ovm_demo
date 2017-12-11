#
# Install the Oracle VM Manager
#
class ovm_config::installovmm(
  Stdlib::Absolutepath            $source,
  Sensitive                       $password,
  String                          $fqdn,
  Variant[ Boolean, Enum['on_failure']] $logoutput = 'on_failure',
){
  $decrypted_password = $password.unwrap |$sensitive| { $sensitive }

  $required_packages = [
    'zip',
    'unzip',
    'perl-Data-Dumper',
    'expect',
  ]
  package {$required_packages: ensure => 'latest'}

  group {'oinstall':
    ensure => 'present',
    gid    => 54321,
  }

  group {'dba':
    ensure => 'present',
  }

  user {'oracle':
    ensure => 'present',
    uid    => 54321,
    groups => ['dba', 'oinstall']
  }


  file { '/tmp/install.exp':
    ensure => 'present',
    mode   => 'u+x',
    source => 'puppet:///modules/ovm_config/install.exp',
  } ->

  exec {'Installed OVMM':
    command   => "/tmp/install.exp ${source} ${decrypted_password} ${fqdn}",
    timeout   => 0,
    unless    => '/bin/test -d /u01/app/oracle/ovm-manager-3',
    logoutput => $logoutput,
  } ->

  tidy { '/tmp/install.exp':}
}
