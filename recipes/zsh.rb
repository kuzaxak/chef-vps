search(node['users']['data_bag'], 'NOT action:remove').each do |user|
    template "/home/#{user['id']}/.zshrc" do
      source 'zshrc.erb'
      owner user['id']
      group user['id']
      mode '0744'
      action :create
    end

    git "/home/#{user['id']}/.oh-my-zsh" do
      repository 'https://github.com/robbyrussell/oh-my-zsh.git'
      action :checkout
      user user['id']
      group user['id']
      enable_submodules true
      depth 1
    end

    node.default['oh-my-zsh']['plugins']['custom'].each do |name, repo|
      git "/home/#{user['id']}/.oh-my-zsh/custom/plugins/#{name}" do
        repository repo
        action :checkout
        user user['id']
        group user['id']
        depth 1
      end
    end
end

## root

template "/root/.zshrc" do
  source 'zshrc.erb'
  owner user
  group user
  mode '0744'
  action :create
end

git "/root/.oh-my-zsh" do
  repository 'https://github.com/robbyrussell/oh-my-zsh.git'
  action :checkout
  user user
  group user
  enable_submodules true
  depth 1
end

node.default['oh-my-zsh']['plugins']['custom'].each do |name, repo|
  git "/root/.oh-my-zsh/custom/plugins/#{name}" do
    repository repo
    action :checkout
    user user
    group user
    depth 1
  end
end

execute 'sudo chsh -s /bin/zsh root'
