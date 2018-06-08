#
# Cookbook:: vps
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update

case node['platform_family']
  when 'rhel'
    node.normal['yum-cron']['daily']['commands'] = {
        'update_cmd' => 'security',
        'update_messages' => 'yes',
        'download_updates' => 'yes',
        'apply_updates' => 'yes',
        'random_sleep' => 360
      }
    include_recipe 'yum-cron::default'
    package 'nc'
  when 'debian'
    package 'netcat'
end

node['main']['packages'].each do |pkg|
    package pkg
end

ssh_known_hosts_entry 'github.com'

users_manage 'sysadmin' do
  group_id 3000
  action [:remove, :create]
end

users_manage 'deploy' do
  group_id 3200
  action [:remove, :create]
end

# Node specific users group
users_manage node.name do
  group_id 3100
  action [:remove, :create]
end

node.default['authorization']['sudo']['groups'] = ['sysadmin']
node.default['authorization']['sudo']['passwordless'] = true
include_recipe "sudo"

include_recipe 'ssh-hardening'
include_recipe '::zsh'
