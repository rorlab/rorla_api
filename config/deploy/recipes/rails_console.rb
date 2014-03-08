namespace :rails do
  desc "Open the rails dbconsole on one of the remote servers"
  task :db, :roles => :db do
    hostname = find_servers_for_task(current_task).first
    exec "ssh -l #{user} #{hostname} -t 'source ~/.bash_profile && #{current_path}/bin/rails db #{rails_env}'"
  end

  desc "Open the rails console on one of the remote servers"
  task :console, :roles => :app do
    hostname = find_servers_for_task(current_task).first
    exec "ssh -l #{user} #{hostname} -t 'source ~/.bash_profile && #{current_path}/bin/rails c #{rails_env}'"
  end
end