#
# Cookbook Name:: automate_firefox
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

powershell_script "Install firefox" do
  cwd Chef::Config[:file_cache_path]
  environment({'chefc' => Chef::Config[:file_cache_path]})
  code <<-EOH
    (new-object System.Net.WebClient).Downloadfile("http://hicap.frontmotion.com.s3.amazonaws.com/Firefox/Firefox-33.0.2/Firefox-33.0.2-en-US.msi", "ff_install.exe")
    #START /WAIT "#{Chef::Config[:file_cache_path]}\ff_install.exe" -ms
    msiexec /i "#{Chef::Config[:file_cache_path]}\ff_install.exe" /qn /quiet /norestart
    #START /WAIT "Firefox Installer"  "c:\Windows\Temp\ff_install.exe" -ms
    #c:\ff_install.exe -ms
  EOH
  action :run
end
