@campaign-sidebar
Feature: Content Page

Background:
  Given I navigate to the login page
  And I login to the app

  Scenario: FormBuilder is disabled while not on the registration page
    Given I edit the last campaign
    Then the Form Builder button is disabled

  @cs-formBuilder-enabled
  Scenario: FormBuilder is enabled while on registration page
    And I edit the last campaign
    When I change the campaign editor to the form page
    Then the Form Builder button is enabled

  @cs-single-market
  Scenario: No market selector is present for a single market
    Given I create a registration campaign
    When I create a new market with pantages
    And I change the campaign editor to the form page
    Then I don't see any markets

  @cs-new-market
  Scenario: Editor Market Panel add new market
    Given I create a registration campaign
    And I create a new market with metlife
    When I create a new market with pantages
    And I change the campaign editor to the form page
    Then I see pantages in the market select dropdown

  @cs-edit-market
  Scenario: Editor Market Panel edit Existing market
    Given I create a registration campaign
    And I create a new market with metlife
    And I create a new market with pantages
    When I edit the market to ubs
    And I change the campaign editor to the form page
    Then I see ubs in the market select dropdown

  @cs-delete-market
  Scenario: Editor Market Panel delete and reassign Existing market
    Given I create a registration campaign
    And I create a new market with metlife
    And I create a new market with pantages
    When I delete the last market
    And I select the first market as the reassignment target
    And I confirm the deletion and reassignment
    And I change the campaign editor to the form page
    Then I don't see any markets

  @cs-drop-header-image
  Scenario: User can drop add a header through the side panel
    Given I create a registration campaign
    When I add a logo image through the sidebar
    Then I see an image on the form

  Scenario: Editing button color edits signup button
    Given I create a registration campaign
    When I edit the button color to "df42f4"
    Then I expect the button to be color "df42f4"

  Scenario: Editing text color edits form
    Given I create a registration campaign
    When I edit the text color to "12b210"
    Then I expect the text to be color "12b210"
