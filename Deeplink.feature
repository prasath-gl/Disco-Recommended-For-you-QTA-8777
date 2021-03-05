Feature: Deeplink

Scenario: Tap on back - Deeplink to Show details
  Given I am an auth user
  When I enter the deep link URL of any unlocked promotional show
  And I see the show detail screen page
  And I tap on back button
  Then I see "Home" screen

Scenario: CTA button on deeplinking to Show detail page - Deeplink Auth
  Given I am an auth user
  When I enter the deep link URL of any unlocked promotional show
  And I see the show detail screen page
  Then I tap on "Watch Now" button on show episodes screen

Scenario: Tap on back - Deeplink Home page
  Given I am an auth user
  When I enter the deep link URL of home screen
  Then I tap on back button

Scenario: Tap on back button - deeplink episode - Auth
  Given I am an auth user
  When I enter the deep link URL of any video episode from show screen
  And video plays in portrait mode by default
  And I tap on back button
  Then I see "Home" screen 

Scenario: Deeplink - Browse Page
  Given I am an auth user
  When I enter the deep link URL of browse screen
  Then I am on 'Shows' screen

Scenario: Deeplink - Account Page
  Given I am an auth user
  When I enter the deep link URL of account screen
  Then I am on 'Account' screen

Scenario: Deeplink - MyList Page
  Given I am an auth user
  When I enter the deep link URL of mylist screen
  Then I am on 'My List' screen

Scenario: Deeplink - Playlist Page
  Given I am an auth user
  When I enter the deep link URL of playlist screen
  Then I see playlist metadata on hero

Scenario: Happy Path - Logged out user with the App Installed 
  Given I enter the deep link URL of home screen
  When I am an auth user
  Then I see "Home" screen
