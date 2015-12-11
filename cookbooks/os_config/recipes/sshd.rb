#
# Cookbook Name:: sshd
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# if the node is ubuntu (only for disabling password authentication )

if node[:platform].include?('ubuntu')

package 'openssh-server'
package 'openssh-client'
service 'ssh' do
action [:enable, :start]
only_if { 'node.["sshd"]["path_ubuntu"] = "false"' }
end

       template '/etc/ssh/sshd_config' do 
       source 'ubuntu_config.erb'
       variables(
        :response => "no"
       )
    end 

# if node is centos disable password authentication and install open SSH if not present and restart the ssh service

 elsif case node[:platform] when 'centos'

  package 'openssh-server'
  package 'openssh-clients'

#start SSHD service 
     bash 'extarct_module' do 
     code <<-EOH
     chkconfig sshd on
     service sshd start
     EOH
     only_if { 'node.["sshd"]["path"] = "false"' }
  end

#Update the configuration files for sshd_config
     template "/etc/ssh/sshd_config" do
      source "centos_config.erb"
       variables(
        :response => "no",
        :without => "without-password"
       )
    end
 end

#restart the sshd service after applying the changes 
    execute 'restart_service' do 
     command 'service sshd restart'
  end 

end
