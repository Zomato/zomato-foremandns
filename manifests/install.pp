# == Class foremandns::install
#
class foremandns::install {
  if $::foremandns::archive_source != undef {
    $real_archive_source = $::foremandns::archive_source
  }
  else {
    $real_archive_source = "https://s3.ap-south-1.amazonaws.com/zomato-foremandns/foremandns-linux-amd64-${::foremandns::version}.tgz"
  }
  case $::foremandns::install_method {
    'archive': {
      # create log directory /var/log/foremandns (or parameterize)

      file { $::foremandns::install_dir:
        ensure  => directory,
        group   => 'root',
        owner   => 'root',
        require => User['root']
      }

      archive { '/tmp/foremandns.tar.gz':
        ensure          => present,
        extract         => true,
        extract_command => 'tar xfz %s --strip-components=1',
        extract_path    => $::foremandns::install_dir,
        source          => $real_archive_source,
        user            => 'root',
        group           => 'root',
        cleanup         => true,
        require         => File[$::foremandns::install_dir]
      }

    }
    default: {
      fail("Installation method ${::foremandns::install_method} not supported")
    }
  }
}