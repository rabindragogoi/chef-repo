#
# Cookbook:: tomcat8
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#include_recipe java8

tmp_path = Chef::Config[:file_cache_path]

#Download tomcat archive

remote_file "#{tmp_path}/tomcat8.tar.gz" do
  source node['tomcat8']['download_url']
  owner node['tomcat8']['tomcat_user']
  mode '0644'
  action :create
end

#create tomcat install dir

directory node['tomcat8']['install_location'] do
  owner node['tomcat8']['tomcat_user']
  mode '0755'
  action :create
end


#Extract the tomcat archive to the install location

bash 'Extract tomcat archive' do
  user node['tomcat8']['tomcat_user']
  cwd node['tomcat8']['install_location']
  code <<-EOH
    tar -zxvf #{tmp_path}/tomcat8.tar.gz --strip 1
  EOH
  action :run
end


#Replace the server.xml file as per environment requirement

template "#{node['tomcat8']['install_location']}/conf/server.xml" do
  source 'server.xml.erb'
  owner node['tomcat8']['tomcat_user']
  mode '0644'
end


#Install init script and start the tomcat server.

template "/etc/init.d/tomcat8" do
  source 'tomcat8.erb'
  owner 'root'
  mode '0755'
end


