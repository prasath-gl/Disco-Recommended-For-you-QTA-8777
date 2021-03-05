Feature: Playlist
  
  @P1
  Scenario: Info modal - Bringing up info modal
    Given I am an auth user
    When I am on show details page
    Then I validate info modal

  @P1
  Scenario: Info modal - Closing info modal
    Given I am an auth user
    When I am on show details page
    And I validate info modal
    And I tap outside the modal
    Then I see info modal closes

   Scenario: Home screen - curated rail
    Given I am an auth user
    When I am on home screen
    And Validating "discovery+ Collections" rail tiles on home screen
    Then I see "discovery+ Collections" rail with tiles

  Scenario: Curated rail - Horizontal scroll
    Given I am an auth user
    When I am on home screen
    And Validating "discovery+ Collections" rail tiles on home screen
    And I scroll horizontally "left" for "discovery+ Collections" rail tiles and verify
    Then I scroll horizontally "right" for "discovery+ Collections" rail tiles and verify

  @P1
  Scenario: Curated rail - Metadata
    Given I am an auth user
    When I am on home screen
    And Validating "discovery+ Collections" rail tiles on home screen
    Then I see "discovery+ Collections" curated rail metadata

  @P1
  Scenario: Curated list - Tap on Playlist
    Given I am an auth user
    When I am on home screen
    When I navigate to 'discovery+ Collections' rail with tiles
    And I tap on any tile in the curated list
    Then I see playlist metadata on hero

  Scenario: Back from playlist 
    Given I am an auth user
    When I am on playlist landing screen
    And I tap on back arrow button
    Then I am back to home screen

  Scenario: Metadata for playlist tiles
    Given I am an auth user
    When I am on playlist landing screen
    Then I see metadata on playlist tiles

  Scenario: 'Add to My List' Button + My List Icon  on Hero - Home Screen
    Given I am an auth user
    When I am on home screen
    And I see home hero
    Then I see cta button and add to my list 

  Scenario: 'Add to My List' Button + My List Icon  on Hero - Show Screen
    Given I am an auth user
    When I am on show details page
    Then I see cta button and add to my list

  Scenario: Favorite shows - empty list, Anon/Auth User- No MyList / My stuff page elements
    Given I am an auth user
    When I go to the 'My List' screen
    Then I see a page with no shows message
