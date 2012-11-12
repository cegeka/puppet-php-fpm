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
  $ensure         = present,
  $pidfile        = '/var/run/php-fpm.pid',
  $error_log      = '/var/log/php-fpm.log',
  $log_level      = 'debug',
  $daemonize      = 'yes',
  $user           = 'apache',
  $group          = 'apache',
  $listen_address = '127.0.0.1:9000',
){

  file { '/etc/php/php-fpm.conf':
    ensure  => $ensure,
    content => template('php-fpm/php-fpm.erb',
  } 

  file { '/etc/init.d/php-fpm':
    ensure  => $ensure,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template('php-fpm/initd.erb',
  } 

}
