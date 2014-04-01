[![Gem Version](https://badge.fury.io/rb/busser-cucumber.png)](http://badge.fury.io/rb/busser-cucumber)
[![Build Status](https://travis-ci.org/test-kitchen/busser-cucumber.png?branch=master)](https://travis-ci.org/test-kitchen/busser-cucumber)
[![Code Climate](https://codeclimate.com/github/test-kitchen/busser-cucumber.png)](https://codeclimate.com/github/test-kitchen/busser-cucumber)
[![Dependency Status](https://gemnasium.com/test-kitchen/busser-cucumber.png)](https://gemnasium.com/test-kitchen/busser-cucumber)

# Busser::Cucumber

A Busser runner plugin for Cucumber.

## Installation

See the [Busser](https://github.com/fnichol/busser) and
[Test Kitchen](https://github.com/opscode/test-kitchen) pages for more details.

## Usage

Place test files in `[COOKBOOK]/test/integration/[SUITE]/cucumber/`

    cookbook
        -- test
            -- integration
                -- default
                    -- cucumber

When Test Kitchen runs Busser, it will automatically install this plugin on
your server under test.

In some cases, your tests may need an additional Gem installed. One possible
means of accomplishing this is to install the extra Gem(s) with something like
the following at the top level of your `env.rb` file:

    begin
      require 'rest_client'
    rescue LoadError
      require 'rubygems/dependency_installer'
      Gem::DependencyInstaller.new.install('rest_client')
      require 'rest_client'
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

- Author:: Jonathan Hartman (<j@p4nt5.com>)

Based mostly on work by [Adam Jacob](https://github.com/adamhjk) on
[busser-rspec](https://github.com/adamhjk/busser-rspec), in turn based on work
done by [Daisuke Higuchi](https://github.com/cl-lab-k) on
[busser-serverspec](https://github.com/cl-lab-k/busser-serverspec).

## License

Apache 2.0 (see [LICENSE](license.txt)).
