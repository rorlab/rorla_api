namespace :logs do
  desc "tail shared/log/production.log"
  task :tail_rails, :roles => :app do
    run "tail -f #{shared_path}/log/#{rails_env}.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "cat shared/log/production.log"
  task :cat_rails, :roles => :app do
    run "cat #{shared_path}/log/#{rails_env}.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "tail shared/log/unicorn.log"
  task :tail_unicorn, :roles => :app do
    run "tail -f #{shared_path}/log/unicorn.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "cat shared/log/unicorn.log"
  task :cat_unicorn, :roles => :app do
    run "cat #{shared_path}/log/unicorn.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "tail shared/log/delayed_job.log"
  task :tail_delayed_job, :roles => :app do
    run "tail -f #{shared_path}/log/delayed_job.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "cat shared/log/delayed_job.log"
  task :cat_delayed_job, :roles => :app do
    run "cat #{shared_path}/log/delayed_job.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end  

  desc "tail error.log of Nginx"
  task :tail_nginx_error, :roles => :web do
    run "tail -f /var/log/nginx/error.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "cat error.log of Nginx"
  task :cat_nginx_error, :roles => :web do
    run "cat /var/log/nginx/error.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end 

  desc "tail acess.log of Nginx"
  task :tail_nginx_access, :roles => :web do
    run "tail -f /var/log/nginx/access.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "cat acess.log of Nginx"
  task :cat_nginx_access, :roles => :web do
    run "cat /var/log/nginx/access.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end 

  #Clear log task
  desc "Clear out logs after deploy"
  task :clear, :roles => :app do
      #run "cp #{release_path}/log/#{rails_env}.log target_path.backup"
      run "cd #{current_path}; rake log:clear RAILS_ENV=#{rails_env}"
  end

end