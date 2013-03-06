import 'lamp_packages.class.pp'
import 'lamp_config.class.pp'

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to EvenThor Vagrant-built virtual machine
                               Managed by Puppet.\n"
}

$localeit = '/var/lib/locales/supported.d/it'
file { $localeit:
   content => "it_IT.UTF-8 UTF-8\n"
}


$localeen = '/var/lib/locales/supported.d/en'
file { $localeen:
   content => "en_US.UTF-8 UTF-8\n"
}

class { 'locales' :
  default_value  => "it_IT.UTF-8",
  available      => ["it_IT.UTF-8 UTF-8", "en_US.UTF-8 UTF-8"],
  require        => File[$localeit, $localeen]
}

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/sbin", "/usr/local/bin", "/opt/vagrant_ruby/bin" ] }

Class['locales']->Class['lamp_packages']->Class['lamp_config']

include lamp_packages
include lamp_config
