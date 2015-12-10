#
# Cookbook Name:: selinux
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#file "node['selinux']['value']" do 
#action :permissive
#end

#include_recipe 'selinux::_condition'
if node[:platform].include?("centos")
	execute "enable selinux as permissive or enforced" do 
	not_if "selinuxenabled && echo enabled || echo disabled"
	command "setenforce 0"
	action :run 
	end
	template "/etc/selinux/config" do
	source "selinux.erb" 
	variables(
	    :selinuxvalue => "disabled",
	    :selinuxtype => "targeted",
	  )
	end

	elsif node[:platform].include?("ubuntu")
		execute "enable selinux as permissive or enforced" do
		not_if "selinuxenabled && echo enabled || echo disabled"
		command "setenforce 0"
		action :run
		end
		template "/etc/selinux/config" do
		source "ubuntu_selinux.erb"
		variables(
	    	:selinuxvalue => "disabled",
	    	:selinuxtype => "ubuntu",
	    	:setlocaldefs => "0"
	  	)
		end

end

#execute "enable selinux as permissive" do
 # not_if "getenforce | egrep -qx 'Permissive|Disabled'"
  #command "setenforce 0"
  #ignore_failure true
  #action :run
#end

#template "/etc/selinux/config" do
 # source "sysconfig/selinux.erb"
  #not_if "getenforce | grep -qx 'Disabled'"
  #variables(
   # :selinux => "permissive",
   # :selinuxtype => "targeted",
 # )
#end
