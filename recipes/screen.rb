package 'screen'

search(node['users']['data_bag'], 'NOT action:remove').each do |user|
  template "/home/#{user['id']}/.screenrc" do
    source 'screenrc.erb'
    owner user['id']
    group user['id']
    mode '0744'
    action :create

    only_if "getent passwd #{user['id']}"
  end
end
