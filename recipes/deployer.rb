search(node['deployer']['users']['data-bag']).each do |u|
  user = Chef::EncryptedDataBagItem.load(node['deployer']['users']['data-bag'], u[:id])
  pub_file = user['ssh_public_key']
  key_file = user['ssh_private_key']

  ssh_keys "make_key" do
    ssh_public_key pub_file
    ssh_private_key key_file
    user u[:id]
  end

  execute "change #{u[:id]} shell" do
    command "chsh --shell /bin/zsh #{u[:id]}"
    action :run
  end
end

remote_file "/usr/local/bin/dep" do
	source "https://deployer.org/deployer.phar"
	mode 0755

	action :create_if_missing
end
