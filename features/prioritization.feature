Feature:
  As a user
  I should be aware of the application's priority status
  Such that I an be aware of critical alerts.

  Scenario: User is on the home page
    When I go to the "home" page
    Then I should see "Priority: "
