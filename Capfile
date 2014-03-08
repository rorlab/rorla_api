# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#
# require 'capistrano/rvm'
# require 'capistrano/chruby'

require 'capistrano/rbenv'

# Require everything (bundler, rails/assets and rails/migrations)
require 'capistrano/rails'

# Or require just what you need manually:
# require 'capistrano/bundler' # Rails needs Bundler, right?
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'

# Please note that any require should be placed in Capfile, not config/deploy.rb.

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
