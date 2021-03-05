Feature: QOE Automation

@QoEAdfree
Scenario: SimpleVOD Background
    Given I am an auth user
    When I am on video landing screen with qoe shows
    And I perform simple VOD scenarios
    Then I take app to background and relaunch app after video playback

@QoEAdfree
Scenario: Multiple forward backward 10sec scenarios
    Given I am an auth user
    When I am on video landing screen with qoe shows
    Then I perform forward and rewind scenarios

@QoEAdfree
Scenario: ColdStart Player termination before video starts WarmStart
    Given I am an auth user
    When I am on video landing screen with qoe shows
    And I close the video
    Then I close the app and launch again

@QoEAdfree
Scenario: Cancel Select Allow Autoplay
    Given I am an auth user
    When I am on video landing screen with qoe shows
    Then I perform autoplay scenarios

@QoEAdlite
Scenario: Ad not to be replayed and Ad pause resume
    Given I login using adlite account
    When I am on video landing screen with 'adshow1'
    And I pause and resume Ad play
    Then Ad should not be replayed on rewind

@QoEAdfree
Scenario: Seek progress bar scenarios
    Given I am an auth user
    When I am on video landing screen with qoe shows
    Then I perform seek progress bar scenarios

@QoEAdfree
Scenario: Long Duration
    Given I am an auth user
    When I am on video landing screen with qoe shows
    Then I take video to beginning and click cancel autoplay after long playback