node[:deploy].each do |application, deploy|
  opsworks_deploy_user do
    deploy_data deploy
  end
    opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end
  puma_web_app do
    application application
    deploy deploy
  end if deploy[:puma]

  service application do
    provider Chef::Provider::Service::Upstart
    supports :start => true, :stop => true, :restart => false
    action :restart
  end
end
