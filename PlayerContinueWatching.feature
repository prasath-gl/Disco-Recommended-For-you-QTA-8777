
Feature: Continue watching

  @Regression@Sanity
  Scenario:Newly added or last played from continue watching asset is showing up on the first index
    Given I am an auth user
    When I am watching the current episode
    When I navigate to 'Continue Watching' rail with tiles

  @Regression@Sanity
  Scenario: Asset should get removed from continue watching once playback duration completed
    Given I am an auth user
    When I am watching the current episode
    When I navigate to 'Continue Watching' rail with tiles
    When I finish watching the current episode
    And I validate UpNext panel metadata
    Then I see next episode in the list from the same show starts playing
    Then I navigate to 'Continue Watching' rail with episodes

  @Regression
  Scenario: Verify Asset should get added into continue watching rail, after watching for some time
    Given I am an auth user
    When I am on video landing screen
    And user forward the video
    And I see "pause" on the player
    And I tap on 'player back' button
    And I tap on device back
    And I go to the 'Home' screen
    When I navigate to 'Continue Watching' rail with tiles
    #Then I see Metadata on each tile containing, thumbnail image, title, subtitle & Progressed indicator

  @Regression@Player_Android
  Scenario: Verify Continue watching band rail should appear first
    Given I am an auth user
    When I am on home screen
    Then user validate Continue Watching band rail

  @Regression@Sanity
  Scenario: Verify Asset should get resumed from current playback from last watched duration
    Given I am an auth user
    And I have previously in-progress episodes in continue watching rail
    Then I tap on any video in continue watching rail button and verify episode resuming from where I left