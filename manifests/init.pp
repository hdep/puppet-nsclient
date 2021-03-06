# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Class: nsclient
#
# Module to install NSClient on Windows.
#
# === Requirements/Dependencies
#
# Currently reequires the puppetlabs/stdlib module on the Puppet Forge in
# order to validate much of the the provided configuration.
#
# === Parameters
#
# [*allowed_hosts*]
# Array of hosts that your client can communicate with. You can use netmasks (/ syntax) or * to create ranges.
#
# [*service_state*]
# Whether you want to nsclient service to start up. Defaults to running
#
# [*service_enable*]
# Whether you want to nsclient service to start up at boot. Defaults to true
#
# [*package_source_location*]
# This is the default site to download your package from (e.g. http://files.nsclient.org/stable)
#
# [*package_source*]
# This is the source name of the package to be downloaded
#
# [*package_name*]
# This is name of the package to download (e.g. NSCP-0.4.1.101-x64.msi)
#
# [*download_destination*]
# This is the folder to where we need to download the NSCP Installer. Package cannot take a remote file source
# Because of Windows, we need to set this to be a top level directory (e.g. c:\\temp) or we would need to
# recursively check the file path.
#
# [*config_template*]
# This is the template to use as the config file.
#
# [*password*]
# Password used to authenticate against server
# default to undef
#
# [*proxy_url*]
# Specify a proxy url if needed for downloading the package
# default to undef
#
# [*chocolatey_provider*]
# Boolean, if true get nsclient from chocolatey. Default to false
#
# [*chocolatey_package_name*]
# This is the package name from chocolatey repo.
#
# [*chocolatey_package_version*]
# This is the package version from chocolatey repo.
#
# === Examples
#
# To install a different version:
#
#   class { 'nsclient':
#     package_source_location => 'http://myhost.com',
#     package_name            => 'NSClient++ (Win32)'
#     package_source          => '0.3.1.msi'
#   }
#
# In order to configure the nagios hosts to communicate with:
#
#   class { 'nsclient':
#     allowed_hosts => ['10.21.0.0/22','10.21.4.0/22'],
#   }
#
class nsclient (
  $allowed_hosts                                  = $nsclient::params::allowed_hosts,
  $service_state                                  = $nsclient::params::service_state,
  $service_enable                                 = $nsclient::params::service_enable,
  $package_source_location                        = $nsclient::params::package_source_location,
  $package_source                                 = $nsclient::params::package_source,
  $package_name                                   = $nsclient::params::package_name,
  $download_destination                           = $nsclient::params::download_destination,
  $config_template                                = $nsclient::params::config_template,
  $install_path                                   = $nsclient::params::install_path,
  Optional[String[1]] $password                   = $nsclient::params::password,
  Optional[String[1]] $proxy_url                  = $nsclient::params::proxy_url,
  Boolean $chocolatey_provider                    = $nsclient::params::chocolatey_provider,
  Optional[String[1]] $chocolatey_package_name    = $nsclient::params::chocolatey_package_name,
  Optional[String[1]] $chocolatey_package_version = $nsclient::params::chocolatey_package_version
) inherits nsclient::params {

  validate_string($package_source_location)
  validate_string($package_source)
  validate_string($package_name)
  validate_string($config_template)
  validate_string($install_path)

  class {'::nsclient::install':}
  -> class {'::nsclient::service':}

}
