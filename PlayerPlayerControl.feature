Feature: Player Controls

  @Regression
  Scenario: Verify that when the player pointer is dragged using the scrub bar to end of the playback the player displays the play button once again to start the playback
    Given I am an auth user
    When I finish watching the current episode
    And I validate UpNext panel metadata
    Then I see next episode in the list from the same show starts playing

  @Regression@Sanity@playpause
  Scenario: Play and Pause condition validation for VOD assets
    Given I am an auth user
    When I go to the Search screen and play an episode
    And user tap on the video screen
    And I tap on "pause" button

  @Regression@Sanity
  Scenario: Skip 10 sec Forward_Landscape mode
    Given I am an auth user
    When I go to the Search screen and play an episode
    And I change the video to landscape
    Then I wait for small duration during video play
    Then validate 10s skip forward

  @Regression@Sanity
  Scenario: Skip 10 sec Backward_Landscape mode
    Given I am an auth user
    When I go to the Search screen and play an episode
    And I change the video to landscape
    Then I wait for small duration during video play
    Then validate 10s skip rewind

  @Regression@Sanity
  Scenario: Skip 10sec Backward _ Portrait mode
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then validate 10s skip rewind

  @Regression@Sanity
  Scenario: Skip 10sec Forward_Portrait mode
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then validate 10s skip forward

  @Sanity
  Scenario: Check whether all player controls are shown on screen in Landscape mode
    Given I am an auth user
    When I go to the Search screen and play an episode
    And user click fullscreen 
    Then validate all control players are visible  

  @Sanity
  Scenario: Check whether video page is opened smoothly with player controls
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then validate all control players are visible

  @Sanity
  Scenario: Check whether the playback is skipped smoothly on clicking backward 10sec
    Given I am an auth user
    When I go to the Search screen and play an episode
    And user tap on the video screen
    Then user rewind the video

  @Sanity
  Scenario: Check whether the playback is skipped smoothly on clicking forward 10sec
    Given I am an auth user
    When I go to the Search screen and play an episode
    And user tap on the video screen
    Then user forward the video

  @Sanity
  Scenario: Check whether the close X option is shown on playback screen
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then validate close X option is visible