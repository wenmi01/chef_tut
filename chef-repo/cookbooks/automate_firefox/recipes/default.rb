#
# Cookbook Name:: automate_firefox
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

powershell_script "Download firefox" do
  cwd Chef::Config[:file_cache_path]
  environment({'chefc' => Chef::Config[:file_cache_path]})
  code <<-EOH
    (new-object System.Net.WebClient).Downloadfile("http://hicap.frontmotion.com.s3.amazonaws.com/Firefox/Firefox-33.0.2/Firefox-33.0.2-en-US.msi", "ff_install.msi")
  EOH
  action :run
end

windows_package "Install Firefox" do
  source "#{Chef::Config[:file_cache_path]}\\ff_install.msi"
  action :install
end
