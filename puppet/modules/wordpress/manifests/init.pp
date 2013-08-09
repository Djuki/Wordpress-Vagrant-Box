class wordpress {

    require bitnamistack
    require mysql

    $install_dirname = "wordpress"

    $blog_name = "My first vagrant blog"

    $database = "$mysql::database"

    $dbuser = "$mysql::dbuser"

    $dbuserpass = "$mysql::dbuserpass"

    $host = "$mysql::host"

    $db_charset = "$mysql::db_charset"

    $db_collate = "$mysql::db_collate"

    $db_table_prefix = "$mysql::db_table_prefix"

    $admin_email = "djuki@mail.com"

    $admin_password = 'avantime'

    $blog_public = "true"



    $stack_full_path = "$bitnamistack::stack_full_path"

    file {"set-up-config.php":
        ensure => present,
        content => template('wordpress/set-up-config.php.erb'),
        path => "$bitnamistack::stack_full_path/apache2/htdocs/$wordpress::install_dirname/set-up-config.php"
    }

    exec { "execute-set-up-config":
        command => "$bitnamistack::stack_full_path/php/bin/php $bitnamistack::stack_full_path/apache2/htdocs/$wordpress::install_dirname/set-up-config.php",
        subscribe => File['set-up-config.php']
    }

    exec { "remove-set-up-config":
        command => "rm $bitnamistack::stack_full_path/apache2/htdocs/$wordpress::install_dirname/set-up-config.php",
        subscribe => Exec['execute-set-up-config']
    }


    file {"install-script.php":
        ensure => present,
        content => template('wordpress/install-script.php.erb'),
        path => "$bitnamistack::stack_full_path/apache2/htdocs/$wordpress::install_dirname/install-script.php"
    }

    exec { "execute-install-wordpress":
        command => "$bitnamistack::stack_full_path/php/bin/php $bitnamistack::stack_full_path/apache2/htdocs/$wordpress::install_dirname/install-script.php",
        subscribe => File['install-script.php']
    }

    exec { "remove-install-script":
        command => "rm $bitnamistack::stack_full_path/apache2/htdocs/$wordpress::install_dirname/install-script.php",
        subscribe => Exec['execute-install-wordpress']
    }



    exec {"download-latest":
        command => "wget -P /home/vagrant http://wordpress.org/latest.tar.gz",
        creates => "/home/vagrant/latest.tar.gz"
    }

    exec {"create-destination":
        command => "mkdir /home/vagrant/lampstack/apache2/htdocs/$wordpress::install_dirname",
        creates => "/home/vagrant/lampstack/apache2/htdocs/$wordpress::install_dirname",
        subscribe => Exec['download-latest']
    }

    exec {"unzip":
        command => "tar -xzvf /home/vagrant/latest.tar.gz -C /home/vagrant/lampstack/apache2/htdocs/$wordpress::install_dirname --strip=1",
        creates => "/home/vagrant/lampstack/apache2/htdocs/$wordpress::install_dirname/wp-includes",
        subscribe => Exec['create-destination']
    }




}