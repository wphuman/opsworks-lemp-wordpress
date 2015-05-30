include_recipe "php-fpm::service"

service 'php5-fpm' do
  action :stop
end
