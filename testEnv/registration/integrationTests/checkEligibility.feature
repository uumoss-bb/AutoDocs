@checkEligibility
Feature: Check eligibility when campaign is gated
  As a developer
  I want to check eligibility on entry submission when a campaign is gated

  @eligibleEntry
  Scenario: Returns eligible on valid entry submission
    Given I update the redis cache with the nonGatedCampaign input
    And I write to the users collection with the newUser input
    And I write to the entries collection with the newEntry input
    When I invoke the checkEligibility worker with the entryRegistration input
    Then the result matches the eligibleEntry result
  
  @ineligibleEntry
  Scenario Outline: Returns ineligible on ineligible entry submission
    Given I update the redis cache with the gatedCampaign input
    And I write to the campaigns collection with the cachedCampaign input
    When I invoke the checkEligibility worker with the <workerInput> input
    Then the result matches the <eligibility> result
  
  Examples:
    | campaign          | workerInput              | eligibility            |
    | gatedCampaign     | entryRegistration        | ineligibleNoCardEntry  |
    | nonGatedCampaign  | invalidEntryRegistration | ineligibleInvalidEntry |

  @campaignNotFound
  Scenario: Returns ineligible if campaign is not found
    When I invoke the checkEligibility worker with the invalidCampaign input
    Then the result matches the ineligibleNotFound result

  @invalidCampaign
  Scenario Outline: Returns ineligible if campaign is not open
    Given I update the redis cache with the <campaign> input
    And I write to the campaigns collection with the cachedCampaign input
    When I invoke the checkEligibility worker with the <registration> input
    Then the result matches the <ineligible> result

    Examples:
      | campaign         | registration       | ineligible       |
      | closedCampaign   | entryRegistration  | closedCampaign   |
      | draftCampaign    | entryRegistration  | invalidCampaign  |
