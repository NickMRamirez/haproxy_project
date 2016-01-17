# HAProxy Practice Project

Installs HAProxy and a couple of backend NGINX servers in Docker containers.

* After calling `vagrant up`, open a browser to 192.168.50.10
* To change HAProxy settings, update the *haproxy.cfg* file in the *haproxy* folder
* To add more NGINX Web servers, change the `servers_number` variable at the top of the *Vagrantfile*