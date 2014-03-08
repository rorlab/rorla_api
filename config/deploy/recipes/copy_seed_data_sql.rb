desc "Uploads dump sql 'categories, roles and user_groups' files for seed to all remote servers."
task :copy_seed_tables do
  set(:db_user) { Capistrano::CLI.ui.ask "Enter #{environment} database username:" }
  set(:db_pass) { Capistrano::CLI.password_prompt "Enter #{environment} database password:" }
  run_locally("scp roles.sql user_groups.sql #{user}@#{host_ip}:~/apps/#{application}/")
  run("mysql -u #{db_user} -p#{db_pass} -e 'source /home/#{user}/apps/#{application}/roles.sql' #{application}_#{environment}")
  run("mysql -u #{db_user} -p#{db_pass} -e 'source /home/#{user}/apps/#{application}/user_groups.sql' #{application}_#{environment}")
end
