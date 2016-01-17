#
# Cookbook Name:: dockersetup
# Recipe:: default
#
# Copyright (c) 2016 Nick Ramirez, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
  notifies :run, "execute[docker_network]", :immediately
end

execute 'docker_network' do
  action :nothing
  command "sudo docker network create --driver bridge private_nw"
end