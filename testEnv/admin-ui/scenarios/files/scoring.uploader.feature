@scoring
Feature: Scoring Page

  Background:
    Given I navigate to the login page
    And I login to the app
    And I create a registration campaign

  Scenario: Clicking kick-off scoring shows confirmation prompt
    Given I switch to the scoring app
    When I click the scoring kick-off button
    Then the scoring confirmation prompt is visible

  Scenario: Uploading scoring file returns timestamp of file uploaded to s3
    Given I switch to the scoring app
    When I upload the scoring file
    Then I see the success message "scoringUploaded"
    And the scoring upload succeeded

  Scenario: Ability to download most recent scored file from scoring page
    Given I switch to the scoring app
    And I upload the scoring file
    When I click the scoring export button
    Then the scoring download button is visible
