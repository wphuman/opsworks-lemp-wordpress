include_recipe "php-fpm::service"

service "php-fpm" do
  action :stop
end
