Feature: Shows
 
  @Launch
  Scenario: Browse Shows screen
    Given I am an auth user
    When I am on Shows screen
    Then A list of shows are displayed

  Scenario: Browse Shows screen - Select a show
    Given I am an auth user
    When I am on Shows screen
    And I select a show
    Then I see the show detail screen page

  @P1
  Scenario: Episode metadata and episode art
    Given I am an auth user
    When I am on show details page
    Then I see episode metadata for episode art , title , number and duration

  Scenario: Episode List sorting order
    Given I am an auth user
    When I am on show details page
    And I select any of the available seasons
    And I see episode list in the season
    Then I see episodes in order of newest episode to oldest episode for that season

 Scenario: To validate Show Hero image
    Given I am an auth user
    When I am on show details page
    Then I see show hero on top

 Scenario: Show Title over Hero
    Given I am an auth user
    When I am on show details page
    Then I see Show Title over the Show Hero

  Scenario: Episode rail description (Only Tab)
    Given I am an auth user
    When I am on show details page
    And I click more option on first available episode description
    Then I see episode description
  
  @Launch @P1
  Scenario: Sub-nav Network filter screen changes, Network filter
    Given I am an auth user
    When I am on Shows screen
    Then I select different networks and validate page changes  

  @P1
  Scenario: Sub-nav Category filter changes , Category filter
    Given I am an auth user
    When I am on Shows screen
    Then I choose different filters and validate shows   
    
   @Launch @P1
   Scenario: Shows/Browse page - Filter on spcecific category(ALL networks filter)
    Given I am an auth user
    When I go to the 'Shows' screen
    And I select 'All' network
    And I navigate to 'A-Z' filter
    Then I see shows listed in alphabetical order


  Scenario: User scroll till the down 
    Given I am an auth user
    When I am on Shows screen
    And I scroll down and see filter list still appears and Network Row disappear
    Then I scrolls back to top and see Network Switcher row  appear

  @P1
  Scenario: Happy Path - Network and Browse Filters - Scroll Behavior, Clicking on Show page from Show page
    Given I am an auth user
    When I am on Shows screen
    And I scroll down and see filter list still appears and Network Row disappear
    Then I tap on browse and see page scrolls back to top

 Scenario: Filter - swipe left and right
    Given I am an auth user
    When I go to the 'Shows' screen
    Then I scroll left and right on filter list

 Scenario: Network logo on show hero
    Given I am an auth user
    When I am on show details page
    Then I see network logo on show hero

 Scenario: Episode duration
    Given I am an auth user
    When I am on show details page
    Then I validate episode duration

 @P1
 Scenario: Metadata on hero
    Given I am an auth user
    When I am on show details page
    Then I see show metadata on hero

 @P1
 Scenario: Tap on Start Series - multiple episodes
    Given I am an auth user
    When I am on show page with multiple episodes
    Then I see earliest season episode available playing

 @wip @P1
 Scenario: Tap on watch button - single episode
    Given I am an auth user
    When I am on show page with multiple episodes
    And I tap on back button
    And I tap on "Resume" button on show episodes screen 
    Then video plays in portrait mode by default

 Scenario: Network logo on show hero
    Given I am an auth user
    When I am on show details page
    And I tap on back button
    Then I see "Home" screen

 Scenario: Season Selector
    Given I am an auth user
    When I am on show page with multiple episodes
    Then I see drop down list in bottom half of the screen

@P1
 Scenario: Trending Shows tab
    Given I am an auth user
    When I go to the 'Shows' screen
    And I tap on "Trending" tab 
    Then I shall see Show cards with thumbnail, show title, and network icon

@P1
 Scenario: Clips tab behaviour
    Given I am on show details screen with extra clip
    When I tap on the Clips tab
    Then I see episode metadata for episode art , title , number and duration

 Scenario: Special show with Multiple episodes - Start show button on hero
    Given I am on show details screen of special show with multiple episodes
    Then I see Watch Now button on hero tile

 Scenario: Special show with Single episode - Watch now button
    Given I am on show details screen of special show with single episode
    Then I see Watch Now button on hero tile

 Scenario: Episode List - Special show with multiple episodes
    Given I am on show details screen of special show with multiple episodes
    Then I see episode list in the season        

@P1
 Scenario: Clicking on Another Filter While Scrolled Down
    Given I am an auth user
    When I go to the 'Shows' screen
    Then The Network row scrolled with the page

 Scenario: Season Selector - Returning user
    Given I am an auth user
    When I am on show page with multiple episodes
    And I tap on "Watch Now" button on show episodes screen
    And Let the video play for "2" mins
    And I tap on "player back" button
    Then I see Resume button on show episodes screen
  
 @P0  
 Scenario: Start Series button - Unlocked - authenticated user ('Watch' button for DTC)
    Given I tap on 'Sign In'
    When I enter the email and password associated with my Discovery+ account
    And I see "Home" screen
    And I am on show page with multiple episodes
    Then I see earliest season episode available playing
 
 @P1
  Scenario: Return user - Resume button on Hero - authenticated user
    Given I tap on 'Sign In'
    When I enter the email and password associated with my Discovery+ account
    And I see "Home" screen
    And I am on show page with multiple episodes
    And I see earliest season episode available playing
    And Let the video play for "2" mins
    And I tap on "player back" button
    Then I see Resume button on show episodes screen

  Scenario: Return User - Remaining time (Progress bar) below Resume - authenticated user
    Given I tap on 'Sign In'
    When I enter the email and password associated with my Discovery+ account
    And I see "Home" screen
    And I am on show page with multiple episodes
    And I see Resume button on show episodes screen
    Then I see remaining time progress bar below the Resume button
    
 Scenario: Hero tile - Metadata - single episode
    Given I am an auth user
    When I am on show details page with single episode
    Then I see show metadata on hero

Scenario: Hero tile - Metadata - multiple episodes
    Given I am an auth user
    When I am on show page with multiple episodes
    Then I see show metadata on hero

@P0
Scenario: Auth return user - Show details - Resume, Metadata on Hero
     Given I am an auth user
     When I open show detail screen in which an episode is partly watched
     And I see show metadata on hero
     Then I tap on Resume button and verify episode resuming from where I left    

Scenario: Auth return user - Show details - Single season
     Given I am an auth user
     When I open show detail screen in which the last episode is about 95% watched
     Then I tap on watch button and expect episode 1 starts playing

 Scenario: Auth return user - Show details - Watched all the seasons completely
     Given I am an auth user
     When I open show detail screen in which I have previously finished watching the entire show
     Then I tap on watch button and expect episode 1 starts playing             

Scenario: Browse Shows screen
    Given I am an auth user
    When I am on Shows screen
    Then I should see All Netwok and Genre filter is selected by default

Scenario: Show Page - "You May Also Like" rail - Return user
    Given I am an auth user
    When I am on show details page
    And I tap on you may also like tab
    Then I click on show tile in you may also like tab

Scenario: Shows Page - "You May Also Like" rail - scrolling the shows tile
    Given I am an auth user
    When I am on show details page
    And I tap on you may also like tab
    Then I scroll till end of the screen

@P1
Scenario: Shows Page - "You May Also Like" - Metadata
    Given I am an auth user
    When I am on show details page
    And I tap on you may also like tab
    Then I see Show cards with thumbnail, show title, and network icon on you may like tab

Scenario: Shows page - "You May Also Like" - navigation to show details
    Given I am an auth user
    When I am on show details page
    And I tap on you may also like tab
    And I see Show cards with thumbnail, show title, and network icon on you may like tab
    Then I see the show detail screen page