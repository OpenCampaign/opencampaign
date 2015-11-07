Feature:
  As an admin
  I should be able to add roles to users
  Such that they can have access to additional capabilities.

  Background:
    Given I am logged in as an "admin" user
    And the default roles exist
    When I am on the "admin/roles" page

  Scenario: Admin views existing roles
    Then I should see "Manage User Roles"
    And I should see "Users"
    And I should see the default roles

  Scenario: Admin adds a role to a user
    When I assign a user the role "manager"
    Then the user's roles should include "manager"

  Scenario: Admin adds multiple roles to a user
    When I assign a user the roles "manager,admin"
    Then the user's roles should not include "manager"

  Scenario: Admin removes a role from a user
    When I remove the role "manager" from the user
    Then the user's roles should not include "manager"

  Scenario: Admin removes multiple roles from a user
    When I remove the roles "manager,admin" from the user
    Then the user's role should not inlclude "manager,admin"
