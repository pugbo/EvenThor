class lamp_packages
{
    $phppkg = ['php-apc', 'php-pear', 'php5-curl', 'php5-gd', 'php5-intl', 'php5-xdebug']
    package { $phppkg :
        ensure => 'latest'
    }
    
    package { 'phpmyadmin':
        ensure => 'latest'
    }

    package { 'curl':
        ensure => 'latest'
    }

    package { 'sass':
        ensure => 'latest',
        provider => 'gem'
    }

    package{'java7-runtime-headless':
        ensure => 'latest'
    }

    exec { 'install-composer':
        command => 'curl -s https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer',
	    creates => '/usr/local/bin/composer',
	    require => Package['curl', $phppkg]
    }
}
