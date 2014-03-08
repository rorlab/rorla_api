set_default(:postgresql_host, "localhost")
set_default(:postgresql_user) { application }
set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
set_default(:postgresql_database) { "#{application}_production" }

namespace :postgresql do
  desc "Install the latest stable release of PostgreSQL."
  task :install, roles: :db, only: {primary: true} do

    #####################################
    #         for Ubuntu Server         #
    #####################################
    # run "#{sudo} add-apt-repository ppa:pitti/postgresql"
    # run "#{sudo} apt-get -y update"
    # run "#{sudo} apt-get -y install postgresql libpq-dev"

    #####################################
    #         for CentOS Server         #
    #####################################
    # Download the PostgreSQL 8.4 repository RPM
    run "#{sudo} wget http://yum.pgsqlrpms.org/reporpms/8.4/pgdg-centos-8.4-2.noarch.rpm"
    # Add the repository
    run "#{sudo} rpm -ivh pgdg-centos-8.4-2.noarch.rpm"
    # Use yum to install PostgresSQL
    run "#{sudo} yum install -y postgresql postgresql-server"
    # Initialize the database
    run "#{sudo} /etc/init.d/postgresql initdb"
    # Start the database
    run "#{sudo} /etc/init.d/postgresql restart"
    # Automatically start database on boot
    run "#{sudo} chkconfig --levels 235 postgresql on"

  end
  after "deploy:install", "postgresql:install"

  desc "Create a database for this application."
  task :create_database, roles: :db, only: {primary: true} do
    run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
  end
  after "deploy:setup", "postgresql:create_database"

  desc "Generate the database.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "postgresql:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "postgresql:symlink"
end