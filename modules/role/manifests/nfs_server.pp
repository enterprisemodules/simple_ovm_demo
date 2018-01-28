# Docs
class role::nfs_server()
{
  contain ::profile::base
  contain ::profile::nfs_server

  Class['::profile::base']
  -> Class['::profile::nfs_server']

}
