@wip
Feature: Eventor UI scenarios

  Scenario: Anon - Interaction Click  - ONBOARDING
    Given I click on Link TV Provider Button
    Then I click on cancel button on Link_TV_Provider page
    And I am an auth user

  @events
  Scenario: Video playback
    Given I am an auth user
    When I am on video landing screen
    And video plays in portrait mode by default
    Then the video plays correctly

  @events
  Scenario: Video scrubbing forward
    Given I am an auth user
    When I am on video landing screen
    And video plays in portrait mode by default
    And the video plays correctly
    When I scrub forward on the Video
    Then the video playback time should be increased by 15 seconds

  Scenario: Video scrubbing backwards
    Given I am an auth user
    When I am on video landing screen
    And video plays in portrait mode by default
    And the video plays correctly
    When I scrub backwards on the video
    Then the video playback time should be decreased by 15 seconds

  Scenario: Anon - Interaction Click - Live/VOD test
    Given I am an auth user
    When I am on home screen
    And I am on video landing screen
    And I tap on "pause" button for eventor
    And I tap on "play" button
    And I scrub forward on the Video for eventor
    When I scrub backwards on the video for eventor
    And I tap on "cc" button
    Then I click on player progress bar
    And I change the video to landscape
    And I tap on X button at left top corner in landscape
