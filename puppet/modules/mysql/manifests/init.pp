class mysql {
    require bitnamistack

    $database = 'wpgame'
    $dbuser = 'root'
    $dbuserpass = 'avanti'

    exec
    {
        "create-wordpress-db":
            unless => "/home/vagrant/lampstack/mysql/bin/mysql -u$mysql::dbuser $mysql::database",
            command => "/home/vagrant/lampstack/mysql/bin/mysql -u$mysql::dbuser -e 'create database `$mysql::database`;'",
    }

    exec
    {
        "grant-default-db":
            command => "/home/vagrant/lampstack/mysql/bin/mysql -u$mysql::dbuser -e 'grant all on `$mysql::database`.* to `$mysql::dbuser@localhost`;'",
            require => Exec["create-wordpress-db"]
    }
}