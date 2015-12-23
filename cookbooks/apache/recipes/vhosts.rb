data_bag("vhosts").each do |site|
  site_data = data_bag_item("vhosts",site)
  app_name = site_data["appname"]
  document_root = "/u01/apps/qwinix/#{app_name}/current/public/"
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
      :passenger_mod => site_data["passenger_mod"],
      :passenger_ruby_home => site_data["passenger_ruby_home"],
      :passenger_pool_size => site_data["passenger_pool_size"],
      :passenger_pool_id => site_data["passenger_pool_id"],
      :passenger_maxinstance_app => site_data["passenger_maxinstance_app"],  
      :rails_env => site_data["rails_env"]
    )
   notifies :restart, "service[httpd]"
  end

  directory document_root do
    mode "0755"
    recursive true
  end

template "#{document_root}/index.html" do
    source "index.html.erb"
    mode "0644"
    variables(
      :app_name => app_name,
      :server_name => site_data["servername"]
    )
  end
end
