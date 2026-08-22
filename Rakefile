# Encoding: UTF-8

require "bundler/setup"
require "cookstyle/chefstyle"
require "rubocop/rake_task"
require "cucumber/rake/task"

RuboCop::RakeTask.new

Cucumber::Rake::Task.new

desc "Run all test suites"
task test: [:cucumber]

task "default" => %i{rubocop cucumber}
