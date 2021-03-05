@Adtech
Feature: AdTech feature

Scenario: Video playback
    Given I am an auth user
    When I am on video landing screen
    And the video plays correctly
    Then video plays in portrait mode by default

Scenario: Ad pause
	Given I login using adlite account
	When I am on video landing screen with 'adshow1'
	And I tap on pause button when ad is playing
	Then Ad should be paused

Scenario: Back button exits ad playback
	Given I login using adlite account
	When I am on video landing screen with 'adshow8'
	And I should be able to see the ad
	And I tap on "player back" button
    Then I see previous screen from where playback was initiated

Scenario: CC can be toggled while ad is playing
	Given I login using adlite account
	When I am on video landing screen with 'adshow5'
	And I should be able to see the ad
	Then I should be able to toggle closed captions

Scenario: Ad countdown timer
	Given I login using adlite account
	When I am on video landing screen with 'adshow4'
	And I should be able to see the ad
	Then I see ad timer counts down correctly

@Launch
Scenario: Clickthrough works correctly
 	Given I login using adlite account
	When I am on video landing screen with 'adshow5'
	And I should be able to see the ad
	And I should be able to click through to advertisers site
	And I tap on device back
	Then user watches complete ad

Scenario: Deeplink to video
	Given I am an auth user
	When I enter the deep link URL of any video episode from show screen
	Then video plays in portrait mode by default

@P0
Scenario: Continue Watching resume position is correct regardless of ad load
	Given I am an auth user
	When I am on video landing screen
	And I watch the video for sometime and exit the player
	Then I tap on previously watched video tile from continue watching rail and validate resume point

Scenario: Mid0 Adbreak can't be skipped
	Given I login using adlite account
	When I am on video landing screen with 'adshow8'
	And I scrub till 'chapter 2' and see the mid0 ad appears
	Then user watches complete ad

Scenario: Ad breaks aren't replayed after being rewatched and rewinded 
	Given I login using adlite account
	When I am on video landing screen with 'adshow5'
	And I scrub till 'chapter 2' and see the mid0 ad appears
	And user watches complete ad
	And I scrub to 'chapter 2'
	Then video plays in portrait mode by default

Scenario: Ad breaks completed in a previous session to do not count toward future continue watching sessions 
	Given I login using adlite account
	When I am on video landing screen with 'adshow8'
	And I scrub till 'chapter 3' and see the mid0 ad appears
	And user watches complete ad
	And I watch the video for sometime and exit the player
	And I tap on previously watched video tile from continue watching rail and validate resume point
	And I scrub till 'chapter 2' and see the mid0 ad appears
	Then user watches complete ad

Scenario: Continue Watching ad breaks aren't played on resume playback
	Given I login using adlite account
	When I am on video landing screen with 'adshow8'
	And I scrub till 'chapter 3' and see the mid0 ad appears
	And user watches complete ad
	And I watch the video for sometime and exit the player
	And I tap on previously watched video tile from continue watching rail and validate resume point
	Then video plays in portrait mode by default

Scenario: Returning to Content from Cont Watching 
	Given I am an auth user
	When I am selecting a video from cont watch list
	Then I see no brief ad clip before content begins

Scenario: FF to Ch2 resumes it without skipping Mid0 Ad break
	Given I login using adlite account
	When I am on video landing screen with 'adshow5'
	And I scrub till 'chapter 2' and see the mid0 ad appears
	And user watches complete ad
	Then video resumes and starts playing

Scenario: Ad breaks aren't replayed after being watched 
	Given I login using adlite account
	When I am on video landing screen with 'adshow7'
	And I scrub till 'chapter 2' and see the mid0 ad appears
	And user watches complete ad
	And I scrub to 'chapter 3'
	And user watches complete ad
	Then no ad breaks will be played for those slots

Scenario: User cannot fast-forward through ads
	Given I login using adlite account
	When I am on video landing screen with 'adshow1'
	And I should be able to see the ad
	Then I can't fast forward through the ads
