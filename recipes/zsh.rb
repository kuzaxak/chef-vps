search(node['users']['data_bag'], 'NOT action:remove').each do |user|
    template "/home/#{user['id']}/.zshrc" do
      source 'zshrc.erb'
      owner user['id']
      group user['id']
      mode '0744'
      action :create

      only_if "getent passwd #{user['id']}"
    end

    git "/home/#{user['id']}/.oh-my-zsh" do
      repository 'https://github.com/robbyrussell/oh-my-zsh.git'
      action :checkout
      user user['id']
      group user['id']
      enable_submodules true
      depth 1

      not_if { File.exist?("/home/#{user['id']}/.oh-my-zsh") }
      only_if "getent passwd #{user['id']}"
    end

    node.default['oh-my-zsh']['plugins']['custom'].each do |name, repo|
      git "/home/#{user['id']}/.oh-my-zsh/custom/plugins/#{name}" do
        repository repo
        action :checkout
        user user['id']
        group user['id']
        depth 1

        not_if { File.exist?("/home/#{user['id']}/.oh-my-zsh/custom/plugins/#{name}") }
        only_if "getent passwd #{user['id']}"
      end
    end

    directory "/home/#{user['id']}/.git" do
      user user['id']
      group user['id']
      mode '0755'
      recursive true
      action :create

      only_if "getent passwd #{user['id']}"
    end

    execute 'disable dirty_files' do
      command "sudo su -c \"cd && git config oh-my-zsh.hide-dirty 1\" #{user['id']}"
      action :run

      only_if "getent passwd #{user['id']}"
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

  not_if { File.exist?("/root/.oh-my-zsh") }
end

node.default['oh-my-zsh']['plugins']['custom'].each do |name, repo|
  git "/root/.oh-my-zsh/custom/plugins/#{name}" do
    repository repo
    action :checkout
    user user
    group user
    depth 1

    not_if { File.exist?("/root/.oh-my-zsh/custom/plugins/#{name}") }
  end
end

execute 'sudo chsh -s /bin/zsh root'
execute 'disable dirty_files' do
  command 'git config --global oh-my-zsh.hide-dirty 1'
  action :run
end
