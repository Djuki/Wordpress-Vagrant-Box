class bitnamistack {
    file { 'answer_file':
        path => '/tmp/answer_file',
        ensure => present,
        source => '/vagrant/install/answer_file',
    }

    exec {
        "bitnami-lampstack":
        command => "wget -P /home/vagrant http://bitnami.org/files/download/bitnami-lampstack-1.2-5-linux-installer.run",
        creates => "/home/vagrant/bitnami-lampstack-1.2-5-linux-installer.run",
        subscribe => File['answer_file']
    }

    exec {
        "make-executable":
        command => "chmod +x /home/vagrant/bitnami-lampstack-1.2-5-linux-installer.run",
        subscribe => Exec['bitnami-lampstack']
    }

    exec {
        "install":
        command => "/home/vagrant/bitnami-lampstack-1.2-5-linux-installer.run --optionfile /tmp/answer_file",
        subscribe => Exec['make-executable'],
        creates => "/home/vagrant/lampstack/ctlscript.sh"
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