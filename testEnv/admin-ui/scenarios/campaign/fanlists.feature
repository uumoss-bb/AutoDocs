@fanlist
Feature: Fanlists Campaigns

  Background:
    Given I navigate to the login page
    And I login to the app

    Scenario: Create new fanlist campaign and arrive on the new fanlist campaign page
      Given I navigate to the fanlists page
      When I create a fanlist campaign
      Then I am on the fanlist campaign page

    Scenario: Edit fanlist campaign modal saves changes
      Given I navigate to the fanlists page
      And I create a fanlist campaign
      And I return to the campaigns list page
      And I edit the 1st fanlist campaign
      And I open the fanlist campaign details modal
      And I edit the "eventIds" field to "test1, test2"
      And I save the campaign modal
      And I return to the campaigns list page
      And I edit the 1st fanlist campaign
      When I re-open the fanlist campaign details modal
      Then the field "eventIds" has the value "test1, test2"

    Scenario: Editing one fanlist campaign does not affect the details of another fanlist campaign
      Given I navigate to the fanlists page
      And I create a fanlist campaign
      And I return to the campaigns list page
      And I create another fanlist campaign
      And I return to the campaigns list page
      # This pause fixes this test, there is a delay in creating campaigns
      And I pause for 1 seconds
      And I edit the 1st fanlist campaign
      And I open the fanlist campaign details modal
      And I edit the "eventIds" field to "test1,test2"
      And I save the campaign modal
      And I am on the fanlist campaign page
      And I return to the campaigns list page
      And I edit the 2nd fanlist campaign
      When I open the fanlist campaign details modal
      Then the field "eventIds" has the value ""

    Scenario: Verify user can successfully schedule an export
      Given I navigate to the fanlists page
      When I create a fanlist campaign
      Then I am on the fanlist campaign page
      When I upload the fanlist file
      Then I see the success message "fanlistUploaded"
      And the fanlist upload succeeded
      When I click export data
      And the fanlist export download button is visible
