#!/usr/bin/env ruby
# Encoding: UTF-8
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

require 'busser/runner_plugin'

module Busser
  module RunnerPlugin
    # A Busser runner for Cucumber
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    #
    class Cucumber < Busser::RunnerPlugin::Base
      postinstall do
        install_gem('cucumber')
        install_gem('bundler')
      end

      def test
        Dir.chdir(cuke_path) do
          bundle_install
          chef_apply
          run_ruby_script!("#{runner} #{cuke_path}")
        end
      end

      private

      def chef_apply
        return nil unless File.exist?(setup_file)
        unless File.exist?('/opt/chef/bin/chef-apply')
          fail("You have a chef setup file at #{setup_file}, but " \
               '/opt/chef/bin/chef-apply does not if exist')
        end
        run("/opt/chef/bin/chef-apply #{setup_file}")
      end

      def bundle_install
        return nil unless File.exist?(File.join(cuke_path, 'Gemfile'))
        # Bundle install local completes quickly if the gems are already found
        # locally. It fails if it needs to talk to the internet. The || below
        # is the fallback to the Internet-enabled version. It's a speed
        # optimization.
        run("PATH=#{ENV['PATH']}:#{Gem.bindir}; " \
            'bundle install --local || bundle install')
      end

      def runner
        File.expand_path(File.join(File.dirname(__FILE__),
                                   '..',
                                   'cucumber',
                                   'runner.rb'))
      end

      def setup_file
        File.join(cuke_path, 'setup-recipe.rb')
      end

      def cuke_path
        suite_path('cucumber').to_s
      end
    end
  end
end
