class mysql {
    require bitnamistack

    include mysql::params

    exec
    {
        "create-wordpress-db":
            unless => "/home/vagrant/lampstack/mysql/bin/mysql -u$mysql::dbuser -p$mysql::dbuserpass $mysql::database",
            command => "/home/vagrant/lampstack/mysql/bin/mysql -u$mysql::dbuser -p$mysql::dbuserpass -e 'create database `$mysql::database`;'",
    }

    exec
    {
        "grant-default-db":
            command => "/home/vagrant/lampstack/mysql/bin/mysql -u$mysql::dbuser -p$mysql::dbuserpass -e 'grant all on `$mysql::database`.* to `$mysql::dbuser@localhost`;'",
            require => Exec["create-wordpress-db"]
    }
}