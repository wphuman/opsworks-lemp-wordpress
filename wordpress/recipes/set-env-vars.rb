# AWS OpsWorks Recipe for Wordpress to be executed during the Configure lifecycle phase
# - Creates the config file wp-config.php with MySQL data.

node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/current/#{deploy[:document_root]}/env-config.php" do
    source "env-config.php.erb"
    mode 0660
    group deploy[:group]
    owner deploy[:user]

    variables(
      :database   => (deploy[:database][:database] rescue nil),
      :user       => (deploy[:database][:username] rescue nil),
      :password   => (deploy[:database][:password] rescue nil),
      :host       => (deploy[:database][:host] rescue nil),
      :env_vars   => (deploy[:environment_variables] rescue nil)
      )
  end

end
