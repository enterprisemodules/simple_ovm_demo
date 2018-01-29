# TODO: Add documentation
class profile::base::hosts(
  Hash $list,
)
{
  create_resources('host', $list, {})
}
