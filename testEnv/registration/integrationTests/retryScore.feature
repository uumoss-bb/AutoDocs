@retryScore
Feature: Retry Score for Users
  As a developer
  I want to verify that I can successfully retry fetching the scores for a batch of entries from the SQS retry score queue.

  Scenario: Process users that had missing scores from the retry score queue and fetch their score
    Given I create 2 users
    And I write to the campaigns collection with the retryScoreNewCampaign input
    And I write to the entries collection with the entriesToRetryScore input
    And I put items in the dynamodb table fanIdentityTable with the retryScoreUserAccountFanscores inputs
    And I put items in the dynamodb table fanIdentityTable with the retryScoreUserAccountPhonescores inputs
    When I invoke the retryScore worker with the usersToRetryScoreFor input
    Then the result matches the usersScoreFetched result
