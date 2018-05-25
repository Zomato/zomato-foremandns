# == Class foremandns::config
#
# This class is called from foremandns
#
class foremandns::config {
  case $::foremandns::install_method {
    'archive': {
      $cfg = $::foremandns::cfg

      file { "${::foremandns::install_dir}/foremandns.yaml":
        ensure  => present,
        content => template('foremandns/config.yaml.erb'),
      }
    }
    default: {
      fail("Installation method ${::foremandns::install_method} not supported")
    }
  }
}