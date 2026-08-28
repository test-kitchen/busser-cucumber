#!/usr/bin/env ruby
#
# Author:: Jonathan Hartman (<j@p4nt5.com>)
#
# Copyright (C) 2013-2014, Jonathan Hartman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "bundler/setup"
require "cucumber/cli/main"

# Cucumber only auto-loads step definitions from its default features path: with
# no --require, Configuration#require_dirs ignores the paths given on the command
# line entirely. Busser hands it a suite directory, which is never named
# "features", so without naming that directory here every step in the suite comes
# back undefined.
paths = ARGV.dup
requires = paths.select { |path| File.directory?(path) }.flat_map { |dir| ["--require", dir] }

exit Cucumber::Cli::Main.new(requires + paths).execute!
