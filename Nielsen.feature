@wip
Feature: Nielsen Scenarios

 Scenario: Lean Back
    Given I am an auth user
    When I am on video landing screen
    And video plays in portrait mode by default
    And the video plays correctly
    And Let the video play for "1" mins
    And I close video player
    Then I exit app

  Scenario: Close Ad
    Given I am an auth user
    When I am on video landing screen
    And video plays in portrait mode by default
    And the video plays correctly
    Then Ad start playing in player
    And I close video player
    Then I exit app

  Scenario: Pause Content
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And Let the video play for "1" mins
    And Pause the video for "30" secs
    And I tap on "play" button
    And the video plays correctly
    And Let the video play for "1" mins
    And I close video player
    Then I exit app

  Scenario: Pause Content
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And Let the video play for "2" mins
    And Seek forward for "1" min
    And Let the video play for "1" mins
    And I close video player
    Then I exit app

  Scenario: Seek Back Inside Chapter
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And Let the video play for "3" mins
    And Seek backward for "1" min
    And Let the video play for "1" mins
    And I close video player
    Then I exit app
