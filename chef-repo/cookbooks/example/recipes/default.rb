#
# Cookbook Name:: example
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

powershell_script "Echo World" do
  code <<-EOH
    echo "Hello World!"
  EOH
end