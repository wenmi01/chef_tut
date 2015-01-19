#
# Cookbook Name:: automate_chrome
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

#This uses chocolatey to install Chrome
#powershell_script "Download Chocolatey and Install Chrome" do
#  cwd Chef::Config[:file_cache_path]
#  code <<-EOH
#    #@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
#    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
#    choco install googlechrome
#  EOH
#end



#    (new-object System.Net.WebClient).Downloadfile("https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B40569D95-7A9C-D7C3-EAF6-1035625105AE%7D%26lang%3Den%26browser%3D2%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers/update2/installers/ChromeSetup.exe", "gc_install.exe")

powershell_script "Download Chrome" do
  cwd Chef::Config[:file_cache_path]
  environment({'chefc' => Chef::Config[:file_cache_path]})
  code <<-EOH
    #(new-object System.Net.WebClient).Downloadfile("http://dl.google.com/chrome/win/567252063DA8CB4B/29.0.1516.3_chrome_installer.exe","gc_install.exe")
    (new-object System.Net.WebClient).Downloadfile('https://dl.google.com/tag/s/appguid={8A69D345-D564-463C-AFF1-A69D9E530F96}&iid={00000000-0000-0000-0000-000000000000}&lang=en&browser=3&usagestats=0&appname=Google%2520Chrome&needsadmin=prefers/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi',"gc_install.msi")
  EOH
  action :run
end

windows_package "Install Chrome" do
  source "#{Chef::Config[:file_cache_path]}\\gc_install.msi"
  action :install
end

powershell_script "Complete install chrome" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    $packageName = 'GoogleChrome'
    $fileType = 'msi'
    $silentArgs = '/quiet'
    $url = 'https://dl.google.com/tag/s/appguid={8A69D345-D564-463C-AFF1-A69D9E530F96}&iid={00000000-0000-0000-0000-000000000000}&lang=en&browser=3&usagestats=0&appname=Google%2520Chrome&needsadmin=prefers/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi'
    $version = '39.0.2171.99'
     
    function Find-CID {
      param([String]$croot, [string]$cdname, [string]$ver)
     
      if (Test-Path $croot) {
      Get-ChildItem -Force -Path $croot | foreach {
        $CurrentKey = (Get-ItemProperty -Path $_.PsPath)
        if ($CurrentKey -match $cdname -and $CurrentKey -match $ver) {
        return $CurrentKey.PsChildName
        }
          }
      }
      return $null
    }
 
    $uroot = "HKLM:\\SOFTWARE\\Google\\Update\\Clients"
    $uroot64 = "HKLM:\\SOFTWARE\\Wow6432Node\\Google\\Update\\Clients"
     
    try {
 
      $msid = Find-CID $uroot "Google Chrome binaries" "$version"
      if ($msid -eq $null) {
      # try 64bit registry
        $msid = Find-CID $uroot64 "Google Chrome binaries" "$version"
      }
      if ($msid -ne $null) {
         Write-Host "Google Chrome $version is already installed."
      } else {
        Install-ChocolateyPackage $packageName $fileType $silentArgs $url
      }
 
    } catch {
      Write-ChocolateyFailure $packageName $($_.Exception.Message)
      throw
    }
  EOH
end


#powershell_script "Install Chrome" do
#  cwd Chef::Config[:file_cache_path]
#  environment({'chefc' => Chef::Config[:file_cache_path]})
#  code <<-EOH
#    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "#{Chef::Config[:file_cache_path]}\\gc_install.exe" /silent /install
#  EOH
#  action :run
#end