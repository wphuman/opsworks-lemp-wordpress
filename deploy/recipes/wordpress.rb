#
# Cookbook Name:: deploy
# Recipe:: wordpress
#

include_recipe 'wordpress::mkdirs'
include_recipe 'wordpress::set-env-vars'
