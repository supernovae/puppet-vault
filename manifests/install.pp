# == Class vault::install
#
class vault::install {
  $vault_bin = "${::vault::bin_dir}/vault"

  package { 'vault':
    ensure  =>  'latest',
  } ~>
  file { $vault_bin:
    owner => 'root',
    group => 'root',
    mode  => '0555',
  }

  if !$::vault::config_hash['disable_mlock'] {
    exec { "setcap cap_ipc_lock=+ep ${vault_bin}":
      path        => ['/sbin', '/usr/sbin'],
      subscribe   => File[$vault_bin],
      refreshonly => true,
    }
  }

  user { $::vault::user:
    ensure => present,
  }
  group { $::vault::group:
    ensure => present,
  }

}
