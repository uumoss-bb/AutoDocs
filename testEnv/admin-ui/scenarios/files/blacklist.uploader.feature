@blacklist
Feature: Blacklist Uploader

  Background:
    Given I navigate to the login page
    And I login to the app

  Scenario: Uploading blacklist file returns success alert
    Given I navigate to the blacklist upload page
    When I upload the blacklist file
    Then I see the success message "blacklistUploaded"
