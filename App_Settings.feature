Feature: Account
  
  Scenario: Account-About
    Given I am an auth user
    When I am on home screen
    And I go to account
    And I go to 'About' screen
    Then I see list of options

  Scenario: Account-Help
    Given I am an auth user
    When I am on home screen
    And I go to account
    And I go to 'Help' screen
    Then I see web view of help page

  Scenario: Push Notifications
    Given I am an auth user
    When I am on home screen
    And I go to account
    And I go to 'Settings' screen
    And I go to 'Push Notifications' screen
    Then 'Push Notifications' should be visible

  Scenario:Account-Visitor Agreement
    Given I am an auth user
    And I go to account
    And I go to 'About' screen
    And I go to 'Visitor Agreement' screen
    And 'Visitor Agreement' should be visible
    And I tap on back button
    Then 'About' should be visible

  Scenario:Account-Privacy Policy
    Given I am an auth user
    And I go to account
    And I go to 'About' screen
    And I go to 'Privacy Policy' screen
    And 'Privacy Policy' should be visible
    And I tap on back button
    Then 'About' should be visible

  Scenario:Account-Calif Do Not Sell My Info
    Given I am an auth user
    And I go to account
    And I go to 'About' screen
    And I go to 'Calif. Do Not Sell My Info' screen
    And 'Calif. Do Not Sell My Info' should be visible
    And I tap on back button
    Then 'About' should be visible

  Scenario:Account-Online Closed Captioning
    Given I am an auth user
    And I go to account
    And I go to 'About' screen
    And I go to 'Online Closed Captioning' screen
    And 'Online Closed Captioning' should be visible
    And I tap on back button
    Then 'About' should be visible

 Scenario:Account-App Information
    Given I am an auth user
    When I am on home screen
    And I go to account
    And I go to 'About' screen
    Then I should be able to see app info
    
  Scenario:User click on back button from About
    Given I am an auth user
    And I go to account
    And I go to 'About' screen
    And I tap on back button
    Then I am on 'Account' screen

  @P1
  Scenario: Account, Settings, Help, About and Sign Out tabs on account screen 
    Given I am an auth user
    And I go to account
    Then I should see the following tabs - Account, Settings, Help, About and Sign Out

  @P1
  Scenario: Clicking on account option from account screen
    Given I am an auth user
    And I go to account
    Then I am on 'Account' screen

  @P1
  Scenario: User navigates to manage profile screen from account screen
    Given I am an auth user
    And I go to account
    And I go to 'Manage Profile' screen
    Then 'Manage Profile' should be visible

  @P1
  Scenario: User navigates to settings screen from account screen
    Given I am an auth user
    And I go to account
    And I go to 'Settings' screen
    Then 'Settings' should be visible
