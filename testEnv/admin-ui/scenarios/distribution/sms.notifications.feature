@sms-notifications-modal
Feature: SMS Notifications

Background:
  Given I navigate to the login page
  And I login to the app

  Scenario: Generate code is disabled when campaign has no categoryId
    Given I create a registration campaign
    And I switch to the distribution app
    When I open the sms modal
    Then the generate code checkbox is disabled

  Scenario: Filling out the sms form and uploading sms file returns timestamp of file uploaded to s3
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I fill out the presale info
    And I save the campaign modal
    And I switch to the distribution app
    When I open the sms modal
    And I fill out the sms modal
    And I upload the wave file
    Then the wave upload succeeded

  Scenario: Waves can be canceled
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I fill out the presale info
    And I save the campaign modal
    And I switch to the distribution app
    And I open the sms modal
    And I fill out the sms modal
    And I upload the wave file
    And the wave upload succeeded
    When I cancel the wave
    Then the waves table is empty

  @sms-non-campaign
  Scenario: I navigate to the sms notifications page
    When I navigate to the sms notifications page
    Then I am on the sms notifications page
