#
# Cookbook Name:: nginx
# Recipe:: fronta
# Author:: Alex Shvid <a@schwid.com>
#
# Copyright 2012, Alex Shvid.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

fronta = data_bag_item("fronta","fronta")

cookbook_file "#{node['nginx']['dir']}/ssl.crt" do
  source "ssl/ssl.crt"
  owner "root"
  group "root"
  mode "0600"
end

#cookbook_file "#{node['nginx']['dir']}/ssl.key" do
#  source "ssl/ssl.key"
#  owner "root"
#  group "root"
#  mode "0600"
#end

template "#{node['nginx']['dir']}/sites-available/ssl" do
  source "ssl-site.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :forwards => fronta["ssl_forwards"]
  )
end

nginx_site "ssl" do
  enable true
end

fronta["forwards"].each do |forward|
  template "#{node['nginx']['dir']}/sites-available/#{forward['site']}" do
    source "forward-site.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
      :forward => forward
    )
  end
  nginx_site "#{forward['site']}" do
    enable forward['enabled']
  end
end

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action :restart
end
