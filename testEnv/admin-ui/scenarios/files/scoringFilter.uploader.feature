@scoring-filter-list
Feature: Scoring Filter List Uploads

  Background:
    Given I navigate to the login page
    And I login to the app
    And I create a registration campaign
    And I switch to the scoring app

  @filter-list-success
  Scenario: Scoring filter list is uploaded successfully
    And I navigate to the scoring filter page
    And I fill out the filterList modal
    And I upload the scoringFilter.csv filterList file
    Then the filterList upload succeeded

  @filter-list-error
  Scenario: Scoring filter upload errors when list is empty
    And I navigate to the scoring filter page
    And I fill out the filterList modal
    And I upload the empty.csv filterList file
    Then I see the "The file provided is empty" toast message
