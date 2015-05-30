default['php-fpm']['conf_dir'] = "/etc/php-fpm.d"
default['php-fpm']['conf_file'] = "/etc/php-fpm.conf"
default['php-fpm']['pid'] = "/var/run/php-fpm/php-fpm.pid"
default['php-fpm']['error_log'] =  "/var/log/php-fpm/error.log"
default['php-fpm']['log_level'] = "notice"
default['php-fpm']['emergency_restart_threshold'] = 1
default['php-fpm']['emergency_restart_interval'] = "1m"
default['php-fpm']['process_control_timeout'] = 30


default['php-fpm']['pools'] = ["www"]

default['php-fpm']['pool']['www']['listen'] = "127.0.0.1:9000"
default['php-fpm']['pool']['www']['allowed_clients'] = ["127.0.0.1"]
default['php-fpm']['pool']['www']['user'] = 'nginx'
default['php-fpm']['pool']['www']['group'] = 'nginx'
default['php-fpm']['pool']['www']['process_manager'] = "dynamic"
default['php-fpm']['pool']['www']['max_children'] = 40
default['php-fpm']['pool']['www']['start_servers'] = 12
default['php-fpm']['pool']['www']['min_spare_servers'] = 4
default['php-fpm']['pool']['www']['max_spare_servers'] = 20
default['php-fpm']['pool']['www']['max_requests'] = 200
default['php-fpm']['pool']['www']['request_terminate_timeout'] = "3m"


default['php-fpm']['pool']['testpool']['listen'] = "127.0.0.1:9001"
default['php-fpm']['pool']['testpool']['allowed_clients'] = ["127.0.0.1"]
default['php-fpm']['pool']['testpool']['user'] = 'nginx'
default['php-fpm']['pool']['testpool']['group'] = 'nginx'
default['php-fpm']['pool']['testpool']['process_manager'] = "dynamic"
default['php-fpm']['pool']['testpool']['max_children'] = 50
default['php-fpm']['pool']['testpool']['start_servers'] = 5
default['php-fpm']['pool']['testpool']['min_spare_servers'] = 5
default['php-fpm']['pool']['testpool']['max_spare_servers'] = 35
default['php-fpm']['pool']['testpool']['max_requests'] = 500
