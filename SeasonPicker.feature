Feature: Season Picker	

  Scenario: Anon - Tap on Back button
    Given I am an auth user
    When I am on Shows screen
    And I select a show
    Then I see the show detail screen page
    And I tap on back arrow button
    And I see shows list screen

 @P1
 Scenario: Season Selector - First time view
    Given I am an auth user
    When I search and select a show having multiple season
    And the 'episodes' tab is selected
    Then I see the latest season selected in the season dropdown

@P1
 Scenario: Season Selector - Selecting a season
    Given I am an auth user
    When I search and select a show having multiple season
    And I tap on season dropdown
    And I see season panel slides up
    Then I see seasons are in default hierarchy order of newest to oldest

 Scenario: Season Selector - Selected season
    Given I am an auth user
    When I search and select a show having multiple season
    And I tap on season dropdown
    And I tap on another season
    Then I see selected season is displayed in the selector

 @P1
 Scenario: Selecting episode tab
    Given I am an auth user
    When I am on show details page
    And the 'episodes' tab is selected
    Then I see episode metadata for episode art , title , number and duration

 @P1
 Scenario: Details tab
    Given I am an auth user
    When I am on show details page
    And the 'details' tab is selected
    Then I shall see the details metadata
