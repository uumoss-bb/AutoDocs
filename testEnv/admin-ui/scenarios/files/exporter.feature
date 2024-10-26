@exporter
Feature: Content Page

Background:
  Given I navigate to the login page
  And I login to the app
  And I create a registration campaign
  @ex-1
  Scenario: I land on export page
    When I switch to the exports app
    Then I am on the export page

  @export-disabled
  Scenario: Exporting disables button
    Given I create a new market with pantages
    And I switch to the exports app
    When I click export data
    Then the export button is disabled

  @export-download
  Scenario: I can download exports
    Given I create a new market with pantages
    And I switch to the exports app
    When I click export data
    Then the download button is visible

  @export-failed
  Scenario: Export button re-enables on failed export
    Given I switch to the exports app
    When I click export data
    Then the export status is FAILED
    And the export button is enabled
