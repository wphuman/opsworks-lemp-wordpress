#
# Cookbook Name:: deploy
# Recipe:: php-restart

include_recipe 'deploy'
Chef::Log.debug("Called deploy::nginx-restart")

node[:deploy].each do |application, deploy|

  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::nginx-restart application #{application} as it is not a PHP app")
    next
  end

  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action :reload
  end

  notifies :restart, 'service[php-fpm]'
end
