# Default path
Exec
{
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}


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

exec {
    "start-up":
    command => "/home/vagrant/lampstack/ctlscript.sh start",
    subscribe => Exec['install']
}