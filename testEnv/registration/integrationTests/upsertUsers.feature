@upsertUsers @deleteUsersByGlobalUserId
Feature: Upsert Users
  As a developer
  I want to check that I can properly upsert a batch of users 
  from sqs user info queue

  Scenario: Properly upserts users via user-service
    When I invoke the upsertUsers worker with the usersToUpsert input
    Then the result matches the usersUpserted result
    And I query the users collection with the upsertedUsersQuery input
    And the number of items in the result is 4
    And each of the results matches the savedUser schema

