# == Class vault::service
class vault::service (
  $service_prodvider = $::vault::params::$service_prodiver  
){
  service { $::vault::service_name:
    ensure   => running,
    enable   => true,
    provider => $::vault::params::,
  }
}
