#
# Cookbook Name:: automate_chrome
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.


src_npp = "C:\tmp\npp.installer.exe"
remote_file src_npp do
  source "http://download.tuxfamily.org/notepadplus/6.7.4/npp.6.7.4.Installer.exe"
end

#Install Notepad++ using windows_package
#http://docs.opscode.com/lwrp_windows.html#windows-package
windows_package "Notepad++" do
  source 'C:\tmp\npp.installer.exe' 
  action :install 
end
