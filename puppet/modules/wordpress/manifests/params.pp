class wordpress::params {

    require bitnamistack
    include mysql::params

    ### Wordpress specific parameters
    $install_dirname = "www/wordpress"
    $blog_name = "My first vagrant blog"
    $database = "$mysql::params::database"
    $dbuser = "$mysql::params::dbuser"
    $dbuserpass = "$mysql::params::dbuserpass"
    $host = "$mysql::params::host"
    $db_charset = "$mysql::params::db_charset"
    $db_collate = "$mysql::params::db_collate"
    $db_table_prefix = "$mysql::params::db_table_prefix"
    $admin_email = "djuki@mail.com"
    $admin_password = 'avantime'
    $blog_public = "true"
    $stack_full_path = "$bitnamistack::params::stack_full_path"
}