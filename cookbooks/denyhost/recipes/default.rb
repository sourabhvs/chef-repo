#
# Cookbook Name:: denyhost
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
if node[:platform].include?("centos") && node[:platform_version].include?("6.7")
	Chef::Provider::Script 'extract_module' do
	 interpreter "Chef::Provider::Script::Bash"
	  code <<-EOH 
	  rpm -Uvh http://mirror.metrocast.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
	  yum -y install denyhosts
	  EOH
	end


	template "/etc/hosts.allow" do
          source "hostsallow.erb"
          variables(
              :firstip => "123.63.138.164",
              :secondip => "182.156.77.154",
             )
        end

	execute "denyhost_restart" do
	  command "/etc/init.d/denyhosts restart"
	end

	template "/etc/denyhosts.conf" do 
	  source "denyhost.erb"
	  variables(
	      :thresholdvalid => "5",
              :thresholdinvalid => "3",
              :email => "root@qwinixtech.com",
             )
	end

elsif node[:platform].include?("ubuntu")
	Chef::Provider::Script 'extract_module' do
	 interpreter "Chef::Provider::Script::Bash"
	  code <<-EOH
	  cd /tmp && wget http://downloads.sourceforge.net/project/denyhost/denyhost-2.8/denyhosts-2.8.tar.gz
	  tar xzf denyhosts*.tar.gz
	  cd DenyHosts* && sudo python setup.py install
	  cp /usr/local/bin/daemon-control-dist /etc/init.d/denyhosts
	  EOH
	end

	template "/etc/init.d/denyhosts" do
          source "ubuntudeny.erb"
          variables(
              :firstip => "123.63.138.164",
              :secondip => "182.156.77.154",
            )
        end

	execute "denyhost_restart" do
	 command "/etc/init.d/denyhosts restart"
	end

	template "/etc/denyhosts.conf" do
	  source "denyhost.erb"
 	   variables(
	      :thresholdvalid => "3",
              :thresholdinvalid => "5",
              :email => "root@qwinixtech.com",
            )
	end
end
