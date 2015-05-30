#
# Cookbook Name:: deploy
# Recipe:: php-undeploy

include_recipe 'deploy'
include_recipe 'nginx::service'
include_recipe 'php-fpm::service'
Chef::Log.debug("Called deploy::php-undeploy")

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping undeploy::web application #{application} as it is not a PHP app")
    next
  end

  link "#{node[:nginx][:dir]}/sites-enabled/#{application}" do
    action :delete
    only_if do
      ::File.exists?("#{node[:nginx][:dir]}/sites-enabled/#{application}")
    end
    notifies :restart, resources(:service => 'nginx')
  end

  directory "#{deploy[:deploy_to]}" do
    recursive true
    action :delete
    only_if do
      ::File.exists?("#{deploy[:deploy_to]}")
    end
  end
end
