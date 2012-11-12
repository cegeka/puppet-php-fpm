class { 'php-fpm':
  user           => 'apache',
  group          => 'apache',
  listen_address => '/tmp/php-fpm.sock',
}
