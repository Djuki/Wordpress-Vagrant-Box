class wordpress {

    require bitnamistack

    $install_dirname = 'wordpress'

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