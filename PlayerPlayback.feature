Feature: Playback

  @Regression
  Scenario: Check the behavior of the player when app is moved to foreground
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then I wait for small duration during video play
    And I tap on "pause" button
    When Run app in background for few seconds and relaunch the app
    #Then I am on welcome screen
    Then I wait for small duration during video play
    Then I see "play" on the player

  @Regression
  Scenario: Check that the Player pointer when scrubbed and released the playback continues
    Given I am an auth user
    When I am on video landing screen
    Then I scrub the video and validate

  @Regression@Sanity
  Scenario: Check the player behavior when it resumes the playback of content when app moved back to foreground.
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then I wait for small duration during video play
    Then I validate the timestamp during the app relaunch

@Regression@Sanity
  Scenario: Video timeline_Landscape
    Given I am an auth user
    When I go to the Search screen and play an episode
    And I change the video to landscape
    Then I wait for small duration during video play
    Then I validate the timeline

  @Regression@Sanity
  Scenario: Video timeline_Portrait
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then I validate the timeline

  @Regression@Sanity
  Scenario: Timestamp_Portrait
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then I validate the timestamp

  @Regression@Sanity
  Scenario: Timestamp _Landscape
    Given I am an auth user
    When I go to the Search screen and play an episode
    And I change the video to landscape
    Then I wait for small duration during video play
    Then I validate the timestamp