filesystem "stuff" do
  fstype "ext4"
  device "/dev/sdb"
  mount "/stuff"
  options "noatime,nodiratime"

  action [:create, :enable, :mount]
end
