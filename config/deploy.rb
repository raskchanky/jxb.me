set :application, "jxb.me"
set :repository,  "git@github.com:raskchanky/jxb.me.git"
set :scm, :git
set :domain, "fatslice"
set :use_sudo, false
set :branch, "master"
set :deploy_via, :remote_cache

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

