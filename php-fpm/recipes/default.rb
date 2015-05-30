# Include nginx
include_recipe "nginx"

php_fpm_service_name = "php-fpm"
packages = [
  'php5-fpm',
  'php5-gd',
  'libssh2-php',
  'php5-memcached',
  'php5-mysql',
  'php5-curl',
  'php5-common',
  'php5-xmlrpc'
]

# install all the packages
packages.each do |up_package|
  package up_package do
    action :upgrade
  end
end

# some network optimizations
bash "tcp_keepalive_time" do
  user "root"
  code <<-EOH
    echo 300 | sudo tee /proc/sys/net/ipv4/tcp_keepalive_time
  EOH
end

template '/etc/php5/fpm/conf.d/01-cgi.ini' do
  source '01-cgi.ini.erb'
  mode 0644
  owner 'root'
  group 'root'
end

template '/etc/php5/fpm/conf.d/02-date.ini' do
  source '02-date.ini.erb'
  mode 0644
  owner 'root'
  group 'root'
end

template '/etc/php5/fpm/conf.d/05-opcache.ini' do
  source '05-opcache.ini.erb'
  mode 0644
  owner 'root'
  group 'root'
end

template '/etc/php5/fpm/pool.d/www.conf.erb' do
  source 'www.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
end

include_recipe "php-fpm::service"

service "php-fpm" do
  action [ :restart ]
end
