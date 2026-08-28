# busser-cucumber

[![Gem Version](https://badge.fury.io/rb/busser-cucumber.svg)](https://badge.fury.io/rb/busser-cucumber)

A [Busser](https://github.com/test-kitchen/busser) runner plugin that runs
[Cucumber](https://cucumber.io) features as integration tests.

Busser installs Cucumber on the machine under test during postinstall, then runs
the suite's `cucumber` directory against it. Because the features run on the
machine itself rather than over SSH, they can assert on local files, services
and commands directly.

## Status

This software project is no longer under active development as it has no active
maintainers. The software may continue to work for some or all use cases, but
issues filed in GitHub will most likely not be triaged. If a new maintainer is
interested in working on this project please come chat with us in #test-kitchen
on Chef Community Slack.

## Requirements

Ruby 3.2 or newer, and busser 0.9.0 or newer.

## Installation

Busser installs the plugin for you when Test Kitchen runs the suite, so there is
usually nothing to do. To install it by hand:

```bash
busser plugin install busser-cucumber
```

## Usage

Put your features in the `cucumber` directory of a suite, with step definitions
beside them:

```text
test
`-- integration
    `-- default              # suite name
        `-- cucumber
            |-- Gemfile              # optional
            |-- setup-recipe.rb      # optional
            |-- something.feature
            `-- step_definitions
                `-- steps.rb
```

The suite directory is passed to Cucumber as both the features path and the
`--require` path, so every `.rb` file under it is loaded as glue. Step
definitions can sit in `step_definitions/` or anywhere else in the tree.

### Extra gems

If a `Gemfile` is present in the suite directory, it is `bundle install`ed
before the run. Use it when your steps need more than Cucumber itself:

```ruby
source "https://rubygems.org"

gem "cucumber"
gem "aruba"
gem "rest-client"
```

The install is attempted with `--local` first and falls back to the network, so
gems already present on the machine do not cost a download.

### Chef setup

If a `setup-recipe.rb` is present in the suite directory, it is applied with
`chef-apply` before the features run, which is a convenient way to put the
machine into a known state. This requires `/opt/chef/bin/chef-apply` to exist on
the machine; the run fails with a clear error if the file is there and Chef is
not.

## Using it with Test Kitchen

This is how most people run it, and it needs no Busser commands of your own.
Select the verifier in `kitchen.yml`:

```yaml
verifier:
  name: busser

suites:
  - name: default
```

Then put your tests in a `cucumber` directory inside the suite:

```text
test/integration/default/cucumber/something.feature
```

`kitchen verify` installs Busser and this plugin on the instance and runs them.
The directory name is what selects this plugin -- there is nothing else to
configure.

## When nothing runs

If the suite files do not match what this plugin looks for, the run prints one
line and **exits `0`**:

```text
-----> Running cucumber test suite
```

No tests ran, and nothing said so. Work through these in order:

1. **Is the directory named `cucumber`?** That name alone selects this plugin.
   `cucumbers/`, `tests/` or anything else is not picked up.
2. **Do the filenames match?** Cucumber takes `*.feature` files, with step
   definitions in any `.rb` file under the suite -- `smoke.txt` is *not*
   picked up.
3. **Is the plugin installed?** `busser plugin list` shows what is available.
4. **Is `BUSSER_ROOT` what you think?** `busser suite path` prints where suites
   are actually being looked for.

## Contributing

Bug reports and pull requests are welcome. See
[CONTRIBUTING.md](CONTRIBUTING.md) for how to set up the project, run the test
suite, and format your commits.

## License

Apache License 2.0. See [LICENSE.txt](LICENSE.txt).

Originally created by [Jonathan Hartman](https://github.com/RoboticCheese),
based on work by [Adam Jacob](https://github.com/adamhjk) on
[busser-rspec](https://github.com/test-kitchen/busser-rspec), in turn based on
[Daisuke Higuchi](https://github.com/cl-lab-k)'s
[busser-serverspec](https://github.com/test-kitchen/busser-serverspec).
