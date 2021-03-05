Feature: Player functionality

  Scenario: Check whether the video remain paused on Landscape mode.
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then validate remains paused in landscape orientation

 Scenario: Validate resume content
    Given I am an auth user
    When I go to the Search screen and play an episode
    Then validate resume content

  Scenario: Check whether the video is resumed in Landscape mode
    Given I am an auth user
    When I go to the Search screen and play an episode
    And user click fullscreen 
    Then user pause and resume the video

