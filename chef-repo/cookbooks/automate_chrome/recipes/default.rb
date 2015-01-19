#
# Cookbook Name:: automate_chrome
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.


powershell_script "Install Chrome" do
  cwd Chef::Config[:file_cache_path]
  environment({'chefc' => Chef::Config[:file_cache_path]})
  code <<-EOH
    (new-object System.Net.WebClient).Downloadfile("https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B40569D95-7A9C-D7C3-EAF6-1035625105AE%7D%26lang%3Den%26browser%3D2%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers/update2/installers/ChromeSetup.exe", "gc_install.exe")
    #START /WAIT "#{Chef::Config[:file_cache_path]}\gc_install.exe" -ms
    msiexec /i "#{Chef::Config[:file_cache_path]}\gc_install.exe" /qn /quiet /norestart
    #START /WAIT "Firefox Installer"  "c:\Windows\Temp\ff_install.exe" -ms
    #c:\ff_install.exe -ms
  EOH
  action :run
end