class {'apache': }
class {'apache::mod::php': }

class lamp_config
{
    file { '/etc/apache2/conf.d/user':
        content => "User vagrant\nGroup vagrant"
    }

    apache::vhost { 'default':
        priority        => '10',
        vhost_name      => '*',
        port            => '80',
        docroot         => '/vagrant/web',
        docroot_owner   => 'vagrant',
        docroot_group   => 'vagrant',
        logroot         => '/var/log',
        override        => 'All'
    }

    class { 'mysql::server':
        config_hash => { 'root_password' => 'birra0gradi' }
    }

    mysql::db { 'eventhor':
        user     => 'eventhor',
        password => 'eventhor',
        host     => 'localhost',
        grant    => ['all'],
        charset  => 'utf8'
    }
}
