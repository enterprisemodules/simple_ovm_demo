#
# Setup packages
#
class profile::base::packages()
{
  $required_package = [
  ]
  $must_be_removed_packages = [
    'postfix',
  ]

  package{ $required_package:
    ensure => 'installed',
  }

  $must_be_removed_packages.each |$package| {
    unless defined(Package[$package]) {
      package{ $package:
        ensure => 'absent',
      }
    }
  }

}
