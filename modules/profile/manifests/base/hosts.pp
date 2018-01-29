#
# Setup servers hosts from vagrant.yaml
#
class profile::base::hosts(
  Hash $list,
)
{
  create_resources('host', $list, {})
}
