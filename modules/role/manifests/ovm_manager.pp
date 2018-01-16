# Docs
class role::ovm_manager()
{
  contain ::profile::base
  contain ::profile::iso
  include ::firewalld
  contain ::ovm_config::installovmm
  contain ::profile::example_setup

  require ::profile::router

  Class['::profile::base']
  -> Class['::profile::iso']
  -> Class['::ovm_config::installovmm']
  -> Class['::profile::example_setup']

}
