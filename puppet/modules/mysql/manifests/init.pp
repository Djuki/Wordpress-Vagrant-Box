class mysql {
    require bitnamistack

    $database = "wpgame"
    $dbuser = "root"
    $dbuserpass = ""
    $host = "localhost"
    $db_charset = "utf8"
    $db_collate = ""
    $db_table_prefix = "wp_cool_"

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