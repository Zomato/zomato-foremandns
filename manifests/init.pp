# == Class: foremandns
#
# Installs and configures ForemanDNS server.
#
# === Parameters
# [*archive_source*]
# Download location of tarball to be used with the 'archive' install method.
# Defaults to the URL of the latest version of ForemanDNS available at the time of module release.
#
# [*install_dir*]
# Installation directory to be used with the 'archive' install method.
# Defaults to '/usr/share/foremandns'.
#
# [*install_method*]
# Set to 'archive' to install ForemanDNS using the tar archive.
# Defaults to 'archive'.
#
# [*service_name*]
# The name of the service managed with the 'archive' and 'package' install methods.
# Defaults to 'foremandns'.
#
# [*version*]
# The version of ForemanDNS to install and manage.
# Defaults to the latest version of ForemanDNS available at the time of module release.
#
# === Examples
#
#  class { '::foremandns':
#    version  => 'v1.0.0',
#  }
#
class foremandns (
  $archive_source      = $::grafana::params::archive_source,
  $cfg_location        = $::grafana::params::cfg_location,
  $cfg                 = $::grafana::params::cfg,
  $install_dir         = $::grafana::params::install_dir,
  $install_method      = $::grafana::params::install_method,
  $service_name        = $::grafana::params::service_name,
  $version             = $::grafana::params::version
) inherits foremandns::params {

  # validate parameters here
  if !is_hash($cfg) {
    fail('cfg parameter must be a hash')
  }

  class { 'foremandns::install': } ->
  class { 'foremandns::config': } ~>
  class { 'foremandns::service': }

  contain 'foremandns::install'
  contain 'foremandns::service'

  #Class['foremandns']
}