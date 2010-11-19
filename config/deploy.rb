set :application, "jxb.me"
set :repository,  "git@github.com:raskchanky/jxb.me.git"
set :scm, :git
set :domain, "fatslice"
set :use_sudo, false
set :deploy_via, :remote_cache
set :user, "deploy"
set :branch, "master"
set :application_url, "jxb.me"
set :deploy_to, "/var/www/apps/jxb.me"
set :rails_env, "production"
set :runner, user

role :web, domain
role :app, domain
role :db, domain, :primary => true

default_run_options[:pty] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

