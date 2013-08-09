class bitnamistack {

    $install_file = "bitnami-lampstack-1.2-5-linux-installer.run"

    $downloadi_nstall_path = "http://bitnami.org/files/download/$bitnamistack::install_file"

    $stack_full_path = "/home/vagrant/lampstack"



    file { 'answer_file':
        path => '/tmp/answer_file',
        ensure => present,
        source => '/vagrant/install/answer_file',
    }

    exec {
        "bitnami-lampstack":
        command => "wget -P /home/vagrant $bitnamistack::download_install_path",
        creates => "/home/vagrant/$bitnamistack::install_file",
        subscribe => File['answer_file']
    }

    exec {
        "make-executable":
        command => "chmod +x /home/vagrant/$bitnamistack::install_file",
        subscribe => Exec['bitnami-lampstack']
    }

    exec {
        "install":
        command => "/home/vagrant/$bitnamistack::install_file --optionfile /tmp/answer_file",
        subscribe => Exec['make-executable'],
        creates => "$bitnamistack::stack_full_path/ctlscript.sh"
    }

    exec { "stop-lamp":
        command => "/home/vagrant/lampstack/ctlscript.sh stop",
        subscribe => Exec['install']
    }

    file { "phpmyadmin-conf":
        path => "/home/vagrant/lampstack/apps/phpmyadmin/conf/phpmyadmin.conf",
        source => "/vagrant/modules/bitnamistack/templates/phpmyadmin.conf",
        subscribe => Exec['stop-lamp']
    }

    exec {
        "start-up":
        command => "/home/vagrant/lampstack/ctlscript.sh start",
        subscribe => File['phpmyadmin-conf']
    }
}