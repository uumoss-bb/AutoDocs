@landing
Feature: Landing

Background:
Given I navigate to the login page

  Scenario: Navigate to login
    Then I am on the login page

  @login
  Scenario: Login to App
    When I login to the app
    Then I am on the landing page

  Scenario: Logging out lands the user on the login page
    Given I login to the app
    When I logout from the landing page
    Then I am on the login page

  @non-admin
  Scenario: Login with non-admin account logs user out
    Given I login to the app as a non-admin
    Then I am on the login page

  @campaign-search
  Scenario: Typing in the search input will filter campaign list
    Given I login to the app
    And I create a registration campaign
    And I return to the campaigns list page
    When I search for the campaign name
    Then I see the new campaign in the campaigns list
    And the campaign list has 1 item

  @campaign-sort
  Scenario: Switching between campaigns list tabs preserves search
    Given I login to the app
    And I search for the campaign name using "testGen_ui"
    And I sort the campaigns list by campaign name ascending
    When I navigate to the blacklist upload page
    And I navigate to the fanlists page
    And I navigate to the vf registrations page
    And I navigate to the campaign modal
    And I close the campaign modal
    And I navigate to the campaign editor
    And I return to the campaigns list page
    Then the campaigns list filter settings are preserved

  @list-type
  Scenario Outline: View list by campaign type
    Given I login to the app
    When I navigate to the <listType> page
    Then I am on the <listType> page

    Examples:
      | listType           |
      | vf registrations   |
      | fanlists           |
