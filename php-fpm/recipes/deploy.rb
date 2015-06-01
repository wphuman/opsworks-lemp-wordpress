#
# Cookbook Name:: php-fpm
# Recipe:: deploy
#

include_recipe 'deploy'
include_recipe "nginx::service"

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping php-fpm::deploy application #{application} as it is not an PHP app")
    next
  end

  if node['php-fpm']['package_name'].nil?
    if platform_family?("rhel", "fedora")
      php_fpm_package_name = "php-fpm"
    else
      php_fpm_package_name = "php5-fpm"
    end
  else
    php_fpm_package_name = node['php-fpm']['package_name']
  end

  if node['php-fpm']['service_name'].nil?
    php_fpm_service_name = php_fpm_package_name
  else
    php_fpm_service_name = node['php-fpm']['service_name']
  end

  service_provider = nil
  if node['platform'] == 'ubuntu' and node['platform_version'].to_f >= 13.10
    service_provider = ::Chef::Provider::Service::Upstart
  end

  directory node['php-fpm']['log_dir']

  service "php-fpm" do
    provider service_provider if service_provider
    service_name php_fpm_service_name
    supports :start => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :restart ]
  end
end
