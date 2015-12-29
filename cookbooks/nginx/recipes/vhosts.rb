execute 'delete conf.d/*.*' do
     command 'rm -rf /etc/nginx/conf.d/*'
end

#Data bag for comman vhosts
data_bag("nginx_vhosts").each do |site|
  site_data = data_bag_item("nginx_vhosts",site)
  app_name = site_data["appname"]
  root_path = "/u01/apps/qwinix/#{app_name}/current/public"
  upstream_path = "/u01/apps/qwinix/#{app_name}/shared/tmp/sockets/#{app_name}.sock"

  template "/etc/nginx/conf.d/#{app_name}.conf" do
    source "custom-nginx-vhosts.erb"
    mode "0644"
    variables(
      :appname => app_name,
      :server_name => site_data["servername"],
      :root_path => root_path,
      :upstream_path => upstream_path,
      :listen => site_data["listen"],
    )
  end

  directory root_path do
    mode "0755"
    recursive true
  end

end
