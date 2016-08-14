#
# Cookbook Name:: lampstack
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Updating the apt cache

execute "apt-update" do
  command 'apt-get update && apt-get upgrade -y'
  action :run
  ignore_failure true
  not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
end

# install start and enable apache2

include_recipe 'lampstack::apache'
