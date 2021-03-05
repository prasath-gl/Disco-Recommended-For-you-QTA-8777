Feature: Login affiliates

@Launch @P0
Scenario: Successful Sign in
    Given I am on welcome screen
    When I tap on 'Sign In'
    When I enter the email and password associated with my Discovery+ account
    Then I am on home screen

 @P1
 Scenario: Welcome Screen
    Given I am on welcome screen
    Then I validate welcome screen features

@P1@P0
Scenario: Plan Picker screen - Visual elements
    Given I am on welcome screen
    When I tap on 'Start Free Trial'
    Then I am on plan picker screen

@P1
Scenario: Plan Picker screen - Plan pre-selection
    Given I am on welcome screen
    When I tap on 'Start Free Trial'
    Then  I choose 'Limited Ads' plan
    And I tap on 'Continue'
    Then I am on create account screen

@P1
Scenario: Plan Picker screen - No Ads plan
    Given I am on welcome screen
    When I tap on 'Start Free Trial'
    Then I choose 'No Ads' plan
    And I tap on 'Continue'
    Then I am on create account screen

@P0
Scenario: Welcome Screen - Sign In
    Given I am on welcome screen
    When I tap on 'Sign In'
    Then I shall be taken to Sign In screen

@P1
Scenario: Welcome Screen - Relaunch case 1
    Given I am on welcome screen
    When Run app in background for few seconds and relaunch the app
    Then I am on welcome screen

@P1
Scenario: Welcome Screen - Relaunch case 2
    Given I am on welcome screen
    When I tap on 'Sign In'
    And Run app in background for few seconds and relaunch the app
    Then I shall be taken to Sign In screen

@P1
Scenario: Free trials
    Given I am on welcome screen
    When I tap on 'Start Free Trial'
    And I am informed of free trial
    And I tap on 'Continue'
    Then I am on create account screen

Scenario: Back button behavior
    Given I am on welcome screen
    When I tap on 'Start Free Trial'
    And I am on plan picker screen
    And I tap on device back
    Then I am on welcome screen

Scenario: Email ID field blank
    Given I am on welcome screen
    When I tap on 'Sign In'
    And I focus on 'email' text field
    And I change focus to 'password'
    Then I get 'email' error

Scenario: Password field blank
    Given I am on welcome screen
    When I tap on 'Sign In'
    And I focus on 'password' text field
    And I change focus to 'email'
    Then I get 'password' error 

@P1
Scenario: Forgot Password link - Sign In screen
    Given I am on welcome screen
    When I tap on 'Sign In'
    And I tap on 'Forgot Password'
    Then I shall be taken to reset password screen

Scenario: Resetting password - Unhappy path
    Given I am on reset password screen
    When I enter invalid email address for resetting password
    Then I see error message below 'email' text box

@P1
Scenario: Happy Path - Sign Out, , User taps on "sign out" on account sceen 
    Given I am an auth user
    When I go to account
    And I should click on sign out button
    And I should see a warning
    And I should see and click on 'Yes' button
    Then I am on welcome screen

@P0
Scenario: Sign-out & Sign-in immediately
    Given I am an auth user
    When I go to account
    And I should click on sign out button
    And I should see a warning
    And I should see and click on 'Yes' button
    Then I am on welcome screen
    Given I am an auth user

Scenario: Forgot Password link - Sign In screen
    Given I am on welcome screen
    When I tap on 'Sign In'
    And I tap on 'Continue'
    And I should see a invalid email error message
    And I should see a invalid password error message
    And I enter invalid email address in sign in screen
    Then I see error message below 'email' text box

@P1
Scenario: Unsuccessful Sign In - Incorrect Email or Password
    Given I am on welcome screen
    When I tap on 'Sign In'
    And I enter valid email address and invalid password
    And I tap on 'Continue'
    Then I should then see an error message with signup and tryagain button

Scenario: Manage account - update invalid email address
  Given I am an auth user
  When I am on manage account screen
  And I update invalid email address in manage account screen
  Then I see error message below 'email' text box

Scenario: Manage account - update same email address
  Given I am an auth user
  When I am on manage account screen
  And I update same email address in manage account screen
  Then I should be shown an error to inform me that the email entered is wrong
