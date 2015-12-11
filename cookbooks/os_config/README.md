# os_config
===============================================================================================================================================
PURPOSE : 

   This cookbook is used to maintain predefined OS configurations.

   If the configuration are changed it will be rolled back to the configurations defined in the recipe.

RECIPES :

 sshd.rb :- 

   This recipe includes the configurations under /etc/ssh/sshd_config of both ubuntu and centos.

   The password authentication is set to the variable "no" so that it does not allow password authenticity.

   It checks if the necessary pacakages are available for 'open ssh' and if exists it ignores the installation.

   It sets the variable for 'permitrootlogin' to 'without-password'.
 
 devops_users.rb :-
 
   This recipe is used to create both devops user and deploy user only if the users do not exist

   It creates a directory using the directory resource using the attribute node['sshd']['authorized_path'].

   It creates a file using the file resource under the attribute node['sshd']['authorized_path_devops']}/authorized_keys.

   These attributes will be defined in the attributes directory.

   This will also add the devops user to the sudoers file '/etc/sudoers' to permit the devops usr without password.

 devops_keys.rb :-

   This is the master file which includes the sshd.rb and devops_users.rb recipe.

   The first template is used to include two keys for logrotate and a key for jenkins

   The second template is used to include the devops keys.

ATTRIBUTE :

  centos_ope :-
  
   Defines path for the following 

   *default['sshd']['path'] = '/etc/init.d/sshd'

   *default['sshd']['authorized_path'] = '/home/deploy/.ssh'

   *default['sshd']['authorized_path_devops'] = '/home/devops/.ssh

TEMPLATE :

  authorized.erb : contains two keys of logrotate and one key of jenkins 
  
  centos_config.erb : centos sshd configurations

  ubuntu_config.erb : ubuntu ssh configurations  

  devops_authorized.erb : devops keys 

  sudoers_centos.erb : sudoers file under /etc/sudoers


===============================================================================================================================================
  
