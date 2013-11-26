class mailcatcher::params {

  # Here it's not the php service script name but
  # web service name like apache2, nginx, etc.
  $service = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint|SLES|OpenSuSE)/ => 'apache2',
    default                                 => 'httpd',
  }

  case $::osfamily {
    'Debian': {
      $ip 	      = '0.0.0.0',
      $from       = '',
      $smtp_ip    = '',
      $smtp_port  = '',
      $http_ip    = '',
      $http_port  = '',
      $start      = true
      $package    = 'mailcatcher'
    }
    default: {
      fail("Unsupported platform: ${::osfamily}")
    }
  }
}