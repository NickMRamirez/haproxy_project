# -*- mode: ruby -*-
# vi: set ft=ruby :

# Configure number of NGINX websites to create
servers_number = 2

Vagrant.configure(2) do |config|

  config.vm.define 'server1' do |server|
    server.vm.box = 'box-cutter/ubuntu1504-docker'
    server.vm.hostname = 'server1'
    server.vm.network 'private_network', ip: '192.168.50.10'
    
    server.vm.provision 'docker' do |docker|
      1.upto(servers_number) do |num|
        nginx_volumes = %W{
          /vagrant/nginx/nginx.conf:/etc/nginx/nginx.conf
          /vagrant/nginx/web#{num}:/usr/share/nginx/html
          /vagrant/MyCert.pem:/usr/share/nginx/ssl/MyCert.pem
        }
      
        docker.run "web#{num}", 
          image: 'nginx',
          args: nginx_volumes.map {|vol| "-v #{vol} " }.join
      end
    end
    
    docker_network_setup = %Q{
      if [[ $(docker network ls | grep "isolated_nw") = "" ]]; then
        docker network create -d bridge isolated_nw
      fi
    }
    
    1.upto(servers_number) do |num|
      docker_network_setup << %Q{
        if [[ $(docker inspect web#{num} | grep "isolated_nw") = "" ]]; then
          docker network connect isolated_nw web#{num}
        fi
      }
    end
    
    server.vm.provision 'shell', inline: docker_network_setup
    
    server.vm.provision 'docker' do |docker|
      docker.run "lb1",
        image: 'haproxy',
        args: '-v /vagrant/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg -p 80:80 -p 443:443 --net isolated_nw'
    end
  end

end
