set :stage, :staging
set :branch, 'stable'
set :repo_url, "git@github.com:thefantos/#{fetch(:application)}.git"

server '35.165.228.183', user: 'deployer', roles: %w{app web db}
