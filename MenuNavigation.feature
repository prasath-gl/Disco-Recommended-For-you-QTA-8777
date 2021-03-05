Feature: Menu Navigation 
  @P1
  Scenario: Home 
    Given I am an auth user
    When I go to the 'Home' screen
    Then I am on 'Home' screen
  
  Scenario: Shows
   Given I am an auth user
   When I go to the 'Shows' screen
   Then I am on 'Shows' screen

  Scenario: My List
    Given I am an auth user
    When I go to the 'My List' screen
    Then I am on 'My List' screen

  @P1
  Scenario: Navigation bar
    Given I am an auth user
    When I validate menu bar is present
    And I see "Home" screen
    And I see "Shows" screen
    And I see "My List" screen
    And I see "Search" screen
    Then I see "Account" screen

  Scenario: Search 
    Given I am an auth user
    When I go to the 'Search' screen
    Then I am on 'Search' screen
    
  Scenario: Settings  
    Given I am an auth user 
    When I go to the 'Account' screen
    Then I am on 'Account' screen

  Scenario: Navigates to Home from Shows page
    Given I am an auth user
    When I go to the 'Shows' screen
    And I go to the 'Home' screen
    Then I am on 'Home' screen

  Scenario: Navigates to Search from Shows page
    Given I am an auth user
    When I go to the 'Shows' screen
    And I go to the 'Search' screen
    Then I am on 'Search' screen

  Scenario: Navigates to Account from Shows page
    Given I am an auth user
    When I go to the 'Shows' screen
    And I go to the 'Account' screen
    Then I am on 'Account' screen

  Scenario: Navigates to Home from Search page
    Given I am an auth user
    When I go to the 'Search' screen
    And I go to the 'Home' screen
    Then I am on 'Home' screen

  Scenario: Navigates to Shows from Search page
    Given I am an auth user
    When I go to the 'Search' screen
    And I go to the 'Shows' screen
    Then I am on 'Shows' screen

  Scenario: Navigates to Account from Search page
    Given I am an auth user
    When I go to the 'Search' screen
    And I go to the 'Account' screen
    Then I am on 'Account' screen

  Scenario: Navigates to Home from Account page
    Given I am an auth user
    When I go to the 'Account' screen
    And I go to the 'Home' screen
    Then I am on 'Home' screen

  Scenario: Navigates to Shows from Account page
    Given I am an auth user
    When I go to the 'Account' screen
    And I go to the 'Shows' screen
    Then I am on 'Shows' screen

  Scenario: Navigates to Search from Account page
    Given I am an auth user
    When I go to the 'Account' screen
    And I go to the 'Search' screen
    Then I am on 'Search' screen

  Scenario: Navigates to Home from My List page
    Given I am an auth user
    When I go to the 'My List' screen
    And I go to the 'Home' screen
    Then I am on 'Home' screen

  Scenario: Navigates to Shows from My List page
    Given I am an auth user
    When I go to the 'My List' screen
    And I go to the 'Shows' screen
    Then I am on 'Shows' screen

  Scenario: Navigates to Search from My List page
    Given I am an auth user
    When I go to the 'My List' screen
    And I go to the 'Search' screen
    Then I am on 'Search' screen

  Scenario: Navigates to Account from My List page
    Given I am an auth user
    When I go to the 'My List' screen
    And I go to the 'Account' screen
    Then I am on 'Account' screen

  Scenario: Navigates to My List from Home Page
    Given I am an auth user
    When I go to the 'Home' screen
    And I go to the 'My List' screen
    Then I am on 'My List' screen

  Scenario: Navigates to My List from Shows page
    Given I am an auth user
    When I go to the 'Shows' screen
    And I go to the 'My List' screen
    Then I am on 'My List' screen

  Scenario: Navigates to My List from Search page
    Given I am an auth user
    When I go to the 'Search' screen
    And I go to the 'My List' screen
    Then I am on 'My List' screen

  Scenario: Navigates to My List from Account page
    Given I am an auth user
    When I go to the 'Account' screen
    And I go to the 'My List' screen
    Then I am on 'My List' screen

  Scenario: Navigation icons - Selected state/Unselected state
    Given I am an auth user
    When I am on home screen
    Then I click on any icons and should see that the icon I chose is clearly in selected state

  Scenario: Navigation bar visibility
    Given I am an auth user
    When I am on home screen
    Then I scroll down and navigation bar should remain visible

  Scenario: Navigation Bar remains visible during scroll
    Given I am an auth user
    When I am on home screen
    And I scroll down
    Then I validate menu bar is present

  Scenario: Clicking on homepage from homepage
    Given I am an auth user
    And I am on home screen
    When I scroll down on homepage
    And I tap on home link
    Then homepage should return to top

  Scenario: Clicking on MyList link from MyList page
    Given I am an auth user
    When I go to the 'My List' screen
    And I scroll down
    And I go to the 'My List' screen
    Then My list page should return to top