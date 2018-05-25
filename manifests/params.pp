# == Class foremandns::params
#
# This class is meant to be called from foremandns
# It sets variables according to platform
#
class foremandns::params {
  $archive_source      = undef
  $cfg_location        = '/usr/share/foremandns/foremandns.yaml'
  $cfg                 = {}
  $install_dir         = '/usr/share/foremandns/'
  $install_method      = 'archive'
  $service_name        = 'foremandns'
  $version             = 'v1.0.0'
}
