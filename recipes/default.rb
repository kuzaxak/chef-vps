#
# Cookbook:: vps
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update

node['main']['packages'].each do |pkg|
    package pkg
end

ssh_known_hosts_entry 'github.com'

users_manage 'sysadmin' do
  group_id 3000
  action [:create]
end

node.default['authorization']['sudo']['groups'] = ['sysadmin']
node.default['authorization']['sudo']['passwordless'] = true
include_recipe "sudo"

include_recipe 'ssh-hardening'
include_recipe '::zsh'
