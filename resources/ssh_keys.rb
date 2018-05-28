resource_name :ssh_keys

property :home, String
property :ssh_public_key, String
property :ssh_private_key, String
property :user, String
property :key_name, String, default: 'id_rsa'

action :create do
  user_home = new_resource.home
  if user_home.nil?
    user_home = ::Etc.getpwnam(new_resource.user).dir
  end

  directory "#{user_home}/.ssh" do
    owner new_resource.user
    group new_resource.user
    mode '0700'
    recursive true
    action :create
  end

  file "#{user_home}/.ssh/#{new_resource.key_name}.pub" do
    content new_resource.ssh_public_key
    mode '0644'
    owner new_resource.user
    group new_resource.user
  end

  file "#{user_home}/.ssh/#{new_resource.key_name}" do
    content new_resource.ssh_private_key
    mode '0600'
    owner new_resource.user
    group new_resource.user
    sensitive true
  end
end
