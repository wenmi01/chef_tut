#
# Cookbook Name:: automate_firefox
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

powershell_script "Install firefox" do
  guard_interpreter :powershell_script
  cwd "c:\Windows\Temp\"
  code <<-EOH
    (new-object System.Net.WebClient).Downloadfile("https://download-installer.cdn.mozilla.net/pub/firefox/releases/35.0/win32/en-US/Firefox%20Setup%20Stub%2035.0.exe", "c:\Windows\Temp\ff_install.exe")
    START /WAIT "C:\Windows\Temp\ff_install.exe" -ms
    #START /WAIT "Firefox Installer"  "c:\Windows\Temp\ff_install.exe" -ms
    #c:\ff_install.exe -ms
  EOH
  action :run
end
