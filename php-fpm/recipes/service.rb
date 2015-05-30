service "php-fpm" do
  supports :start => true, :stop => true, :restart => true, :reload => true
  action :nothing
end
