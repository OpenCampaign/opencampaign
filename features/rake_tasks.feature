Feature:
  As a developer
  I should be able to test my automated tasks
  Such that I can know my params are proper and my tasks run.

  Scenario: Run the uname rake task
    When I successfully run `bundle exec rake uname`
    Then the output should contain "uanme -a: "
    And the exit status should be 0
