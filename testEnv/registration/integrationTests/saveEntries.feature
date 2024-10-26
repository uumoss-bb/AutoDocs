@saveEntries
Feature: Process and save mongo entries for artist sign up registration
   As a developer
   I want to ensure that registration entries are saved correctly
   and return proper result count

  Scenario Outline: Filter and save all valid user artist sign-up entries as mongo entry documents
    Given I create <userCount> users
    And I put items in the dynamodb table fanIdentityTable with the userAccountFanscores inputs
    And I write to the campaigns collection with the generatedCampaign input
    And I write to the markets collection with the generatedCampaignMarket input
    And I put items in the dynamodb table demandTable with the entryRecords inputs
    When I invoke the saveEntries worker with the <workerInputType> input
    Then the result matches the <resultType> result
    And I pause for 3 seconds for account scores
    And I query the entries collection with the campaignEntries input
    And the number of items in the result is <resultCount>
    And each of the results matches the savedEntry schema
    Then I get items from the dynamodb table demandTable with the entryRecordsQuery inputs
    And the results don't include the "needsReplication" prop

    Examples:
      | userCount | workerInputType          | resultType                    | resultCount  |
      |    2      | artistSignUpUserEntries  | saveEntrySuccessResult        |    2         |
      |    2      | duplicateUserEntries     | duplicatedEntrySuccessResult  |    2         |
