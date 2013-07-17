require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('juju', '0.1.0') do |p|
  p.description    = "Get the jobs feed using JuJu API."
  p.url            = "https://github.com/startdatelabs/juju"
  p.author         = "Elena Burachevskaya"
  p.email          = "elena.burachevskaya@startdatelabs.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
  
