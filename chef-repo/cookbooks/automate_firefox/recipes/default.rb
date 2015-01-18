#
# Cookbook Name:: automate_firefox
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

powershell_script "Install firefox" do
  guard_interpreter :powershell_script
  code <<-EOH
    (new-object System.Net.WebClient).Downloadfile("http://download.downloadd.co/v2/click/80af325a/?d=http%3A%2F%2Fdownloadd.co%2Fdownload%2Ffirefox.exe&n=Mozilla+FireFox&key=2c4de7f94ef751f16c23013d83473aaf05cff15dbbe3716d87a7e197eaabe046&affiliate_image=&product_image=http%3A%2F%2Fdownloadd.co%2Fdownload%2Ffirefox.png&sid=firefox&filename=Firefox_Setup_26.0", "c:\ff_install.exe")
     #@START /WAIT "Firefox Installer"  "c:\ff_install.exe" -ms
     #c:\ff_install.exe -ms
  EOH
  action :run
end