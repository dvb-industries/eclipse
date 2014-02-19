package "wget"

execute "create bin" do
  command "mkdir -p #{node[:eclips][:bin]}"
  user node[:eclipse][:user]
  group node [:eclipse][:group]
  creates "#{node[:eclipse][:bin]}"
end

execute "wget eclipse" do
  cwd node[:eclipse][:download]
  command "wget #{node[:eclipse][:url]}#{node[:eclipse][:package]}"
  creates "#{node[:eclipse][:download]}${node[:eclipse][:package]}"
end

execute "tar xvfz eclipse" do
  cwd node[:eclipse][:bin]
  command "tar xvfz #{node[:eclipse][:download]}#{node[:eclipse][:package]}"
end

execute "ln -s eclipse" do
  cwd node[:eclipse][:bin]
  # should actually be a link
  command "ln -s eclipse #{node[:eclipse][:package_name]}"
end
