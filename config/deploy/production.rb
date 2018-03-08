set :stage, :production

set :default_env, { path: "/usr/local/ruby-2.3.6/bin:$PATH" }

server '159.65.135.2', user: 'deploy', roles: %w{app web db}

set :deploy_to, '/home/deploy/5xruby.tw'
