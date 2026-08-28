Feature: The cucumber runner reaches the machine under test
  Scenario: Running a step
    Given the machine under test is reachable
    Then cucumber reports success
