# Docker Images Cookbook

## Description

A cookbook for pulling docker images from dockerhub and spinning up containers from node attributes (including host integration). 

## Usage

Set your dockerhub username, password and email by overriding:

node['docker_username'] = your_username
node['docker_password'] = your_password
node['docker_email'] = your email

Using something like [chef-credentials](https://github.com/cfreeman/chef-credentials) will allow you to encrypt and store these
attributes within an encrypted data bag (so they can be safely commit to your source control).

Define the images you want to be installed and spun up as containers on the node:

node['docker_images'] = [{'name' => 'nginx', 'port' => '80:80'}]

Now include the 'docker-images' cookbook as part of your run\_list for a node, and when you cook the server it will pull down
the latest version of the docker image, create a container (with in the example above port 80 mapped to port 80) and create
the necessary init scripts to ensure your container spins up on boot.

## Installation using Librarian-Chef

[Librarian-Chef](https://github.com/applicationsonline/librarian#readme) is a bundler for your chef cookbooks. To install Librarian-Chef:

	cd chef-repo
	gem install librarian
	librarian-chef init

To use credentials:

	echo "cookbook 'docker-images', git: 'git://github.com/cfreeman/chef-docker-images.git'" >> Cheffile

## Recipes

### default

Pulls docker images and creates matching containers from metadata specified in node attributes


## License

Copyright 2015, Clinton Freeman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
