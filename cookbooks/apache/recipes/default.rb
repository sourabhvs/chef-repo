#
# Cookbook Name:: Pradeep Manjunatha Prasad
# Recipe:: Apache
#
# Copyright 2015, Qwinix Technologies 
#
# All rights reserved - Do Not Redistribute
#

###########################{CentOS Platform}#########################
if node[:platform].include?("centos")
   
   # Package install httpd
   package "httpd" do
     action :install
     not_if "rpm -q httpd"
   end
   # Package install mod_ssl
   package "mod_ssl" do
     action :install
     not_if "rpm -q mod_ssl"
   end
   # chkconfig
   execute "chkconfig httpd on" do
     command "chkconfig httpd on"
   end

   #
   # command

   #
   service "httpd" do
     stop_command    "systemctl stop httpd.service"
     start_command   "systemctl start httpd.service"
     restart_command "systemctl restart httpd.service"
     action :enable
  end 
 
   #
   #Configration files
   #
   #httpd.conf
   template "/etc/httpd/conf/httpd.conf" do
     source "conf/httpd.conf.erb"
     owner "root"
     group "root"
     mode "0664"
     notifies :restart, "service[httpd]"
   end  
end
###########################{Ubuntu Platform}#########################
#if node[:platform].include?("ubuntu")

   #check for apt-update
#   execute "apt-get-update" do
#      command "apt-get update"
#      ignore_failure true
#      action :nothing
#   end
   # Package install httpd
#   package "apache2" do
#     action :install
#     not_if "dpkg -l apache2"
#   end
   # Package install mod_ssl
   #package "mod_ssl" do
    # action :install
    # not_if "rpm -q mod_ssl"
   #end
   # chkconfig
   #execute "chkconfig apache2 on" do
   #  command "chkconfig apache2 on"
   #end

   #
   # command
   #
#   service "apache2" do
#        action [:enable,:start]
#   end
   #
   #Configration files
   #
   #httpd.conf
#   template "/etc/apache2/apache2.conf" do
#     source "conf/apache2.conf.erb"
#     owner "root"
#     group "root"
#     mode "0664"
#     notifies :restart, "service[apache2]"
#   end

   #Start apache2
#   service "apache2" do
#      action [:enable,:start]
#   end
#end
