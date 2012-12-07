# Class: php-fpm
#
# This module manages php-fpm
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class php-fpm (
  $ensure             = present,
  $php_version        = '5.2',
  $pidfile            = '/var/run/php-fpm.pid',
  $error_log          = '/var/log/php-fpm.log',
  $log_level          = 'debug',
  $daemonize_proc     = 'yes',
  $user               = 'apache',
  $group              = 'apache',
  $listen_address     = '127.0.0.1:9000',
){

  $config_template = $php_version ? {
    '5.2'   => 'php-fpm.erb',
    '5.3'   => 'php53-fpm.erb',
    default => '',
  }

  $init_template = $php_version ? {
    '5.2'   => 'initd.erb',
    '5.3'   => 'initd53.erb',
    default => '',
  }

  $config_location = $php_version ? {
    '5.2'   => '/etc/php/php-fpm.conf',
    '5.3'   => '/etc/php-fpm.conf',
    default => '',
  }

  file { $config_location:
    ensure  => $ensure,
    content => template("php-fpm/${config_template}"),
    require => File['/etc/php'],
  }

  file { '/etc/php':
    ensure => directory,
  }

  file { '/etc/init.d/php-fpm':
    ensure  => $ensure,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template("php-fpm/${init_template}"),
    require => File[$config_location],
  }

  service { 'php-fpm':
    ensure  => running,
    require => File['/etc/init.d/php-fpm'],
  }
}
