begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec).exclude_pattern="spec/**/process_spec.rb"
rescue LoadError
end

task :default => [:spec]
