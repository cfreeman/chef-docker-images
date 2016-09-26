#
# Cookbook Name:: docker-image
# Recipe:: default
#
# Copyright 2015, Clinton Freeman
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

docker_installation 'default' do
  action :create
end

docker_service_manager_systemd 'default' do
	action :start
end

# Log into docker hub.
docker_registry 'https://index.docker.io/v1/' do
  username node['docker_username']
  password node['docker_password']
  email node['docker_email']
end

node['docker-images'].each do |i|
	docker_image i['name'] do
		tag 'latest'
		action :pull
		notifies :redeploy, 'docker_container['+i['container-name']+']'
	end

	docker_container i['container-name'] do
		restart_policy 'always'
		#action :redeploy
		#detach true

		repo i['name']
		tag 'latest'

		unless i['port'].nil?
			port i['port']
		end

		unless i['volumes'].nil?
			volumes_from i['volumes']
		end
	end
end