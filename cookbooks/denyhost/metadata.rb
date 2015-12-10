name 'denyhost'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures denyhost'
long_description 'Installs/Configures denyhost'
version '0.1.0'

recipe "default","Install Denyhost,denyhost.conf,hosts.allow"



%w{centos ubuntu}.each do |os|
  supports os
end
