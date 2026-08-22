# Encoding: UTF-8

require "bundler/setup"
require "cookstyle/chefstyle"
require "rubocop/rake_task"
require "cucumber/rake/task"

desc "Display LOC stats"
task :loc do
  puts "\n## LOC stats"
  Kernel.system "countloc -r ."
end

RuboCop::RakeTask.new

Cucumber::Rake::Task.new

desc "Run all test suites"
task test: [:cucumber]

task "default" => %i{loc rubocop cucumber}
