#
# Cookbook Name:: sshd
# Recipe:: devops_keys
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#include the recipe to add the devops and deploy user and include the sshd recipe

   include_recipe 'sshd::devops_users'
   include_recipe 'sshd::sshd'

#Update the authorized_keys 

     template "#{node['sshd']['authorized_path']}/authorized_keys" do
     source 'authorized.erb'
  end
   
     template "#{node['sshd']['authorized_path_devops']}/authorized_keys" do
     source 'devops_authorized.erb'
  end

