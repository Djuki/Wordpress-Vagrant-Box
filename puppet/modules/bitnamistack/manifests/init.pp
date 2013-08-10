class bitnamistack inherits bitnamistack::params {

    include mysql::params

    # template vars
    $stack_full_path = $bitnamistack::params::stack_full_path
    $dbuserpass = $mysql::params::dbuserpass

    file { 'answer_file':
        path => '/tmp/answer_file',
        ensure => present,
        content => template('bitnamistack/answer_file.erb'),
    }

    exec {
        "bitnami-lampstack":
        command => "wget -P /home/vagrant $bitnamistack::params::download_install_path",
        creates => "/home/vagrant/$bitnamistack::params::install_file",
        subscribe => File['answer_file']
    }

    exec {
        "make-executable":
        command => "chmod +x /home/vagrant/$bitnamistack::params::install_file",
        subscribe => Exec['bitnami-lampstack']
    }

    exec {
        "install":
        command => "/home/vagrant/$bitnamistack::params::install_file --optionfile /tmp/answer_file",
        subscribe => Exec['make-executable'],
        creates => "$bitnamistack::params::stack_full_path/ctlscript.sh",
        logoutput => "on_failure",
        timeout     => 6800,
    }

    exec { "stop-lamp":
        command => "/home/vagrant/lampstack/ctlscript.sh stop",
        subscribe => Exec['install']
    }

    file { "phpmyadmin-conf":
        path => "$bitnamistack::params::stack_full_path/apps/phpmyadmin/conf/phpmyadmin.conf",
        content => template('bitnamistack/phpmyadmin.conf.erb'),
        subscribe => Exec['stop-lamp']
    }

    file { "httpd-conf":
        path => "$bitnamistack::params::stack_full_path/apache2/conf/httpd.conf",
        content => template('bitnamistack/httpd.conf.erb'),
        subscribe => Exec['stop-lamp']
    }


    exec {
        "start-up":
        command => "/home/vagrant/lampstack/ctlscript.sh start",
        subscribe => File['phpmyadmin-conf'],
    }


}