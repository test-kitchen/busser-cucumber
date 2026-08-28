require_relative "../../spec_helper"

require "rbconfig"
require "shellwords"
require "busser/runner_plugin/cucumber"

describe Busser::RunnerPlugin::Cucumber do
  describe ".runner_command" do
    it "runs the runner against the suite" do
      cmd = Busser::RunnerPlugin::Cucumber.runner_command("/gems/runner.rb",
        "/opt/busser/suites/cucumber")

      _(Shellwords.split(cmd)).must_equal ["/gems/runner.rb", "/opt/busser/suites/cucumber"]
    end

    # BUSSER_ROOT is chosen by the caller. Unquoted, a space split the path and
    # cucumber was handed a fragment it would treat as a features path.
    it "quotes a suite path containing spaces" do
      cmd = Busser::RunnerPlugin::Cucumber.runner_command("/a/runner.rb",
        "/tmp/my tests/cucumber")

      _(Shellwords.split(cmd)).must_equal ["/a/runner.rb", "/tmp/my tests/cucumber"]
    end
  end

  describe ".chef_apply_command" do
    it "applies the setup recipe with chef-apply" do
      cmd = Busser::RunnerPlugin::Cucumber.chef_apply_command("/suite/setup-recipe.rb")

      _(Shellwords.split(cmd))
        .must_equal ["/opt/chef/bin/chef-apply", "/suite/setup-recipe.rb"]
    end

    it "quotes a path containing spaces" do
      cmd = Busser::RunnerPlugin::Cucumber.chef_apply_command("/tmp/my tests/setup-recipe.rb")

      _(Shellwords.split(cmd).last).must_equal "/tmp/my tests/setup-recipe.rb"
    end
  end

  describe ".bundle_install_command" do
    let(:cmd) { Busser::RunnerPlugin::Cucumber.bundle_install_command("/suite/Gemfile") }

    it "invokes bundler through the running Ruby rather than PATH" do
      first, second = Shellwords.split(cmd).first(2)

      _(first).must_equal File.join(RbConfig::CONFIG["bindir"], "ruby")
      _(second).must_equal File.join(Gem.bindir, "bundle")
    end

    it "names the suite's Gemfile explicitly" do
      _(Shellwords.split(cmd)).must_include "/suite/Gemfile"
    end

    it "falls back from the local attempt to a networked one" do
      _(cmd).must_include "--local || "
      _(cmd.scan("--gemfile").length).must_equal 2
    end

    it "quotes a Gemfile path containing spaces" do
      cmd = Busser::RunnerPlugin::Cucumber.bundle_install_command("/tmp/my tests/Gemfile")

      _(Shellwords.split(cmd.split(" || ").first)).must_include "/tmp/my tests/Gemfile"
    end
  end
end
