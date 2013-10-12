require 'bundler/gem_tasks'
require 'cane/rake_task'
require 'rubocop/rake_task'
require 'cucumber/rake/task'

Cane::RakeTask.new

desc 'Display LOC stats'
task :loc do
  puts "\n## LOC stats"
  Kernel.system 'countloc -r .'
end

Rubocop::RakeTask.new

Cucumber::Rake::Task.new

task 'default' => [:cane, :loc, :rubocop, :cucumber]

# vim: ai et ts=2 sts=2 sw=2 ft=ruby
