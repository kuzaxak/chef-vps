version = '2.4.1'

rbenv_system_install 'system'
rbenv_ruby version
rbenv_global version

rbenv_gem 'bundler' do
  rbenv_version version
end
