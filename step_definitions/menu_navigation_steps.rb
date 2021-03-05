And("I go to the {string} screen") do |option|
  @base_screen = BaseScreen.new
  # rubocop:disable Custom/SleepCop.
  # page elements are taking time to load
  sleep 5
  case option
  when "Home"
    expect(@base_screen.home_icon.displayed?).to be_truthy
    @base_screen.home_icon.click

  when "Shows"
    expect(@base_screen.shows_icon.displayed?).to be_truthy
    @base_screen.shows_icon.click

  when "My List"
    expect(@base_screen.my_list_icon.displayed?).to be_truthy
    @base_screen.my_list_icon.click

  when "Search"
    expect(@base_screen.search_icon.displayed?).to be_truthy
    @base_screen.search_icon.click

  when "Account"
    expect(@base_screen.account_icon.displayed?).to be_truthy
    @base_screen.account_icon.click
  end
  # rubocop:enable Custom/SleepCop.
end

And("I see {string} screen") do |option|
  @base_screen = BaseScreen.new
  # rubocop:disable Custom/SleepCop.
  # page elements are taking time to load
  sleep 5
  case option
  when "Home"
    expect(@base_screen.home_icon.displayed?).to be_truthy

  when "Shows"
    expect(@base_screen.shows_icon.displayed?).to be_truthy

  when "My List"
    expect(@base_screen.my_list_icon.displayed?).to be_truthy

  when "Search"
    expect(@base_screen.search_icon.displayed?).to be_truthy

  when "Account"
    expect(@base_screen.account_icon.displayed?).to be_truthy
  end
  # rubocop:enable Custom/SleepCop.
end

Given("I am on {string} screen") do |menu_option|
  @base_screen = BaseScreen.new
  @home_screen = HomeScreen.new
  @search_screen = SearchScreen.new

  case menu_option
  when "Home"
    @home_screen.wait_until(30) { expect(@home_screen.home_hero.displayed?).to be_truthy }

  when "Shows"
    @base_screen.wait_until(30) { expect(@base_screen.shows_screen_title.displayed?).to be_truthy }

  when "My List"
    @base_screen.wait_until(30) { expect(@base_screen.my_list_icon.attribute("selected")).to be_truthy }

  when "Search"
    @search_screen.wait_until(30) { expect(@search_screen.search_text_field.displayed?).to be_truthy }

  when "Account"
    @base_screen.wait_until(30) { expect(@base_screen.settings_title.displayed?).to be_truthy }
  end
end

Then("I validate menu bar is present") do
  @base_screen = BaseScreen.new
  @base_screen.wait_until(30) { expect(@base_screen.menu_bar.displayed?).to be_truthy }
end

Then("I click on any icons and should see that the icon I chose is clearly in selected state") do
  @base_screen = BaseScreen.new
  step "I go to the 'Home' screen"
  expect(@base_screen.home_icon.attribute("selected")).to be_truthy
  step "I go to the 'Shows' screen"
  expect(@base_screen.shows_icon.attribute("selected")).to be_truthy
  step "I go to the 'My List' screen"
  expect(@base_screen.my_list_icon.attribute("selected")).to be_truthy
  step "I go to the 'Search' screen"
  expect(@base_screen.search_icon.attribute("selected")).to be_truthy
  step "I go to the 'Account' screen"
  expect(@base_screen.account_icon.attribute("selected")).to be_truthy
end

Then("I scroll down and navigation bar should remain visible") do
  @base_screen = BaseScreen.new
  step "I go to the 'Home' screen"
  step "I scroll down"
  step "I validate menu bar is present"
  step "I go to the 'Shows' screen"
  step "I scroll down"
  step "I validate menu bar is present"
  step "I go to the 'Search' screen"
  step "I scroll down"
  step "I validate menu bar is present"
  step "I go to the 'Account' screen"
  step "I scroll down"
  step "I validate menu bar is present"
end

And("I scroll down on homepage") do
  @home_screen = HomeScreen.new
  4.times { @home_screen.scroll_down }
end

When("I tap on home link") do
  step "I go to the 'Home' screen"
end

Then("homepage should return to top") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { expect(@home_screen.homeherotitleimage.displayed?).to be_truthy }
end
