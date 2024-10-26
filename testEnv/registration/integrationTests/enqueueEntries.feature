@enqueueEntries
Feature: Process and enqueue entries for artist sign up registration
   As a developer
   I want to ensure that registration entries are sent to queue correctly
   and return proper result count

  Scenario Outline: Filter and enqueue all valid user artist sign-up entries
    Given I create <userCount> users
    When I invoke the enqueueEntries worker with the <workerInputType> input
    Then the result matches the <resultType> result

    Examples:
      | userCount | workerInputType                 | resultType                    |
      |    2      | enqueueEntriesInput             | enqueueEntrySuccessResult     |
      |    2      | duplicateEnqueueEntriesInput    | duplicatedEntryEnqueueResult  |
      |    4      | toBeFilteredEnqueueEntriesInput | filteredEntryEnqueueResult    |
