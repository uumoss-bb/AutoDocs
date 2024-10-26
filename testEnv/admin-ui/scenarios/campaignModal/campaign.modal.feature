@campaign-modal
Feature: Content Page

Background:
  Given I navigate to the login page
  And I login to the app

  Scenario: Clicking edit campaign lands the user on the Campaign Modal
    When I navigate to the campaign modal
    Then I am on the registration campaign modal

  Scenario: I can close out of the campaign form
    Given I navigate to the campaign modal
    When I close the campaign modal
    Then I am on the landing page

  Scenario: Filling out the campaign form lands the user on the campaign page
    When I create a registration campaign
    Then I am on the registration campaign page

  Scenario: I see an error when I send a duplicate campaign name
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I edit the "name" field to "campaign_error_test"
    When I save the campaign modal
    Then I see the error message "campaignExists" on field name

  Scenario: I see an error when I send a duplicate campaign domain
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I edit the "domain" field to "campaign_error_test"
    When I save the campaign modal
    Then I see the error message "campaignExists" on field domain

  @campaign-modal-presaleWindowDates
  Scenario: The user sees the category id and presaleWindowDates they saved when reloading the campaign modal
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I fill out the presale info
    And I save the campaign modal
    When I open the registration campaign details modal
    Then the field "categoryId" has the value matching "categoryId"
    And the field "date.presaleWindowStart" has the value matching "presaleWindowStartDate"
    And the field "date.presaleWindowEnd" has the value matching "presaleWindowEndDate"

  @campaign-modal-clear-categoryId-and-presaleDates
  Scenario: The user can clear categoryId and presale dates
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I fill out the presale info
    And I save the campaign modal
    And I open the registration campaign details modal
    And I clear the "categoryId" field
    And I clear the "date.presaleWindowStart" field
    And I clear the "date.presaleWindowEnd" field
    And I save the campaign modal
    When I open the registration campaign details modal
    Then the field "categoryId" has the value ""
    And the field "date.presaleWindowStart" has the value ""
    And the field "date.presaleWindowEnd" has the value ""

  @campaign-modal-campaignWindowDates
  Scenario: The user sees the campaignWindowDates they saved when reloading the campaign modal
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I fill out the presale info
    And I save the campaign modal
    When I open the registration campaign details modal
    Then the field "date.open" has the value matching "campaignStartDate"
    And the field "date.close" has the value matching "campaignEndDate"

  @campaign-modal-gate-inviteOnly
  Scenario: The user sees the campaign inviteOnly gate type they saved when reloading the campaign modal
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I check the campaign gate
    And I edit the "options.gate" field to "inviteOnly"
    And I save the campaign modal
    When I open the registration campaign details modal
    Then the field "options.gate" has the value "inviteOnly"
    And I do not see the field "options.gate.inviteOnly"

  @campaign-modal-gate-card @campaign-modal-gate-linkedAccount
  Scenario Outline: The user sees the campaign gate type with option they saved when reloading the campaign modal
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I check the campaign gate
    And I edit the "options.gate" field to "<gateType>"
    And I edit the "options.gate.<gateType>" field to "<gateTypeOption>"
    And I save the campaign modal
    When I open the registration campaign details modal
    Then the field "options.gate" has the value "<gateType>"
    And the field "options.gate.<gateType>" has the value "<gateTypeOption>"

    Examples:
      | gateType       | gateTypeOption |
      | card           | AMEX           |
      | card           | CITI           |
      | card           | CAPITALONE     |
      | linkedAccount  | VERIZON        |
      | linkedAccount  | CITI           |


  @campaign-modal-linkable-attr
  Scenario Outline: The user sees the correct linkable attributes saved when reloading the campaign modal
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I check the linkable attributes checkbox
    And I edit the "linkable-attr-select" select field to "<linkableAttrType>"
    When I click the add attribute button
    Then the "<linkableAttrType>" linkable attribute chip is visible
    And I save the campaign modal
    And I open the registration campaign details modal
    And the "<linkableAttrType>" linkable attribute chip is visible
    And I check the linkable attributes checkbox
    And I save the campaign modal
    And I open the registration campaign details modal
    And the "<linkableAttrType>" linkable attribute chip is not visible

    Examples:
      | linkableAttrType |
      | card_amex        |
      | card_citi        |
      | card_capitalone  |

  @campaign-modal-muliple-linkable-attr
  Scenario: User can add multiple linkable attributes via campaign modal
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I check the linkable attributes checkbox
    And I edit the "linkable-attr-select" select field to "card_amex"
    And I click the add attribute button
    And I edit the "linkable-attr-select" select field to "card_citi"
    And I click the add attribute button
    And I save the campaign modal
    When I open the registration campaign details modal
    Then the "card_citi" linkable attribute chip is visible
    And the "card_amex" linkable attribute chip is visible

  @campaign-modal-linkable-attr-close-chip
  Scenario: User can close a linkable attribute chip
    Given I navigate to the campaign modal
    And I fill out the registration modal
    And I check the linkable attributes checkbox
    And I edit the "linkable-attr-select" select field to "card_amex"
    And I click the add attribute button
    And the "card_amex" linkable attribute chip is visible
    When I close the "card_amex" linkable attribute chip
    Then the "card_amex" linkable attribute chip is not visible

  @fanlist-campaign-modal-select
  Scenario Outline: User can select and save scoring type and identifier options in fanlist campaign modal
    Given I navigate to the fanlists page
    And I navigate to the campaign modal
    And I fill out the fanlist modal
    And I edit the "scoring" field to "<scoringType>"
    And I edit the "identifier" field to "<identifierOption>"
    And I save the campaign modal
    When I open the registration campaign details modal
    Then the field "scoring" has the value "<scoringType>"
    And the field "identifier" has the value "<identifierOption>"

    Examples:
      | scoringType | identifierOption |
      | raw         | memberId         |
      | raw         | email            |
      | xnum        | memberId         |
      | xnum        | email            |
