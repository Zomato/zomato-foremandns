# foremandns

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with foremandns](#setup)
    * [What foremandns affects](#what-foremandns-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with foremandns](#beginning-with-foremandns)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Start with a one- or two-sentence summary of what the module does and/or what
problem it solves. This is your 30-second elevator pitch for your module.
Consider including OS/Puppet version it works with.

You can give more descriptive information in a second paragraph. This paragraph
should answer the questions: "What does this module *do*?" and "Why would I use
it?" If your module has a range of functionality (installation, configuration,
management, etc.), this is the time to mention it.

## Setup

### What foremandns affects **OPTIONAL**

If it's obvious what your module touches, you can skip this section. For
example, folks can probably figure out that your mysql_instance module affects
their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you might want to include an additional "Upgrading" section
here.

### Beginning with foremandns

To install foremandns with the default parameters:

```puppet
    class { 'foremandns': }
```

This assumes that you want to install Grafana using the 'package' method. To establish customized parameters:

```puppet
    class { 'foremandns':
      install_method  => 'archive',
    }
```

## Usage

### Classes and Defined Types

#### Class: `foremandns`

The ForemanDNS module's primary class, `foremandns`, guides the basic setup of ForemanDNS on your system.

```puppet
    class { 'foremandns': }
```
** Parameters within `foremandns`:**

##### `archive_source`

The download location of a tarball to use with the 'archive' install method. Defaults to the URL of the latest version of ForemanDNS available at the time of module release.

##### `cfg_location`

Configures the location to which the ForemanDNS configuration is written. The default location is '/usr/foremandns/foremandns/foremandns.yaml'.

##### `cfg`

Manages the ForemanDNS configuration file.

This parameter only accepts a hash as its value. Keys with hashes as values will generate sections, any other values are just plain values. The example below will result in...

```puppet
    class { 'foremandns':
      cfg => {
        url => 'https://foreman.exmaple.com',
        username => 'username',
        pasword => 'password',
        zone => '.foremansystem.com.',
        cache-type => 'memory',
        ttl => 1800
        redis   => {
          server     => 'localhost:6379',
        },
      },
    }
```
##### `install_dir`

The installation directory to be used with the 'archive' install method. Defaults to '/usr/share/foremandns'.

##### `install_method`

Controls which method to use for installing ForemanDNS. Valid option is 'archive'. The default is 'archive'. 

##### `service_name`

The name of the service managed with the 'archive' install method. Defaults to 'foremandns'.

##### `version`

The version of Grafana to install and manage. Defaults to the latest version of ForemanDNS available at the time of module release.

## Reference

Users need a complete list of your module's classes, types, defined types providers, facts, and functions, along with the parameters for each. You can provide this list either via Puppet Strings code comments or as a complete list in this Reference section.

* If you are using Puppet Strings code comments, this Reference section should include Strings information so that your users know how to access your documentation.

* If you are not using Puppet Strings, include a list of all of your classes, defined types, and so on, along with their parameters. Each element in this listing should include:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
