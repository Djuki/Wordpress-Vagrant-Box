class wordpress::wp-install inherits wordpress::params {

    require bitnamistack
    require mysql


    file {"install-script.php":
        ensure => present,
        content => template('wordpress/install-script.php.erb'),
        path => "/home/vagrant/$wordpress::params::install_dirname/install-script.php",
        subscribe => Exec ['execute-set-up-config']
    }

    exec { "execute-install-wordpress":
        command => "$bitnamistack::params::stack_full_path/php/bin/php /home/vagrant/$wordpress::params::install_dirname/install-script.php",
        subscribe => File['install-script.php']
    }

    #exec { "remove-install-script":
    #    command => "rm /home/vagrant/$wordpress::params::install_dirname/install-script.php",
    #    subscribe => Exec['execute-install-wordpress'],
    #    logoutput => "on_failure",
    #}
}