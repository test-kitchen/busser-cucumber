Busser-Cucumber
===============

[![Gem Version](https://badge.fury.io/rb/busser-cucumber.png)][fury]
[![Build Status](https://img.shields.io/travis/test-kitchen/busser-cucumber.svg)][travis]
[![Code Climate](https://img.shields.io/codeclimate/github/test-kitchen/busser-cucumber.svg)][codeclimate]
[![Dependency Status](https://img.shields.io/gemnasium/test-kitchen/busser-cucumber.svg)][gemnasium]

[fury]: http://badge.fury.io/rb/busser-cucumber
[travis]: https://travis-ci.org/test-kitchen/busser-cucumber
[codeclimate]: https://codeclimate.com/github/test-kitchen/busser-cucumber
[gemnasium]: https://gemnasium.com/test-kitchen/busser-cucumber


A Busser runner plugin for Cucumber.

### Status

This software project is no longer under active development as it has no active maintainers. The software may continue to work for some or all use cases, but issues filed in GitHub will most likely not be triaged. If a new maintainer is interested in working on this project please come chat with us in #test-kitchen on Chef Community Slack.

Installation
------------

See the [Busser](https://github.com/test-kitchen/busser) and
[Test Kitchen](https://github.com/test-kitchen/test-kitchen) pages for more details.

Usage
-----

Place test files in `[COOKBOOK]/test/integration/[SUITE]/cucumber/`

    cookbook
        -- test
            -- integration
                -- default
                    -- cucumber

When Test Kitchen runs Busser, it will automatically install this plugin on
your server under test.

In some cases, your tests may require some additional setup. This plugin will
run any `Gemfile` or `setup-recipe.rb` Chef recipe included in the test file
directory. For example, if you need the `aruba` and `rest-client` gems in
addition to Cucumber itself, place a file in
`[COOKBOOK]/test/integration/[SUITE]/cucumber/Gemfile`:

    source 'https://rubygems.org'

    gem 'cucumber'
    gem 'aruba'
    gem 'rest_client'

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Ensure any changes are tested and all tests pass (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

Authors
-------

- Author:: Jonathan Hartman (<j@p4nt5.com>)

Based mostly on work by [Adam Jacob](https://github.com/adamhjk) on
[busser-rspec](https://github.com/test-kitchen/busser-rspec), in turn based on
work done by [Daisuke Higuchi](https://github.com/cl-lab-k) on
[busser-serverspec](https://github.com/test-kitchen/busser-serverspec).

License
-------

Apache 2.0 (see [LICENSE](license.txt)).
