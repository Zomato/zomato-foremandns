# == Class foremandns::service
#
# This class is meant to be called from foremandns
# It ensure the service is running
#
class foremandns::service {
  case $::foremandns::install_method {
    'archive': {
      $service_path   = "${::foremandns::install_dir}/${::foremandns::service_name}"
      $service_config = "${::foremandns::install_dir}/foremandns.yaml"

      if !defined(Service[$::foremandns::service_name]){
        service { $::foremandns::service_name:
          ensure     => running,
          provider   => base,
          binary     => "su - root -c '${service_path} server --config=${service_config} &'",
          hasrestart => false,
          hasstatus  => false,
          status     => "ps -ef | grep ${::foremandns::service_name} | grep -v grep"
        }
      }
    }
    default: {
      fail("Installation method ${::foremandns::install_method} not supported")
    }
  }
}