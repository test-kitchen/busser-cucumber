# Changelog

## [0.3.0](https://github.com/test-kitchen/busser-cucumber/compare/v0.2.0...v0.3.0) (2026-08-28)


### ⚠ BREAKING CHANGES

* Ruby 3.1 and busser releases older than 0.9.0 are no longer supported.

### Features

* require Ruby 3.2 and busser 0.9, adopt release-please ([#35](https://github.com/test-kitchen/busser-cucumber/issues/35)) ([9b32b3f](https://github.com/test-kitchen/busser-cucumber/commit/9b32b3faf7b0833620946267469ce845dd5d0b3c))


### Bug Fixes

* quote paths before handing them to a shell ([#43](https://github.com/test-kitchen/busser-cucumber/issues/43)) ([eff58d9](https://github.com/test-kitchen/busser-cucumber/commit/eff58d987bc9ca39ab0c495f214c7075f76c2f0b))
* restore support for a Gemfile in the suite directory ([#37](https://github.com/test-kitchen/busser-cucumber/issues/37)) ([47385ee](https://github.com/test-kitchen/busser-cucumber/commit/47385ee514ed3ed970ff2a81fcd3955ac081fa7b))

Busser-Cucumber Gem CHANGELOG
=============================

v?.?.? (????-??-??)
-------------------

v0.2.0 (2014-10-08)
-------------------
- Add support for included `Gemfile`s
- Add support for included `setup-recipe.rb` Chef recipes

v0.1.0 (2013-10-11)
-------------------
- Initial release
