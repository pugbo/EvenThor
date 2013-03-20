class lamp_packages
{
    $phppkg = ['php-apc', 'php-pear', 'php5-curl', 'php5-gd', 'php5-intl', 'php5-xdebug']
    package { $phppkg :
        ensure => 'latest'
    }
    
    $apachepkg = ['apache2-mpm-prefork', 'libapache2-mod-php5']
    package { $apachepkg :
        ensure => 'latest'
    }

    package { 'curl' :
        ensure => 'latest'
    }

    exec { 'install-composer':
        command => 'curl -s https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer',
	creates => '/usr/local/bin/composer',
	require => Package['curl', $phppkg]
    }
}
