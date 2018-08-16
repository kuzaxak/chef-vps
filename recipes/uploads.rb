search(node['uploads']['data-bag']).each do |f|
  file = Chef::EncryptedDataBagItem.load(node['uploads']['data-bag'], f[:id])

  directory "#{file['folder']}" do
    owner file['user']
    group file['group']
    mode '0755'
    recursive true
    action :create
  end

  file "#{file['folder']}/#{file['filename']}" do
    content file['content']
    mode file['mode']
    owner file['user']
    group file['group']
    sensitive true
    backup false
  end
end
