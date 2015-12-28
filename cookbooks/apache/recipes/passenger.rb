#Data bag for diff passenger version 
data_bag("passenger").each do |site|
  site_data = data_bag_item("passenger",site)
  pass_name = site_data["version"]
  template "/etc/httpd/conf.d/#{pass_name}.conf" do
    source "passenger.erb"
    mode "0644"
    variables(
      :passenger_mod => site_data["passenger_mod"],
      :passenger_ruby_root => site_data["passenger_ruby_root"],
      :passenger_ruby_home => site_data["passenger_ruby_home"],
      :passenger_pool_size => site_data["passenger_pool_size"],
      :passenger_pool_id => site_data["passenger_pool_id"],
      :passenger_maxinstance_app => site_data["passenger_maxinstance_app"],  
    )
   notifies :restart, "service[httpd]"
  end
end
