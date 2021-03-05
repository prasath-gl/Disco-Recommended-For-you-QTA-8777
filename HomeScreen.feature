Feature: Home Screen    

  Scenario: HomeHero - Show Metadata
    Given I am an auth user
    When I am on home screen
    And I see home hero
    Then I see home hero metadata

  Scenario: Play hero episode
    Given I am an auth user
    When I am on home screen
    And I start home hero series
    Then I see shows detail page  

  Scenario: Identify Home screen rail's
    Given I am an auth user
    When I am on home screen
    Then Validating different rails on home screen      

  Scenario: Home Screen - Just Added Rail
    Given I am an auth user
    When I am on home screen
    When I navigate to 'Just Added' rail with tiles
    Then I see "Just Added" rail with tiles
  
  Scenario: Home Screen - Just Added Rail- Horizontal scroll
    Given I am an auth user
    When I am on home screen
    When I navigate to 'Just Added' rail with tiles
    And I scroll horizontally "left" for "Just Added" rail tiles and verify
    Then I scroll horizontally "right" for "Just Added" rail tiles and verify
    
  Scenario: Home Screen - Show Rail Horizontal scroll
    Given I am an auth user
    When I am on home screen
    When Validating "Trending Shows" rail tiles on home screen
    Then I scroll horizontally "left" for "Trending Shows" rail tiles and verify
    And I scroll horizontally "right" for "Trending Shows" rail tiles and verify

  @P1
  Scenario: Homepage - Tap on playlist tile on any rail
    Given I am an auth user
    When I am on home screen
    And Validating "Trending Shows" rail tiles on home screen
    Then I tap on show tile in rail
    And I see playlist details screen

  Scenario: Home Screen - Show Rail
    Given I am an auth user
    When I am on home screen
    And Validating "Trending Shows" rail tiles on home screen
    Then I see "Trending Shows" rail with tiles

@P1
Scenario: Persist scroll position
    Given I am an auth user
    When I am on home screen
    Then I scroll down in all navigation tabs later switch tab and validate scroll position

Scenario: Metadata on each tile 
    Given I am an auth user
    When I am on home screen
    Then I validate metadata on rails

Scenario: Single Home Hero
    Given I am an auth user
    When I am on home screen
    Then I see maximum number slides to be one

Scenario: HomeHero - Left/Right scroll
    Given I am an auth user
    When I am on home screen
    Then I scroll left and right on sub-nav

@P1
Scenario: Hero Logo, description and background
    Given I am an auth user
    When I am on home screen
    And I select a "discovery+ Originals" from home screen
    Then I see network logo, hero image and network description

@P1
Scenario: Network Selector - Rails & contents
    Given I am an auth user
    When I am on home screen
    And I select a "DiscoveryPlusOriginals" from home screen
    And I see network logo, hero image and network description
    And I select a "TLC" from home screen
    Then I see network logo, hero image and network description

Scenario: Home Page - Network Logo
    Given I am an auth user
    When I am on home screen
    Then I see Dplus logo on the top in the home page

Scenario: Home Page D+ Stacked Logo on Home Screen
    Given I am an auth user
    When I am on home screen
    And I see Dplus logo on the top in the home page
    Then I scroll down and see sub nav still appears and Dplus logo disappear

@P1
Scenario: Home page hero across sub-nav
    Given I am an auth user
    When I am on home screen
    Then I swipe left-right within sub-nav and validate hero metadata

@P1
Scenario: Network Selector - Home Page
    Given I am an auth user
    When I am on home screen
    And I select a "DiscoveryPlusOriginals" from home screen
    Then I am taken to the DiscoveryPlus Originals network screen

Scenario: Persistent TV Network logo
    Given I am an auth user
    When I am on home screen
    And I select a "TLC" from home screen
    Then I see the TV Network logo does not remain persistent in the top left

@P0
Scenario: Curated List - Play, Happy Path to Video Play
    Given I am an auth user
    When I tap on any tile from playlist rail
    And I tap on any episode tile from playlist landing screen 
    Then I see 'back' on the player

Scenario: Landing Page - Video Metadata
    Given I am an auth user
    When I tap on any tile from playlist rail
    Then I validate playlist landing page metadata

Scenario: Sub-nav page changes
    Given I am an auth user
    When I am on home screen
    Then I swipe left-right within sub-nav and validate page changes

Scenario: Show sub-nav upon landing on Home page
    Given I am an auth user
    When I am on home screen
    Then I see For You sub-nav item is shown or in focus

Scenario: Homepage - Tap on video tile on any rail
    Given I am an auth user
    When I navigate to 'Just Added' rail with tiles
    And I tap on any tile in the on "Just Added" rail
    And I tap on "Watch Now" button on show episodes screen
    Then video plays in portrait mode by default

Scenario: Content Rails display - Minimum rails
    Given I am an auth user
    When I am on home screen
    And I select a "TLC" from home screen
    And Validating "Trending" rail tiles on home screen
    And Validating "Just Added" rail tiles on home screen

Scenario: Popular Rails Display in first position
    Given I am an auth user
    When I am on home screen
    And I select a "DiscoveryPlusOriginals" from home screen
    Then I see the 'Trending' in first position
    And I scroll down
    Then I select a "DiscoveryPlusOriginals" from home screen

Scenario: Network Selector - Ordering of Networks - Interest Picker
    Given I am an auth user
    When I am on home screen
    And I select a "DiscoveryPlusOriginals" from home screen
    When I navigate to 'Trending' rail with tiles
    And I scroll down
    Then I select a "DiscoveryPlusOriginals" from home screen

@P1
Scenario: Network Selector - Navigation
    Given I am an auth user
    When I am on home screen
    And I select a "DiscoveryPlusOriginals" from home screen
    When I navigate to 'Trending' rail with tiles
    And I tap on any tile in the on "Trending" rail
    And I tap on "Watch Now" button on show episodes screen
    And video plays in portrait mode by default
    And I tap on device back
    Then I am taken to the specific network screen

@P1
Scenario: Continue Watching rail Metadata
    Given I am an auth user
    When I am on video landing screen
    And video is playing I tap on 10sec forward button multiple times
    And I see "pause" on the player
    And I tap on 'player back' button
    And I tap on device back
    And I go to the 'Home' screen
    When I navigate to 'Continue Watching' rail with tiles
    Then I see Metadata on each tile containing, thumbnail image, title, subtitle & Progressed indicator

@Launch @P1
Scenario: Continue Watching Tap, Home Screen - Continue Watching - Rail
    Given I am an auth user
    And I have previously in-progress episodes in continue watching rail
    Then I tap on any video in continue watching rail button and verify episode resuming from where I left    

Scenario: Scrolling down page and clicking on the pinned navigation 
    Given I am an auth user
    When I am on home screen
    And I scroll down
    And I tap on For You sub-nav item from sub-nav bar
    Then I see home hero metadata

Scenario: Repositioning selected Genre to be ON PAGE
    Given I am an auth user
    When I am on home screen
    And I see For You sub-nav item is shown or in focus
    And I scroll down
    And I tap on relationships sub-nav item from sub-nav bar
    Then I see home hero metadata

 Scenario: Home Screen - Just Added Rail- Horizontal scroll
    Given I am an auth user
    When I am on video landing screen
    And video is playing I tap on 10sec forward button multiple times
    And I see "pause" on the player
    And I tap on 'player back' button
    And I tap on device back
    And I go to the 'Home' screen
    When Validating "Continue Watching" rail tiles on home screen
    And I scroll horizontally "left" for "Continue Watching" rail tiles and verify
    Then I scroll horizontally "right" for "Continue Watching" rail tiles and verify

Scenario: Homepage - "Recommended for You" - navigation to show details
    Given I am an auth user
    When I am on home screen
    And Validating "Recommended for You" rail tiles on home screen
    When I tap on any show tile on "Recommended for You" rail
    Then I see show details screen for that show