#
# Cookbook Name:: automate_sublimetext2
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

powershell_script "Download Sublime Text 2" do
  cwd Chef::Config[:file_cache_path]
  environment({'chefc' => Chef::Config[:file_cache_path]})
  code <<-EOH
    #(new-object System.Net.WebClient).Downloadfile("http://dl.google.com/chrome/win/567252063DA8CB4B/29.0.1516.3_chrome_installer.exe","gc_install.exe")
    #(new-object System.Net.WebClient).Downloadfile('http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20Setup.exe',"sublimetext2.exe")
    (new-object System.Net.WebClient).Downloadfile('http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.zip',"sublime2.zip")
    (new-object System.Net.WebClient).Downloadfile('http://www.7-zip.org/a/7z920-x64.msi',"7z.msi")

  EOH
  action :run
end

windows_package "Install 7zip" do
  source "#{Chef::Config[:file_cache_path]}\\7z.msi"
  action :install
end

batch "Install Sublime zip" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    "C:\\Program Files\\7-zip\\7z.exe" x sublime2.zip -oC:\\sublime -r -y
  EOH
  action :run
end

powershell_script "Add Sublime Text to Path" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
Function AddTo-SystemPath {            

 Param(
  [array]$PathToAdd
  )
 $VerifiedPathsToAdd = $Null
 Foreach($Path in $PathToAdd) {            

  if($env:Path -like "*$Path*") {
   Write-Host "Currnet item in path is: $Path"
   Write-Host "$Path already exists in Path statement" }
   else { $VerifiedPathsToAdd += ";$Path"
    Write-Host "`$VerifiedPathsToAdd updated to contain: $Path"}            

  if($VerifiedPathsToAdd -ne $null) {
   Write-Host "`$VerifiedPathsToAdd contains: $verifiedPathsToAdd"
   Write-Host "Adding $Path to Path statement now..."
   [Environment]::SetEnvironmentVariable("Path",$env:Path + $VerifiedPathsToAdd,"Process")            
   [System.Environment]::SetEnvironmentVariable("PATH", $Env:Path +$VerifiedPathsToAdd , "Machine")
   }
  }
 };


  AddTo-SystemPath "C:\\sublime\\"
  EOH
end

# $chefc\sublime2.exe /silent /install

#powershell_script "Install Sublime Text 2" do
#  cwd Chef::Config[:file_cache_path]
#  environment({'chefc' => Chef::Config[:file_cache_path]})
#  code <<-EOH
#    "#{Chef::Config[:file_cache_path]}\\sublime2.exe" /silent
#  EOH
#  action :run
#end