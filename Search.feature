Feature: Search Screen

Scenario: Search 
  Given I am an auth user
  When I go to the 'Search' screen
  Then I enter a shown name in search text field
  
Scenario: Search- keypad display on tapping search box 
  Given I am an auth user
  When I go to the 'Search' screen
  And I tap on search bar
  Then I see keypad is enabled

@Launch
Scenario: Search - No results found
  Given I am an auth user
  When I go to the 'Search' screen
  And I type 'aaaaa' in search text field
  Then I see No results found text

@Launch @P1
Scenario: Verify Search result auto population
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 days' in search text field
  And keypad should be hidden
  Then I see search results on the screen

Scenario: Search - Search clearing text using keypad "X" button
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 days' in search text field
  When I tap on 'x' button in search text field
  Then I see text entered in the search bar is cleared

Scenario: Verify Search Help Text field in Search Box 
  Given I am an auth user
  When I go to the 'Search' screen
  And I tap on search bar
  Then I see 'Search for shows, episodes and more' Help text in the search bar

Scenario: Search - Results navigation (show) 
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 days' in search text field
  And I see sub-nav 'Shows' is highlighted
  When I tap on any show in the result
  And I see shows detail page
  And I tap on back arrow button
  Then I see sub-nav 'Shows' is highlighted

@P1
Scenario: Search Page 
  Given I am an auth user
  When I go to the 'Search' screen
  Then Validating different rails on search screen

Scenario: Search - Results Metadata (shows rail)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I see sub-nav 'Shows' is highlighted
  Then I see metadata

Scenario: Search - Hide keypad - on scrolling
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 days' in search text field
  And I scroll till end of the screen
  Then keypad should be hidden

Scenario: Search - Warm Start rails (metadata)
  Given I am an auth user
  When I go to the 'Search' screen
  Then Validating different rails metadata on search screen

Scenario: Search- Verify 'x' on search box
  Given I am an auth user
  When I go to the 'Search' screen
  And I type 'aaaaa' in search text field
  Then I see X button on search bar

Scenario: Search bar is selected - Warm Start rails
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  Then the warm start rails should disappear

Scenario: Search bar is unselected - Warm Start rails
  Given I am an auth user
  When I go to the 'Search' screen
  And The search bar is empty and not selected
  Then Validating different rails metadata on search screen

Scenario: Search - Results Metadata (Episodes)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I see sub-nav 'Episodes' is highlighted
  Then I see episode tab metadata

@wip
Scenario: Search - Results Metadata (Clips)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type 'kidnap' in search text field
  And I see sub-nav 'Extras' is highlighted
  Then I see episode tab metadata

Scenario: Search - Warm Start rails (tap on thumbnail)
  Given I am an auth user
  When I go to the 'Search' screen
  Then tapping on thumbnail of different rails on search page and validate

Scenario: Grid results lazy load
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I see sub-nav 'Shows' is highlighted
  Then I scroll multiple times and see more results appear

Scenario: Search - Results Metadata (Collection)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I see sub-nav 'Collections' is highlighted
  Then I see playlist metadata

Scenario: Search - Tap on thumbnail (Collection)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I see sub-nav 'Collections' is highlighted
  And I tap on any playlist thumbnail
  Then I see metadata on playlist tiles

Scenario: Search - back button
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I tap on device back
  Then keypad should be hidden

Scenario: Search - Hide keypad - on taping search
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 days' in search text field
  And I tap on done using keypad
  Then keypad should be hidden

Scenario: Search - result update on delete one letter
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 days' in search text field
  And I delete one letter
  Then I see sub-nav 'Shows' is highlighted

Scenario: Search - Search/enter using keypad
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 days' in search text field
  And I tap on done using keypad
  Then I see search results on the screen

Scenario: Search - Results Metadata (Specials)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I see sub-nav 'Specials' is highlighted
  Then I see episode tab metadata

@P1
Scenario: Tab without results
  Given I am an auth user
  When I go to the 'Search' screen
  And I type 'Ala' in search text field
  And I see results for shows and episodes tab
  Then I see results for specials that does not match the query

Scenario: Fuzzy search(spell correct)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type 'Alasak' in search text field
  Then results appear with correct spelling 'Alaska'

Scenario: Correct metadata
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I see sub-nav 'Episodes' is highlighted
  And I see episode tab metadata
  And I see sub-nav 'Collections' is highlighted
  Then I see playlist metadata

Scenario: Search - Tap on thumbnail (Specials)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I see sub-nav 'Specials' is highlighted
  And I click on first show from episode list
  Then video plays in portrait mode by default

@P1
Scenario: Search - Tap on thumbnail (Extras)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type 'kidnap' in search text field
  And I see sub-nav 'Extras' is highlighted
  And I click on first show from episode list
  Then video plays in portrait mode by default

@P1
Scenario: Search - Results navigation & play (episode)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type '90 Days' in search text field
  And I see sub-nav 'Episodes' is highlighted
  And I click on first show from episode list
  And video plays in portrait mode by default
  Then I see respective episode playing

@P1
Scenario: Search - Playlist Search (tap on thumbnail)
  Given I am an auth user
  When I go to the 'Search' screen
  And I type 'renovation realities on HGTV' in search text field
  And I see sub-nav 'Collections' is highlighted
  And I click on first show from Collections list
  Then I see home hero on detail view screen