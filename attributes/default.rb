node.default['main']['packages'] = [
  'nano', 'git', 'zsh', 'wget'
]

node.default['users'] = ['kkkk']

node.override['ssh-hardening']['network']['ipv6']['enable'] = true
node.override['ssh-hardening']['ssh']['server']['allow_root_with_key'] = true
node.override['ssh-hardening']['ssh']['server']['allow_agent_forwarding'] = true
node.override['ssh-hardening']['ssh']['server']['allow_x11_forwarding'] = true
node.override['ssh-hardening']['ssh']['server']['sftp']['enable'] = true
node.override['ssh-hardening']['ssh']['server']['sftp']['chroot'] = "/home/sftp/%u"
node.override['ssh-hardening']['ssh']['server']['sftp']['sftusers'] =  "sftusers"

default['oh-my-zsh'] = {
  'plugins' => {
    'custom' => {
      'zsh-autosuggestions' => 'https://github.com/zsh-users/zsh-autosuggestions',
      'history-search-multi-word' => 'https://github.com/zdharma/history-search-multi-word.git'
    },
    'default' => {

    }
  }
}
