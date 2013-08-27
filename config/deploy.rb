# 変更が必要な内容
set :application, 'rails-example'
set :repository,  'git@github.com:dddaisuke/rails-example.git'
set :user, 'deploy-user'
set :use_sudo, false

set :scm, :git
set :rails_env,   "production"
set :keep_releases, 2

set :deploy_via, :copy
set :bundle_cmd, "/home/#{user}/.rbenv/shims/bundle"
set :bundle_without, [:development, :test]

set :default_environment, {
  'PATH' => "$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH",
}

after :deploy, "deploy:cleanup"
after "deploy:setup" do
  run <<-CMD
    mkdir -p "#{shared_path}/run"
  CMD
end
before 'deploy:restart', 'deploy:fix_permission'
before 'deploy:start', 'deploy:fix_permission'

namespace :deploy do
  task :fix_permission do
    run "chmod +x #{unicorn_script}"
  end
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_script} start"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{unicorn_script} stop"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{unicorn_script} graceful_stop"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_script} reload"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_script} restart"
  end
end
