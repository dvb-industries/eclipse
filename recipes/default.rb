package "wget"

execute "create bin" do
  command "mkdir -p #{node[:eclipse][:bin]}"
  user node[:eclipse][:user]
  group node[:eclipse][:group]
  creates node[:eclipse][:bin]
end

execute "wget eclipse" do
  cwd node[:eclipse][:download]
  command "wget -O #{node[:eclipse][:package]} #{node[:eclipse][:url]}#{node[:eclipse][:package]}"
  user node[:eclipse][:user]
  group node[:eclipse][:user]
  creates "#{node[:eclipse][:download]}${node[:eclipse][:package]}"
end

execute "tar xvfz eclipse" do
  cwd node[:eclipse][:bin]
  command "tar xvfz #{node[:eclipse][:download]}#{node[:eclipse][:package]}"
  user node[:eclipse][:user]
  group node[:eclipse][:user]
  creates "#{node[:eclipse][:bin]}eclipse"
end

execute "mv eclipse" do
  cwd node[:eclipse][:bin]
  command "mv eclipse #{node[:eclipse][:package_name]}"
  user node[:eclipse][:user]
  group node[:eclipse][:user]
  creates "#{node[:eclipse][:bin]}${node[:eclipse][:package_name]}"
end

link "ln -s eclipse" do
  target_file "#{node[:eclipse][:bin]}eclipse"
  to "#{node[:eclipse][:bin]}#{node[:eclipse][:package_name]}/eclipse"
  user node[:eclipse][:user]
  group node[:eclipse][:user]
end
