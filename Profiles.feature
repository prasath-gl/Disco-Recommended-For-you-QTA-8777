Feature: Profiles

  Scenario: Add Profile from Manage Profiles Screen
    Given I am an auth user
    When I go to account
    And I go to 'Manage Profile' screen
    And I tap on Add Profile
    Then I am on create profile Screen

  @P1
  Scenario: Add Profile from Account Screen
    Given I am an auth user
    When I go to account
    And I tap on Add Profile
    Then I am on create profile Screen

  Scenario: User with just one Profile, Users with 1 profile - mobile
    Given I tap on sign in
    When I sign in as user with one profile
    Then I should not see who is watching screen
    And I should be taken to Home screen

  @P1
  Scenario: Display Profiles - Logged in user
    Given I login using adlite account
    When I go to account
    Then I should see list of profiles, Add Profile and Manage profile options

  @P1
  Scenario: Profile Creation - Add Profile Name Only
    Given I login using adlite account
    When I go to account
    And I tap on Add Profile button
    And I tap on profile name input text field and enter profile name
    And I tap on save
    Then I should see created profile in profiles
    And I tap on manage profiles and delete profile

  @P1
  Scenario:  Switch Profile
    Given I am an auth user
    And I go to account
    When I tap on the Profile I would like to use
    Then I should be taken to Home screen
    When I go to account
    Then I should see the Profile highlighted in frame on the Account Screen

  @P1
  Scenario: Customers with more than 1 Profile - Delete profile(YES), Switch Profile - Who is Watching?
    Given I login using adlite account
    And I navigate to edit profile screen
    When I delete a profile and select a new profile
    Then I should see the Profile highlighted in frame on the Account Screen

  @P1
  Scenario: Update profile name, Clicking on profile icon and username on manage profile screen
    Given I login using adlite account
    And I navigate to edit profile page
    When I update profile name and tap on save
    Then I should be taken to manage profile screen
    And The profile name should be updated

  @P1
  Scenario: Edit Profile Avatar
    Given I login using adlite account
    And I navigate to edit profile page
    When I select avatar and tap on save
    Then I should be taken to manage profile screen

  @Launch
  Scenario: Add and Remove Profile
    Given I login using adlite account
    And I create a profile
    And I should see created profile in profiles
    When I delete a profile
    Then I should not see the deleted profile in account

  Scenario: Add Profile from Manage Profiles Screen
    Given I login using adlite account
    And I navigate to add profile screen from manage profiles
    And I tap on profile name input text field and enter profile name
    When I tap on save
    Then I should see created profile in profiles
    And I tap on manage profiles and delete profile

  Scenario:Profile creation - Cancel
    Given I login using adlite account
    And I navigate to add profile screen
    And I tap on profile name input text field and enter profile name
    When I tap on cancel
    Then The profile should not be created in profiles

  Scenario: Profile name field empty - Error message
    Given I login using adlite account
    And I navigate to add profile screen
    When I save empty profile
    Then I should see Required field error message
    And The save button should be disabled

  Scenario: Profile Creation - Error message
    Given I login using adlite account
    And I navigate to add profile screen
    When I enter profile name more than 30 chars
    Then I should see valid error message
    And The save button should be disabled

  Scenario: Profile name requirements, User enters a name that is already in use in the app
    Given I login using adlite account
    And I create a profile from account screen
    When I again try to create a profile that is already in use
    Then I should see inline error message
    And I tap on manage profiles and delete the created profile

  Scenario: Update profile name - Error message
    Given I login using adlite account
    And I navigate to edit profile page
    When I enter the profile name that does not meet the requirements
    Then I should see valid error message
    And The save button should be disabled

  Scenario: Delete profile - Customers with 1 Profile
    Given I login using adlite account
    And I go to account
    When I am a customer with one profile in account
    Then I should not see delete profile option in edit profile page

  Scenario: Customers with more than 1 Profile - Delete Profile 1 NO
    Given I login using adlite account
    And I navigate to edit profile
    And I tap on delete profile and validate popup
    When I tap on CANCEL from delete popup
    Then I should be taken back to edit profile screen
    And I should see the profile in manage profiles

  Scenario: Customers with more than 1 Profile - Delete Profile 1 YES
    Given I login using adlite account
    When I delete the first profile
    Then I should not see the deleted profile in profiles

  Scenario: Display Profiles - Who's watching on sign in
    Given I tap on sign in
    When I sign in as a user with more than one profile
    Then I should see who is watching screen

  Scenario: Add Profile from The Who is Watching? Screen
    Given I tap on sign in
    And I sign in as a user with more than one profile
    When I tap on add profile from who is watching screen
    Then I should be taken to add profile screen

  Scenario: User with More than 1 Profile - Edit
    Given I tap on sign in
    And I sign in as a user with more than one profile
    When I tap on Edit from who is watching screen
    Then I should be taken to Manage Profiles from Who is watching

  Scenario: Who is Watching? - Mobile App
    Given I login using adlite account
    When I navigate to Account screen and select a profile
    And I close and relaunch the app
    Then The profile selected should be same I was using in my last session

  Scenario:  User with 5 Profiles (Max) - Hide Add Profile button
    Given I login with account which has 5 profiles
    When I am on who is watching screen with 5 profiles
    Then The Add Profile button should be hidden on who is watching screen
