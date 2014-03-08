namespace :nodejs do
  desc "Install the latest relase of Node.js"
  task :install, roles: :app do

    # for Ubuntu Server
    # run "#{sudo} add-apt-repository ppa:chris-lea/node.js"
    # run "#{sudo} apt-get -y update"
    # run "#{sudo} apt-get -y install nodejs"

    # for CentOS Server
    run "#{sudo} wget http://nodejs.tchol.org/repocfg/el/nodejs-stable-release.noarch.rpm"
    run "#{sudo} yum localinstall -y --nogpgcheck nodejs-stable-release.noarch.rpm"
    run "#{sudo} yum install -y nodejs-compat-symlinks npm"

  end
  after "deploy:install", "nodejs:install"
end