require_relative "../../spec_helper"

require "tmpdir"
require "busser/cucumber/cli_args"

describe Busser::Cucumber::CliArgs do
  describe ".build" do
    # Regression guard. Cucumber's require_dirs falls back to its default
    # features path when no --require is given -- it ignores the paths on the
    # command line -- so a busser suite directory got no step definitions
    # loaded and every step came back undefined.
    it "adds a --require for a directory argument" do
      Dir.mktmpdir do |dir|
        _(Busser::Cucumber::CliArgs.build([dir])).must_equal ["--require", dir, dir]
      end
    end

    it "does not add a --require for a file argument" do
      Dir.mktmpdir do |dir|
        file = File.join(dir, "a.feature")
        File.write(file, "")
        _(Busser::Cucumber::CliArgs.build([file])).must_equal [file]
      end
    end

    it "does not add a --require for a path that does not exist" do
      _(Busser::Cucumber::CliArgs.build(["/nope/missing"])).must_equal ["/nope/missing"]
    end

    it "leaves flags alone" do
      Dir.mktmpdir do |dir|
        args = Busser::Cucumber::CliArgs.build([dir, "--format", "progress"])
        _(args).must_equal ["--require", dir, dir, "--format", "progress"]
      end
    end

    it "handles several directories" do
      Dir.mktmpdir do |a|
        Dir.mktmpdir do |b|
          _(Busser::Cucumber::CliArgs.build([a, b]))
            .must_equal ["--require", a, "--require", b, a, b]
        end
      end
    end

    it "returns an empty list unchanged" do
      _(Busser::Cucumber::CliArgs.build([])).must_equal []
    end

    it "does not mutate the array it is given" do
      argv = ["--format", "progress"]
      Busser::Cucumber::CliArgs.build(argv)
      _(argv).must_equal ["--format", "progress"]
    end
  end
end
