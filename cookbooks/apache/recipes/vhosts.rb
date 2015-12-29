execute 'delete conf.d/*.*' do
     command 'rm -rf /etc/httpd/conf.d/*'
end

#Data bag for comman vhosts 
data_bag("vhosts").each do |site|
  site_data = data_bag_item("vhosts",site)
  app_name = site_data["appname"]
  app_path = site_data["apppath"]
  document_root = "/u01/apps/qwinix/#{app_name}/#{app_path}"
  errolog = "/u01/logs/httpd/#{app_name}-error.log"
  customlog = "/u01/logs/httpd/#{app_name}-access.log"

  template "/etc/httpd/conf.d/#{app_name}.conf" do
    source "custom-vhosts.erb"
    mode "0644"
    variables(
      :appname => site_data["appname"],
      :port => site_data["port"],
      :server_name => site_data["servername"],
      :document_root => document_root,
    )
  end

  directory document_root do
    mode "0755"
    recursive true
  end

end

#Data bag for ROR application vhosts 
data_bag("vhosts_ROR").each do |site|
  site_data = data_bag_item("vhosts_ROR",site)
  app_name = site_data["appname"]
  document_root = "/u01/apps/qwinix/#{app_name}/current/public/"
  errolog = "/u01/logs/httpd/#{app_name}-error.log"
  customlog = "/u01/logs/httpd/#{app_name}-access.log"

  template "/etc/httpd/conf.d/#{app_name}.conf" do
    source "custom-vhosts-ror.erb"
    mode "0644"
    variables(
      :appname => site_data["appname"],
      :port => site_data["port"],
      :server_name => site_data["servername"],
      :document_root => document_root,
      :passenger_mod => site_data["passenger_mod"],
      :passenger_root => site_data["passenger_root"],
      :passenger_ruby => site_data["passenger_ruby"],
      :rails_env => site_data["rails_env"]
    )
   notifies :restart, "service[httpd]"
  end

  directory document_root do
    mode "0755"
    recursive true
  end
end
