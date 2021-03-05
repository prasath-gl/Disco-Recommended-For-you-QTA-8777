Feature: Video Player 

  @P0
  Scenario: Video plays in portrait mode by default
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    Then video plays in portrait mode by default

  @P0
  Scenario: Full Screen on Video Player
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And I change the video to landscape
    Then the video plays in landscape mode
    
 @Launch
  Scenario: Video playback
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    Then the video plays correctly
  
  @P1
  Scenario: Skip 10 sec Forward
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And I scrub forward on the Video
    Then the video playback time should be increased by 10 seconds
  
  @P1
  Scenario: Skip 10sec Backward
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And I scrub backwards on the video
    Then the video playback time should be decreased by 10 seconds

  Scenario: Scrub forward - pause state
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And I tap on "pause" button
    And I scrub forward on the Video
    Then the video playback time should be increased by 10 seconds

  Scenario: Scrub backward - pause state
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And I tap on "pause" button
    And I scrub backwards on the video
    Then the video playback time should be decreased by 10 seconds

  @P1
  Scenario: Player Controls
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And I see "pause" on the player
    And I see "forward" on the player
    And I see "backward" on the player
    And I see "player back" on the player
    And I see "full screen" on the player
    Then I see "cc" on the player

 Scenario: Functionality of pause button on player
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And I tap on "pause" button
    Then video should be paused

 Scenario: Functionality of play button on player
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And I tap on "play" button
    Then the video plays correctly

 Scenario: Functionality of back button
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And I tap on "player back" button
    Then I see previous screen from where playback was initiated

 Scenario: Functionality of pause button on player (lansdsape mode)
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And the video plays correctly
    And I change the video to landscape
    And I tap on "pause" button
    Then video should be paused

 Scenario: Functionality of play button on player(lansdsape mode)
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And I change the video to landscape
    Then the video plays correctly

Scenario: Functionality of X button
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And I change the video to landscape
    And I tap on X button at left top corner in landscape
    Then I see previous screen from where playback was initiated

 Scenario: Skip 10sec Forward (lansdsape mode)
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And the video plays correctly
    And I change the video to landscape
    And I scrub forward on the Video
    Then the video playback time should be increased by 10 seconds

  Scenario: Skip 10 sec Backward (lansdsape mode)
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And the video plays correctly
    And I change the video to landscape
    And I scrub backwards on the video
    Then the video playback time should be decreased by 10 seconds

 Scenario: Player Controls - Landscape mode
    Given I am an auth user
    When I am on video landing screen
    Then the video plays correctly
    And video plays in portrait mode by default
    And I change the video to landscape
    And I see "pause" on the player
    And I see "forward" on the player
    And I see "backward" on the player
    And I see "player back" on the player
    And I see "full screen" on the player
    Then I see "cc" on the player

  Scenario: Skip 10 sec Forward - multiple  times (n times)(lansdsape mode)
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And the video plays correctly
    And video is playing I tap on 10sec forward button multiple times
    And I see video shifts 10Xn times forward
    Then the video plays correctly

  Scenario: Skip 10sec Backward - multiple  times
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video is playing I tap on 10sec backward button multiple times
    And I see video shifts 10Xn times backward
    Then the video plays correctly

  Scenario: Skip 10 sec Forward - multiple  times (n times)(lansdsape mode)
    Given I am an auth user
    When I am on video landing screen
    Then the video plays correctly
    And video plays in portrait mode by default
    And the video plays correctly
    And I change the video to landscape
    And video is playing I tap on 10sec forward button multiple times
    And I see video shifts 10Xn times forward
    Then the video plays correctly

  Scenario: Full screen to potrait mode
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And I change the video to landscape
    And I change the video to portrait
    Then video plays in portrait mode by default

  @P1
  Scenario: Display CC on player
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    Then I see "cc" on the player

  Scenario: Full screen to potrait mode
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And I change the video to landscape
    And I see "cc" on the player
    And I change the video to portrait
    And I see "cc" on the player
    Then video plays in portrait mode by default

  @P1
  Scenario: Display CC on player
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And I see "cc" on the player
    Then I see Depending on the state of the close captions
  
  @Launch @P0
  Scenario: Show with multiple episodes - Next episode from 'UpNext' list starts playing after current episode is completed, UpNext panel metadata
    Given I am an auth user
    When I finish watching the current episode
    And I validate UpNext panel metadata
    Then I see next episode in the list from the same show starts playing

  @P0
  Scenario: Playlist - Next video in 'UpNext' starts playing
    Given I am an auth user
    When I finish watching an episode from a curated playlist collection
    Then I see next episode in the playlist collection starts playing

  @P0
  Scenario: Show with multiple seasons - First episode of Next season plays after current season is completed
    Given I am an auth user
    When I finish watching the last episode of the current season
    And I see upnext lable on video player
    Then I see first episode of the next season starts playing

  @P0
  Scenario: Play last item in a Playlist collection
    Given I am an auth user
    When I finish watching the last episode of playlist
    And I see next video starts playing
    And if user exits the player while playing that related video
    Then user is returned to the Playlist landing page

  Scenario: Scrub forward and backward
    Given I am an auth user
    When I am on video landing screen
    Then I scrub forward and backward and verify

  Scenario: Scrubbing while paused
    Given I am an auth user
    When I am on video landing screen
    Then I scrub while video is paused and verify

  @P0
  Scenario: Video player screen, Video Metadata
    Given I am an auth user
    When I am on video landing screen
    Then I should see video player,Up Next List and metadata

  @P1
  Scenario: Portrait - Info button
    Given I navigate to video landing screen
    When I tap on episode info button
    Then I should see episode metadata, description and network badge
    And I tap on watch now button
    Then I should see video playing in video player

  Scenario: Navigation across multiple Network & sub category - Multiple times
    Given I am an auth user
    And I am on Shows screen
    When I select a network and its sub category shows
    Then I should see shows related to selected category
  
  @P1
  Scenario: Changing orientation during ad playout
    Given I login using adlite account
    When I am on video landing screen with 'adshow2'
    And I should be able to see the ad
    And I change the video to landscape
    Then I should be able to see the ad playing in landscape mode

 Scenario: Exit fullscreen mode - Paused
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    And video plays in portrait mode by default
    And I change the video to landscape
    And I tap on "play" button
    And I change the video to portrait
    Then The video will remain paused

Scenario: Next video starts playing in landscape mode
    Given I am an auth user
    And I finish watching the last episode of the current season
    When I change the video to landscape
    And I see upnext lable on video player
    And the video plays correctly
    Then the video plays in landscape mode

Scenario: Playlsit video - Up next -Auto Pagination on scroll down
    Given I am an auth user
    When I am on video landing screen
    Then I should see video player,Up Next List and metadata
