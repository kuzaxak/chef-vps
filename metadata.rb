name 'vps'
maintainer 'Vladimir Kuznichenkov'
maintainer_email 'kuzaxak.tech@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures vps'
long_description 'Installs/Configures vps'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'sudo'
depends 'users'
depends 'ssh-hardening'
depends 'ssh_known_hosts'
depends 'ruby_rbenv', '~> 2.0.7'
