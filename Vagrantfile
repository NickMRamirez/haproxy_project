# -*- mode: ruby -*-
# vi: set ft=ruby :

# Configure number of NGINX websites to create

# Change this to change how many NGINX 
# Web servers are created
servers_number = 2

# Install required Vagrant plugins...
required_plugins = %w{ vagrant-berkshelf }
required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure(2) do |config|

  config.vm.define 'server1' do |server|
    server.vm.box = 'ubuntu/vivid64'
    server.vm.hostname = 'server1'
    server.vm.network 'private_network', ip: '192.168.50.10'
    
    server.vm.provision 'chef_zero' do |chef|
      chef.roles_path = 'roles'
      chef.add_role 'dockerhost'
      chef.json = {
        'web' => {
          'count' => servers_number
        }
      }
    end
    
    server.vm.provision 'docker' do |docker|
      1.upto(servers_number) do |num|
        docker.run "web#{num}", 
          image: 'nginx',
          args: "-v /vagrant/nginx/nginx.conf:/etc/nginx/nginx.conf -v /tmp/index#{num}.html:/usr/share/nginx/html/index.html --net private_nw"
      end
    
      docker.run "lb1",
        image: 'haproxy',
        args: '-v /vagrant/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg -p 80:80 --net private_nw'
	end
  end

end
