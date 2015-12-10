#
# Cookbook Name:: sshd
# Recipe:: devops_users
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#Create user devops & deploy
   #include_recipe "sshd::sshd"
     user 'devops' do
     # owner 'devops'
     # group 'devops'	
     not_if 'getent passwd devops'
  end 

     user 'deploy' do
     #command 'adduser deploy'
     password 'deploy123!'
     not_if 'getent passwd deploy'
  end

     execute "switch_user" do 
     command 'su - deploy'
  end

#Create .ssh directory under deploy user 
     directory "#{node['sshd']['authorized_path']}" do 
     owner 'deploy'
     group 'deploy'
     mode '0755'
     action :create
  end 

     file "#{node['sshd']['authorized_path']}/authorized_keys" do
     action :create
  end

#Add devops user to sudoers file 

     template '/etc/sudoers' do 
     source 'sudoers_centos.erb'
     mode '0440'
     owner 'root'
     group 'root'
     variables(
       :user => "devops"
     )
  end





