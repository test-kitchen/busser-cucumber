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

module Busser
  module Cucumber
    # Builds the argument list handed to Cucumber's CLI.
    #
    # This lives apart from runner.rb because that file is a script: requiring
    # it runs Cucumber. Keeping the argument rule here lets it be tested.
    module CliArgs
      module_function

      # Cucumber only auto-loads step definitions from its default features
      # path. With no --require, Configuration#require_dirs ignores the paths
      # given on the command line entirely, so a suite directory -- which is
      # never named "features" -- gets no glue loaded and every step in it comes
      # back undefined. Naming each directory explicitly is what fixes that.
      #
      # @param argv [Array<String>] arguments as given to the runner
      # @return [Array<String>] the same arguments with a --require for each
      #   directory among them, prepended
      def build(argv)
        args = argv.to_a
        requires = args.select { |path| File.directory?(path) }
          .flat_map { |dir| ["--require", dir] }
        requires + args
      end
    end
  end
end
