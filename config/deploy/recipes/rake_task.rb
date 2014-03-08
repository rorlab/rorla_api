namespace :rake_task do
  desc "remote rake tasks"
  task :invoke do
    if ENV['COMMAND'].to_s.strip == ''
      puts "USAGE: cap rake_task:invoke COMMAND='db:migrate'" 
    else
      run "cd #{current_path} && RAILS_ENV=production bundle exec rake #{ENV['COMMAND']}"
    end
  end                           
end