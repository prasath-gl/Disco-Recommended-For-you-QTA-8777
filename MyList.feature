Feature: My List

@Launch
Scenario: Favourites from show detail - verify show added to my list
	Given I am an auth user
	When I am on show page to add to favorites
	And I tap 'My List' button 
	And I navigate to my list page
	Then I see the show listed on the page

Scenario: Favourites shows - metadata
	Given I am an auth user
	And I see home hero
	When I am on show details page with single episode
	And I tap 'My List' button 
	And I navigate to my list page
	Then I see show name below each show thumbnail

@P1
Scenario: 'Add to My List' Button + My List Icon on Home Page
	Given I am an auth user
	When I am on home screen
	And I see cta button and add to my list 
	And I tap 'My List' button 
	And I go to the 'My List' screen
	Then I see the show listed on the page

@P1
Scenario: Favourites from show detail -  verify show removed from my list
	Given I login using adlite account
	And I add the show to my List from show details
	And I see list of shows in My list
	When I remove the show from show details
	And I navigate to my list page
	Then I should see show is removed from my list
	
@Launch @P1
  Scenario: Favourites shows - Remove show
    Given I am an auth user
    And I verify shows are present in my list page
    When I add a show and navigate to my list page
    And I remove show by tapping 3 dots button at the right corner of the show thumbnail
    Then I see particular show is removed from my list

  Scenario: My List Screen - Happy path, Favourites shows - sorting order
    Given I am an auth user
    And I verify shows are present in my list page
    When I add a new show and navigate to my list page
    And I validate sorting order
    And I select a show
    Then it is taken to that show's page  

Scenario: Empty Screen (My List) - No Shows added
    Given I am an auth user
    When I am on home screen
    And I go to the 'My List' screen
    Then I see the empty page placeholder

Scenario: Info Panel CTA
	Given I am an auth user
	When I navigate to My list and tap on info button
	And I tap on All episodes
	Then I should be taken to show details page
