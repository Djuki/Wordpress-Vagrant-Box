class wordpress::params {

  ### WebApp specific parameters
  $install = 'package'
  $install_source = 'http://wordpress.org/latest.zip'
  $install_dirname = 'wordpress'
  $install_precommand = ''
  $install_postcommand = ''
  $url_check = ''
  $url_pattern = 'wordpress'
  $web_server = 'apache'
  $web_server_template = ''
  $web_virtualhost = "$::fqdn"
  $db_type = 'mysql'
  $db_host = 'localhost'
  $db_name = 'wordpress'
  $db_user = 'wordpress'
  $db_password = fqdn_rand(100000000000)

}