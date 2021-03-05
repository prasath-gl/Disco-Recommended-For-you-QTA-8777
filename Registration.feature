@wip
Feature: Registration
 
 @P1
 Scenario: Password instructions
  Given I navigate to create account screen
  Then I see password instructions under password field

 @P1
 Scenario: Create Account - Email and password format not valid
  Given I navigate to create account screen
  When I enter email id that is not valid
  And I see error message below 'email' text box
  And I enter password that does not meet requirement
  Then I see error message below 'password' text box

 Scenario: Create Account - Unhappy Path - Empty Fields
  Given I navigate to create account screen
  And I left all input text fields empty
  When I tap on Agree & Continue
  Then I should see a valid inline error message under username and password fields
  And I should be on the create account screen

 Scenario: Keypad open and hide
  Given I navigate to create account screen
  And I tap on create account username input text field
  And The keyboard should be enabled
  When I enter the username, password and tap on outside of the keyboard
  Then The keyboard should be hidden
  And I should see create account screen with characters entered in username and password fields
