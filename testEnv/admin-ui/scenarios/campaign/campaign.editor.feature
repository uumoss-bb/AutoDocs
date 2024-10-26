@campaign-editor
Feature: Campaign Editor

  Background:
    Given I navigate to the login page
    And I login to the app
    And I create a registration campaign

    Scenario: Verify the artist is loaded by default
      Then I expect that the artist is in the tinyMCE

    Scenario: Verify the correct forms are loaded by default
      When I change the campaign editor to the form page
      Then I expect that the form fields are loaded by default

    Scenario: Verify the correct confirmation fields are loaded by default
      When I change the campaign editor to the confirmation page
      Then I expect that the confirmation fields are loaded by default

    Scenario: Verify correct default text
      Then I expect to see the correct default text

    @linkable-attribute
    Scenario: Verify linkable attributes are loaded in form page
      Given I open the registration campaign details modal
      And I check the linkable attributes checkbox
      And I edit the "linkable-attr-select" select field to "card_amex"
      And I click the add attribute button
      And I edit the "linkable-attr-select" select field to "card_citi"
      And I click the add attribute button
      And I save the campaign details modal
      When I change the campaign editor to the confirmation page
      Then I expect that the linkable attribute fields are loaded
      And I expect to see the correct attribute linking text

    @no-images
    Scenario: Verify user cannot publish without any images
      Given I switch the status to open
      When I click save & publish
      Then I get locale error "noImages" with locale en-US

    @no-logo
    Scenario: Verify user cannot publish while status is open without logo
      Given I add a background image through the sidebar
      When I switch the status to open
      And I click save & publish
      Then I get locale error "missingImage" with locale en-US and type logo

    @no-bg-image
    Scenario: Verify user cannot publish while status is open without background
      Given I add a logo image through the sidebar
      When I switch the status to open
      And I click save & publish
      Then I get locale error "missingImage" with locale en-US and type background
