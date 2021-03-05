Feature: JIP

  Scenario: Display of JIP channel player screen
    Given I am an auth user
    When I am on JIP channel show details screen
    And I click on JIP channel tile under channel tab
    Then video plays in portrait mode by default

  Scenario: Metadata/Player controls on player screen during JIP channel playback
    Given I am an auth user
    When I am on JIP channel show details screen
    And I click on JIP channel tile under channel tab
    And video plays in portrait mode by default
    And I shouldn't see any metadata other than progress bar and cc
    And I change the video to landscape
    And I shouldn't see any metadata other than progress bar and cc
    Then I see there is no player control button in this player

  Scenario: Trick mode operations during JIP channel playback
    Given I am an auth user
    When I am on JIP channel show details screen
    And I click on JIP channel tile under channel tab
    And video plays in portrait mode by default
    Then I see there is no player control button in this player

  Scenario: Leave the video player by pressing back button
    Given I am an auth user
    When I am on JIP channel show details screen
    And I click on JIP channel tile under channel tab
    And I tap on "player back" button
    Then I see show hero on top

  Scenario: Adding JIP channel shows to My List
    Given I am an auth user
    And I go to the 'My List' screen
    When I remove the shows from my list
    When I am on JIP channel show details screen
    And I tap 'My List' button
    And I navigate to my list page
    Then I see the show listed on the page

  Scenario: Removing JIP channel shows from My LIst
    Given I am an auth user
    And I go to the 'My List' screen
    When I remove the shows from my list
    When I am on JIP channel show details screen
    And I tap 'My List' button
    And I tap 'My List' button
    And I navigate to my list page
    Then I should see show is removed from my list

  Scenario: Initiate the playback of JIP channel
    Given I am an auth user
    When I am on JIP channel show details screen
    And I click on JIP channel tile under channel tab
    Then Live stream plays without any issue

  Scenario: Display of JIP channel on Show details screen
    Given I am an auth user
    When I am on JIP channel show details screen
    Then I should see hero image,title,description, channel and network logo on show details page

  Scenario: Watch Now CTA button not showing for JIP channel
    Given I am an auth user
    When I am on JIP channel show details screen
    Then I should not see Watch now CTA button on show details page

  Scenario: Order of the Regions on Show detail page
    Given I am an auth user
    When I am on JIP channel show details screen
    Then Ordering and regions of the show should be channel,extras and about the show

  Scenario: Metadata should not be shown on show detail page
    Given I am an auth user
    And I am on JIP channel show details screen
    When I play the channel from show details screen
    Then I should not see the metadata on show details page
