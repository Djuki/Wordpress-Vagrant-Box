class wordpress::wpconfig inherits wordpress::params{

    require bitnamistack
    require mysql

    include wordpress::params

    file {"set-up-config.php":
        ensure => present,
        content => template('wordpress/set-up-config.php.erb'),
        path => "/home/vagrant/$wordpress::params::install_dirname/set-up-config.php",
        subscribe => Exec ['install']
    }

    exec { "execute-set-up-config":
        command => "$bitnamistack::params::stack_full_path/php/bin/php /home/vagrant/$wordpress::params::install_dirname/set-up-config.php",
        subscribe => File['set-up-config.php']
    }

    #exec { "remove-set-up-config":
    #    command => "rm /home/vagrant/$wordpress::params::install_dirname/set-up-config.php",
    #    subscribe => Exec['execute-set-up-config'],
    #    logoutput => "on_failure",
    #}

}