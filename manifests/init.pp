class mailcatcher(
  $service    = $mailcatcher::params::service,
  $ip         = $mailcatcher::params::ip,
  $smtp_ip    = $mailcatcher::params::smtp_ip,
  $smtp_port  = $mailcatcher::params::smtp_port,
  $http_ip    = $mailcatcher::params::http_ip,
  $http_port  = $mailcatcher::params::http_port,
  $start      = $mailcatcher::params::start,
  $quit       = $mailcatcher::params::quit,
  $package    = $mailcatcher::params::package,
) inherits mailcatcher::params {

  if defined(Package[$package]) == false {
    package { $package:
      ensure    => present,
      provider  => gem,
      notify    => Service[$service],
    }
  }

  if $ip {
    $params_ip = "--ip=${fip}"
  } else {
    if $smtp_ip {
      $params_smtp_ip = "--smtp-ip=${smtp_ip}"
    } else {
      $params_smtp_ip = ""
    }

    if $http_ip {
      $params_http_ip = "--http-ip=${http_ip}"
    } else {
      $params_http_ip = ""
    }

    $params_ip = "${params_smtp_ip} ${params_http_ip}"
  }

  if $smtp_port {
    $params_smtp_port = "--smtp-port=${smtp_port}"
  } else {
    $params_smtp_port = ""
  }

  if $http_port {
    $params_http_port = "--http-port=${http_port}"
  } else {
    $params_http_port = ""
  }

  if $quit {
    $params_quit = "--no-quit"
  } else {
    $params_quit = ""
  }

  if $start {
    exec { "mailcatcher-start":
      command => "mailcatcher ${params_ip} ${params_smtp_port} ${params_http_port} ${params_quit}",
      require  => Package[$package],
    }
  }

}