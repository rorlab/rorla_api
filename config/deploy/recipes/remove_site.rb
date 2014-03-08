namespace :proj do
  desc "drop database and remove project directory and files"
  task :reset, :roles => :app do
    cmd = "DROP DATABASE ss_production"
    run "mysql -u deployer -p -e '#{cmd}'" do |channel, stream, data|
      if data =~ /^Enter password:/
        channel.send_data "joogoni2013\n"
      end
    end
    run "rm -rf /home/#{user}/apps/#{application}"
    run "#{sudo} rm /tmp/unicorn.#{application}.sock"
    run "#{sudo} rm /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} rm /etc/init.d/unicorn_#{application}"
  end
end
