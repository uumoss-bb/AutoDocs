@campaign-locales
Feature: Content Page

Background:
  Given I navigate to the login page
  And I login to the app

  Scenario Outline: I can publish an OPEN campaign with fr-CA, es-MX, and en-US locales
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I check the <languageCode> locale
    And I save the campaign modal
    When I add both images through the sidebar for the locale "en_US"
    And I switch the editor locale to <languageCode>
    And I add both images through the sidebar for the locale <languageCode>
    And I switch the status to open
    And I click save & publish
    Then the campaign status is "OPEN"

    Examples:
      | languageCode    |
      | "fr_CA"         |
      | "es_MX"         |

  @campaign-french-locale
  Scenario Outline: I add fr-CA to an existing en-US campaign
    Given I create a registration campaign
    And I open the registration campaign details modal
    And I check the "fr_CA" locale
    And I save the campaign modal
    When I switch the editor locale to "fr_CA"
    Then the fr_CA content matches the default for locale fr_CA
    And I change the campaign editor to the form page
    And the preference label email matches the default for locale fr_CA

  Scenario: Adding a locale with no default content uses en_US defaults as a fallback
    Given I create a registration campaign
    And I open the registration campaign details modal
    And I check the "en_CA" locale
    And I save the campaign modal
    When I switch the editor locale to "en_CA"
    Then the en_CA content matches the default for locale en_US
    And I change the campaign editor to the form page
    And the preference label email matches the default for locale en_US

  @campaign-open-multi-locale
  Scenario: I can add fr-CA to an en-US campaign and save the status as OPEN
    Given I create a registration campaign
    And I open the registration campaign details modal
    When I check the "fr_CA" locale
    And I save the campaign modal
    And I add both images through the sidebar for the locale "en_US"
    And I switch the editor locale to "fr_CA"
    And I add both images through the sidebar for the locale "fr_CA"
    And I switch the status to open
    And I click save & publish
    Then the campaign status is "OPEN"
