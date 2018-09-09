#
# Cookbook:: mysql_database
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

mmysql2_chef_gem 'default' do
  action :install
end

connection_params = {
  :username => 'root',
  :password => 'root_password_15',
  :host => '127.0.0.1'
}

mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password connection_params[:password]
  action [:create, :start]
end

mysql_database 'my_db' do
  connection connection_params
  action :create
end

mysql_database_user 'me' do
  connection connection_params
  password 'my_password_11'
  privileges [:all]
  action [:create, :grant]
end
