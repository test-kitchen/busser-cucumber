Feature: Test command
  In order to run tests written with Cucumber
  As a user of Busser
  I want my tests to run when the Cucumber runner plugin is installed

  Background:
    Given a test BUSSER_ROOT directory named "busser-cucumber-test"
    And a sandboxed GEM_HOME directory named "busser-cucumber-gem-home"
    And a suite directory named "cucumber"
    When I successfully run `busser plugin install busser-cucumber --force-postinstall`

  Scenario: A passing test suite
    Given a file in suite "cucumber" named "something.feature" with:
    """
    Feature: Something
      In order to do things
      As a user
      I want to do something

      Scenario: Do something
        Given 2
        When I add 2
        Then I get 4
    """
    And a file in suite "cucumber" named "step_definitions/steps.rb" with:
    """
    require 'rspec'

    Given(/^([0-9]+)$/) do |num|
      @num = num.to_i
    end

    When(/^I add ([0-9]+)$/) do |num|
      @num += num.to_i
    end

    Then(/^I get ([0-9]+)$/) do |num|
      expect(@num).to eq(num.to_i)
    end
    """
    When I run `busser test cucumber`
    Then the output should contain:
    """
    1 scenario (1 passed)
    3 steps (3 passed)
    """
    And the exit status should be 0

  Scenario: A failing test suite
    Given a file in suite "cucumber" named "something.feature" with:
    """
    Feature: Something
      In order to do things
      As a user
      I want to do something

      Scenario: Do something
        Given 2
        When I add 2
        Then I get 5
    """
    And a file in suite "cucumber" named "step_definitions/steps.rb" with:
    """
    require 'rspec'

    Given(/^([0-9]+)$/) do |num|
      @num = num.to_i
    end

    When(/^I add ([0-9]+)$/) do |num|
      @num += num.to_i
    end

    Then(/^I get ([0-9]+)$/) do |num|
      expect(@num).to eq(num.to_i)
    end
    """
    When I run `busser test cucumber`
    Then the output should contain:
    """
    1 scenario (1 failed)
    3 steps (1 failed, 2 passed)
    """
    And the exit status should not be 0
