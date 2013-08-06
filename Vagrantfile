# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant::Config.run do |config|

    config.vm.box = "precise32"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    config.vm.network :hostonly, "33.33.33.111" # Host-Only networking required for nfs shares

    config.vm.share_folder("default", "/vagrant", "./puppet", :nfs => (RUBY_PLATFORM =~ /linux/ or RUBY_PLATFORM =~ /darwin/))
    config.vm.share_folder("web", "/home/vagrant/lampstack/apache2/htdocs/", "./www", :nfs => (RUBY_PLATFORM =~ /linux/ or RUBY_PLATFORM =~ /darwin/))

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        #puppet.options = "--verbose --debug"
        puppet.options = "--verbose"
    end

end