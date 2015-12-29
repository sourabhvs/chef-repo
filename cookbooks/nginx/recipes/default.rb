#
# Cookbook Name:: Pradeep Manjunath Prasad
# Recipe:: nginx
#
# Copyright 2015, Qwinix.io
#
# All rights reserved - Do Not Redistribute
#

###########################{CentOS Platform}#########################
if node[:platform].include?("centos")

   # Package install httpd
   package "nginx" do
     action :install
     not_if "rpm -q nginx"
   end
   
   # chkconfig
   execute "chkconfig nginx on" do
     command "chkconfig nginx on"
   end

   #
   # command

   #
   service "nginx" do
     stop_command    "systemctl stop nginx.service"
     start_command   "systemctl start nginx.service"
     restart_command "systemctl restart nginx.service"
     action :enable
  end

   #
   #Configration files
   #
   #httpd.conf
   template "/etc/nginx/nginx.conf" do
     source "conf/nginx.conf.erb"
     owner "root"
     group "root"
     mode "0664"
     notifies :restart, "service[nginx]"
 end
end
