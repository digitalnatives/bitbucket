$LOAD_PATH << File.expand_path('../lib', __FILE__)

# http://erniemiller.org/2014/02/05/7-lines-every-gems-rakefile-should-have/
desc 'Start an IRB console with the gem'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'bitbucket_rest_api'
  ARGV.clear
  IRB.start
end
