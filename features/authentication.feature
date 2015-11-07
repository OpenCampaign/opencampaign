Feature:
  As a user
  I should be able to be automatically logged in
  Such that unauthorized users cannot view proprietary data.

  Scenario: User logs in through provider
    When I login through the authentication provider
    Then I should be logged in

  Scenario: User logs out
    When I go to the "logout" page
    Then I should see "You have successfully signed out."
    And I should not see "Welcome, "

  Scenario: Authenticated user accesses the homepage
    Given I am logged in as an authenticated user
    When I go to the "home" page
    Then I should see "OpenCampaign"
    And I should see "Welcome, John"

  Scenario: Unauthenticated user accesses the homepage
    Given I am not logged in
    When I go to the "home" page
    Then I should see "You could not be authenticated"
    And I should see "Please verify your credentials."
