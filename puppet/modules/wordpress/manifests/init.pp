class wordpress {

    include wordpress::params
    include wordpress::wpconfig
    include wordpress::wp-install

    exec {"download-latest":
        command => "wget -P /home/vagrant http://wordpress.org/latest.tar.gz",
        creates => "/home/vagrant/latest.tar.gz"
    }

    exec {"create-destination":
        command => "mkdir /home/vagrant/$wordpress::params::install_dirname",
        creates => "/home/vagrant/$wordpress::params::install_dirname",
        subscribe => Exec['download-latest']
    }

    exec {"unzip":
        command => "/bin/tar -xzvf /home/vagrant/latest.tar.gz -C /home/vagrant/$wordpress::params::install_dirname --strip=1",
        creates => "/home/vagrant/$wordpress::params::install_dirname/wp-includes",
        subscribe => Exec['create-destination'],
        timeout     => 10800000,
        returns => [0,2],
    }

}