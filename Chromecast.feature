@wip
Feature: Chrome cast

  @P0
  @P1
   Scenario: Cast icon availability
     Given I am on video landing screen
     When I am casting to a Casting Device
     And I saw the device casted successfully
     Then I am stopping the casted video

  @P1
  Scenario: Receiver: Content Playing UI
    Given I am on video landing screen
    When I am casting to a Casting Device
    Then I saw show details on the connected device

  @P1
  Scenario: Scrub playback progress bar
    Given I am on video landing screen
    When I am casting to a Casting Device
    Then I scrub the progress bar on video player in sender device to the same position on connected device

  @P0
  Scenario: Replay control 10 Sec forward in sender device
    Given I am on video landing screen
    And I am casting to a Casting Device
    When I see playback shifts 10 sec forward and video starts playing smoothly

  @P0
  Scenario: Replay control 10 Sec backward in sender device
    Given I am on video landing screen
    And I am casting to a Casting Device
    Then I see playback shifts 10 sec backward and video starts playing smoothly
