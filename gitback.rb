#!/usr/bin/env ruby
#gitback 0.1
#credits: Walter White, Updates: Addy Osmani, Taylor "Nekroze" Lawson
# dependencies
require "yaml"
require "open-uri"
# request github username
puts "What is your github username?"
username = gets
# feel free to comment out the option you don't wish to use.
backupDirectory = "~/git"
#repositories =
# .map{|r| %Q[#{r[:name]}] }
#FileUtils.mkdir_p #{backupDirectory}
YAML.load(open("http://github.com/api/v2/yaml/repos/show/#{username}"))['repositories'].map{|repository|
    puts "discovered repository: #{repository[:name]} ... backing up ..."
    #exec
    system "git clone git@github.com:#{username}/#{repository[:name]}.git
                                ##{backupDirectory}/#{repository[:name]}"
}
