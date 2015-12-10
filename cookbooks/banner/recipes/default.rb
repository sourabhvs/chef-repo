#
# Cookbook Name:: banner
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

template "/etc/motd" do
source "banner.erb"
end 
template "/etc/issue" do
source "banner.erb"
end
template "/etc/issue.net" do
source "banner.erb"
end
