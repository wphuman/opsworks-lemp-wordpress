node[:deploy].each do |application, deploy|

  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping php::configure application #{application} as it is not an PHP app")
    next
  end

  %w{uploads cache backups}.each do |dir|
    directory "#{deploy[:deploy_to]}/current/#{deploy[:document_root]}/wp-content/#{dir}" do
      owner deploy[:user]
      group deploy[:group]
      mode '0775'
      action :create
    end
  end
end
