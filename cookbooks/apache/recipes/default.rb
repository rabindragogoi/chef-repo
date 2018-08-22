#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

user 'web_admin' do
 comment 'A web_admin user to check the cookbook'
end


directory '/var/www/customers/public_html/' do
  recursive true
end

file '/var/www/customers/public_html/index.php' do
  content '<html>This is a placeholder for the home page.</html>'
  mode '0755'
  owner 'web_admin'
  group 'web_admin'
end

yum_package 'git'

package "httpd" do
	action :install
end

service "httpd" do
	action [ :enable, :start ]
end

cookbook_file "/var/www/html/index.html" do
	source "index.html"
	mode "0644"
end
