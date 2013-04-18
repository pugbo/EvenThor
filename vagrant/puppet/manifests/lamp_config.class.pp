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

    exec { 'ports.conf':
        command => "sed '/^NameVirtualHost/d' -i /etc/apache2/ports.conf",
        unless => "test `grep ^NameVirtualHost /etc/apache2/ports.conf | wc -l` -eq 0",
        notify  => Service["apache2"]
    }

    exec {'timezone':
        command => "sed 's/;date.timezone.*/date.timezone = Europe\\/Rome/' -i /etc/php5/*/php.ini",
        unless => "test `grep timezone /etc/php5/*/php.ini | grep Rome | wc -l` -gt 0",
        notify  => Service["apache2"],
        require => Class["apache::mod::php"]
    }

    exec {'short_open_tag':
        command => "sed 's/short_open_tag = On/short_open_tag = Off/' -i /etc/php5/*/php.ini",
        unless => "test `grep short_open_tag /etc/php5/*/php.ini | grep On | wc -l` -eq 0",
        notify  => Service["apache2"],
        require => Class["apache::mod::php"]
    }

    exec {'xdebug-nesting':
        cwd => '/etc/php5/mods-available/',
        command => "echo 'xdebug.max_nesting_level = 250' | tee -a xdebug.ini",
        unless => "test `grep nesting xdebug.ini | wc -l` -gt 0",
        notify  => Service["apache2"],
        require => Class["apache::mod::php"]
    }
}
