override['ssh-hardening']['network']['ipv6']['enable'] = true
override['ssh-hardening']['ssh']['server']['allow_root_with_key'] = true
override['ssh-hardening']['ssh']['server']['allow_agent_forwarding'] = true
override['ssh-hardening']['ssh']['server']['allow_x11_forwarding'] = true
override['ssh-hardening']['ssh']['server']['allow_tcp_forwarding'] = true
override['ssh-hardening']['ssh']['server']['sftp']['enable'] = true
override['ssh-hardening']['ssh']['server']['sftp']['chroot'] = "/home/sftp/%u"
override['ssh-hardening']['ssh']['server']['sftp']['sftusers'] =  "sftusers"
