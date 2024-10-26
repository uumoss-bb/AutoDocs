@distribution
Feature: Distribution tests

  Background:
    Given I navigate to the login page
    And I login to the app
    And I create a registration campaign

  @wavePrep
  Scenario: Successfully upload market details file and trigger wave-prep process
    Given I create a new market with pantages
    And I create a new market with ubs
    And I create a new market with metlife
    And I create a new market with fivepoint
    And I switch to the scoring app
    And I upload the scoring file
    And I switch to the distribution app
    When I open the wave prep modal
    And I fill out the wave prep modal
    And I set the minimum scoring threshold to .5
    And I upload the wavePrep file
    Then I see the success message "wavePrepUploaded"
    And the wavePrep upload succeeded

  @wavePrepInvalidThreshold
  Scenario Outline: Wave prep modal displays appropriate error for invalid scoring threshold
    Given I switch to the distribution app
    And I open the wave prep modal
    And I fill out the wave prep modal
    When I set the minimum scoring threshold to <minScore>
    Then the wave prep error displays "Enter a number between 0 and 1"

    Examples:
      | minScore |
      | 2        |
      | -5       |

  @waveBuild
  Scenario: Successfully open wave build modal
    Given I switch to the distribution app
    When I click the build new wave link
    Then I see the wave build modal

  @codeCount
  Scenario Outline: Uploading the codes file updates the available codes count
    Given I switch to the distribution app
    When I upload the <codeType> file
    Then I see the success message "<codeTypeSuccessMessage>"
    And the <codeType> upload succeeded
    Examples:
      | codeType   | codeTypeSuccessMessage |
      | tmCodes    | tmCodesUploaded        |
      | nonTmCodes | nonTmCodesUploaded     |
