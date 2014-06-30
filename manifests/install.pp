# == Class: nginx_passenger
#
# nginx_passenger is a puppet module which provides support for nginx and
# passenger. If a custom package URL is provided, it will be used in preference
# of any other installation method. If a custom package URL is not given, and a
# phusion supplied package is available, then that will be used. Otherwise,
# nginx and passenger will be built from source.
#
# === Parameters
#
# These parameters, other than custom_package_location, are only used when
# compiling from source.
#
# [*build_dir*]
#   Specify the directory to use for source compilation. (/usr/local/src)
#
# [*nginx_version*]
#   Specify the nginx version to be installed. (1.6.0)
#
# [*nginx_prefix*]
#   Specify the installation prefix for nginx. (/usr/local/nginx)
#
# [*extra_config_flags*]
#   Specify any additional flags to be sent to nginx's configure script.
#   (--user=www --group=www)
#
# [*passenger_version*]
#   Specify the passenger version to be installed. (4.0.45)
#
# [*passenger_languages*]
#   Specify the languages passenger should support. (nodejs)
#   To specify more than one, separate them with commas, e.g. 'ruby,nodejs'.
#
# [*custom_package_location*]
#   Specify the location of a custom package for nginx and passenger
#   installation. (undef)
#
# === Examples
#
# class { nginx_passenger:
#   build_dir             => '/usr/local/src',
#   nginx_version         => '1.6.0',
#   nginx_prefix          => '/usr/local/nginx',
#   extra_configure_flags => '--user=www --group=www',
#   passenger_version     => '4.0.45',
#   passenger_languages   => 'nodejs',
# }
#
# class { nginx_passenger:
#   custom_package_location => 'http://pkgs.mydomain.com/nginx.tbz',
# }
#
# nginx_passenger::install { '1.6.0-4.0.45':
#   nginx_version     => '1.6.0',
#   passenger_version => '4.0.45',
# }
#
# === Authors
#
# TechOps <techops@webassign.net>
#
# === Copyright
#
# Copyright 2014 Advanced Instructional Systems, Inc., unless otherwise noted.
#
define nginx_passenger::install {
  file { '/usr/local/src':
    ensure => 'directory',
    owner  => 'root',
    group  => 'wheel',
    mode   => '0755',
  }

  exec { 'nginx-download':
    command => 'fetch http://nginx.org/download/nginx-1.6.0.tar.gz',
    cwd     => '/usr/local/src',
  }
}
