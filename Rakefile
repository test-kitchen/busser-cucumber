# Encoding: UTF-8

require "bundler/setup"
require "cane/rake_task"
require "chefstyle"
require "rubocop/rake_task"
require "cucumber/rake/task"

Cane::RakeTask.new

desc "Display LOC stats"
task :loc do
  puts "\n## LOC stats"
  Kernel.system "countloc -r ."
end

RuboCop::RakeTask.new

Cucumber::Rake::Task.new

task "default" => %i{cane loc rubocop cucumber}
