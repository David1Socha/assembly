require 'rspec/core/rake_task'

task :default => :spec

desc "Run tests for Assembly Project"
Rspec::Core::RakeTask.new do |task|
  task.verbose = false
  task.rspec_opts = ['-f documentation']
end