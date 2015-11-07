Feature:
  As an admin
  I should be able to access the admin page
  Such that I an see what administrative features exist

  Scenario: Admin user views the admin page
    Given I am logged in as an "admin" user
    When I am on the "admin" page
    Then I should see "Administrator Page"
    And i should see "Manage User Roles"

  Scenario Outline: Non-admin user views admin pages
    Given I am logged in as an authenticated user
    When I go to the "<admin_page>" page
    Then I should not see "Admin"
    And I should see "You are not authorized to view that page."

    Examples:
      | admin_page  |
      | admin       |
      | admin/roles |
