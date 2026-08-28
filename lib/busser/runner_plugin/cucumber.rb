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

require "rbconfig" unless defined?(RbConfig)
require "shellwords" unless defined?(Shellwords)

require "busser/runner_plugin"

module Busser
  # Namespace Busser uses for its runner plugins.
  module RunnerPlugin
    # A Busser runner for Cucumber
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    #
    class Cucumber < Busser::RunnerPlugin::Base
      # Installs Cucumber and bundler onto the machine under test. Runs once,
      # when Busser installs this plugin.
      postinstall do
        install_gem("cucumber", ">= 11.1")
        install_gem("bundler")
      end

      # Runs the suite's features.
      #
      # Everything happens with the suite directory as the working directory,
      # so a Gemfile or setup recipe placed there is found without a path.
      #
      # @return [void]
      def test
        Dir.chdir(cuke_path) do
          bundle_install
          chef_apply
          run_ruby_script!(self.class.runner_command(runner, cuke_path))
        end
      end

      # Builds the command that runs the suite's features.
      #
      # Both paths are quoted: the suite path is rooted at BUSSER_ROOT, which
      # the caller chooses, so an unquoted path containing a space would be
      # split by the shell.
      #
      # @param runner [String, Pathname] path to the runner script
      # @param suite [String, Pathname] the suite directory holding the features
      # @return [String] the command to run
      def self.runner_command(runner, suite)
        "#{Shellwords.escape(runner.to_s)} #{Shellwords.escape(suite.to_s)}"
      end

      # Builds the chef-apply command for a suite's setup recipe.
      #
      # @param setup_file [String, Pathname] path to the setup recipe
      # @return [String] the command to run
      def self.chef_apply_command(setup_file)
        "/opt/chef/bin/chef-apply #{Shellwords.escape(setup_file.to_s)}"
      end

      # Builds the bundle install command for a suite's own Gemfile.
      #
      # bundler is invoked through the Ruby running Busser rather than whatever
      # `bundle` is on PATH, since on a machine with several Rubies those
      # differ and the suite's gems would land where the runner cannot see them.
      #
      # The --local attempt is a speed optimisation: it finishes immediately
      # when the gems are already present and fails when it would need the
      # network, so the second attempt is the fallback.
      #
      # @param gemfile [String, Pathname] path to the suite's Gemfile
      # @return [String] the command to run
      def self.bundle_install_command(gemfile)
        bundle = [
          Shellwords.escape(File.join(RbConfig::CONFIG["bindir"], "ruby")),
          Shellwords.escape(File.join(Gem.bindir, "bundle")),
          "install", "--gemfile", Shellwords.escape(gemfile.to_s)
        ].join(" ")

        "#{bundle} --local || #{bundle}"
      end

      private

      # Applies the suite's setup recipe, if it has one, to put the machine
      # into a known state before the features run.
      #
      # @raise [RuntimeError] if a setup recipe is present but chef-apply is
      #   not installed, since silently skipping it would run the features
      #   against an unprepared machine
      # @return [nil] if the suite has no setup recipe
      def chef_apply
        return nil unless File.exist?(setup_file)

        unless File.exist?("/opt/chef/bin/chef-apply")
          raise("You have a chef setup file at #{setup_file}, but " \
               "/opt/chef/bin/chef-apply does not exist")
        end
        run(self.class.chef_apply_command(setup_file))
      end

      # Installs the suite's own gems, if it ships a Gemfile.
      #
      # @return [nil] if the suite has no Gemfile
      def bundle_install
        gemfile_path = File.join(cuke_path, "Gemfile")
        return nil unless File.exist?(gemfile_path)

        # Bundle install local completes quickly if the gems are already found
        # locally it fails if it needs to talk to the internet. The || below is
        # the fallback to the internet-enabled version. It's a speed
        # optimization.
        banner("Bundle Installing..")
        ENV["PATH"] = [
          ENV["PATH"], Gem.bindir, RbConfig::CONFIG["bindir"]
        ].join(File::PATH_SEPARATOR)
        run(self.class.bundle_install_command(gemfile_path))
      end

      # @return [String] absolute path to the runner script that boots
      #   Cucumber's CLI inside the suite
      def runner
        File.expand_path(File.join(File.dirname(__FILE__),
          "..",
          "cucumber",
          "runner.rb"))
      end

      # @return [String] path the suite's optional Chef setup recipe would
      #   occupy, whether or not it exists
      def setup_file
        File.join(cuke_path, "setup-recipe.rb")
      end

      # @return [String] the suite directory holding this plugin's features
      def cuke_path
        suite_path("cucumber").to_s
      end
    end
  end
end
