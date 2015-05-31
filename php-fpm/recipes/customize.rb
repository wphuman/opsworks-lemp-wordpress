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
  manage_symlink_source true
end

php_fpm_pool 'www' do
  process_manager 'dynamic'
  max_children 40
  start_servers 10
  min_spare_servers 6
  max_spare_servers 12
  max_requests 500
  php_options 'php_admin_flag[log_errors]' => 'on', 'php_admin_value[memory_limit]' => '64M'
end
