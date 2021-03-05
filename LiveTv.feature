@wip
Feature: Live TV

  Scenario: Watch Live Tv - Live badge
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    Then I should see hero image with live badge

  Scenario: Watch Live video screen metadata
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    And I should see series and episode count details
    When I should see episode name below video player
    Then I should see video discription

  Scenario: Watch Live video discription screen metadata
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    And I should Navigate to episode details
    When I should see series title
    And I should see episode name on description screen
    Then I should see video discription

  Scenario: Watch Live Next Up video content metadata 
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    And I should see next up on tlc section header
    Then I should see live content play's next with info

  Scenario: Anon - Live hero image with Live badge 
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    Then I should see hero image with live badge
    And I should see "hero title" in live page

  Scenario: Anon - On Now title above Live hero
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    Then I should see "On Now title" in live page

  Scenario: Anon - Progress bar on Live hero
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    Then I should see "progress bar" in live page

 Scenario: Live player page - Metadata of live content
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    Then I should see live content metadata

 Scenario: List of contents in Up Next
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    Then I see a list of contents in Upnext
    And I scroll till end of the screen
    And I see episode list in the season

 Scenario: Live - Next Up (VOD) - play
    Given I click on Link Tv Provider and login
    When I am on home screen
    And I tap on live tv icon
    Then I see the Next item up with a play icon on it

 Scenario: Live Player in Full Screen (Landscape) mode
    Given I am an auth user
    When I am on home screen
    And I tap on live tv icon
    And I am a user on the app watching a LIVE asset
    And I change the video to landscape
    Then I see metadata and validate on landscape video title

Scenario: Scroll behavior - Live Screen
   Given I am an auth user
   When I go to the 'Live' screen
   And I am on 'Live' screen
   And I scroll down
   Then I tap on 'Live' and header slides down and is visible

Scenario: Kebab menu - Live Screen
   Given I am an auth user
   When I go to the 'Live' screen
   And I click more option on first available episode description
   Then I validate info modal

Scenario: Live schedule for different networks
   Given I am an auth user
   When I go to the 'Live' screen
   Then I see live schedule of programs on all different networks
