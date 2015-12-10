# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "vssourabh"
client_key               "#{current_dir}/vssourabh.pem"
validation_client_name   "qwinix-validator"
validation_key           "#{current_dir}/qwinix-validator.pem"
chef_server_url          "https://chefserver.qwinixtech.com/organizations/qwinix"
cookbook_path            ["#{current_dir}/../cookbooks"]
