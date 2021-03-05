When(/^I enter a shown name in search text field$/) do
  @search_screen = SearchScreen.new
  expect(@search_screen.search_text_field.displayed?).to be_truthy
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:search_string_atv])
end

Then("I click on searched episode") do
  @search_screen = SearchScreen.new
  expect(@search_screen.searched_episode.displayed?).to be_truthy
  @search_screen.searched_episode.click
end

When("I tap on search bar") do
  @search_screen = SearchScreen.new
  expect(@search_screen.search_text_field.displayed?).to be_truthy
  @search_screen.search_text_field.click
end

When("The search bar is empty and not selected") do
  @search_screen = SearchScreen.new
  expect(@search_screen.search_text_field.displayed?).to be_truthy
end

Then("I see keypad is enabled") do
  @search_screen = SearchScreen.new
  expect(@search_screen.driver.is_keyboard_shown).to be_truthy
  @search_screen.driver.hide_keyboard
end

When("I type {string} in search text field") do |text|
  @search_screen = SearchScreen.new
  @search_screen.search_text_field.clear
  @search_screen.search_text_field.send_keys(text)
  @search_screen.scroll_down
end

Then("I see No results found text") do
  @search_screen = SearchScreen.new
  expect(@search_screen.no_result_found.displayed?).to be_truthy
end

Then("keypad should be hidden") do
  @search_screen = SearchScreen.new
  @search_screen.driver.hide_keyboard
  expect(@search_screen.driver.is_keyboard_shown).to be_falsy
end

And("I tap on 'x' button in search text field") do
  @search_screen = SearchScreen.new
  expect(@search_screen.clear_text.displayed?).to be_truthy
  8.times { @search_screen.device_clear }
end

Then("I see text entered in the search bar is cleared") do
  @search_screen = SearchScreen.new
  expect(@search_screen.search_help_text.displayed?).to be_truthy
end

Then("I see 'Search for shows, episodes and more' Help text in the search bar") do
  @search_screen = SearchScreen.new
  expect(@search_screen.search_help_text.displayed?).to be_truthy
end

And("I tap on any show in the result") do
  @search_screen = SearchScreen.new
  step "keypad should be hidden"
  @search_screen.tap_by_coordinates(193, 595)
end

Then("I see shows detail page") do
  @search_screen = SearchScreen.new
  expect(@search_screen.search_show_hero.displayed?).to be_truthy
end

Then("I see metadata") do
  @search_screen = SearchScreen.new
  expect(@search_screen.searched_result_image.size.positive?).to be_truthy
  expect(@search_screen.searched_result_title.size.positive?).to be_truthy
  expect(@search_screen.searched_result_network_logo.size.positive?).to be_truthy
end

Then("I tap on any episode in the result") do
  @search_screen = SearchScreen.new
  step "keypad should be hidden"
  @search_screen.searched_result_image("Episodes").first.click
end

Then("Validating different rails on search screen") do
  @home_screen = HomeScreen.new
  rails = ["Trending Shows", "New Episodes"]
  scroll_count = 0
  loop do
    @carousel_name = @home_screen.rail_section_title.text
    if rails.include?(@carousel_name)
      puts "Validating Search screen rail as: #{@carousel_name}"

      @home_screen.scroll_down
    else
      puts "#{@carousel_name}: rail is not under validation"
    end
    scroll_count += 1
    break if scroll_count == 5
  end
end

Then("Validating different rails metadata on search screen") do
  @search_screen = SearchScreen.new
  rails = ["Trending Shows", "New Episodes"]
  rails.each do |val|
    expect(@search_screen.search_rails(val).size.positive?).to be_truthy
    case val
    when "Trending Shows"
      expect(@search_screen.searched_result_image.size.positive?).to be_truthy
      expect(@search_screen.searched_result_title.size.positive?).to be_truthy
      expect(@search_screen.searched_result_network_logo.size.positive?).to be_truthy
    when "New Episodes"
      expect(@search_screen.searched_result_image.size.positive?).to be_truthy
      expect(@search_screen.searched_result_title.size.positive?).to be_truthy
      expect(@search_screen.searched_result_network_logo.size.positive?).to be_truthy
    end
    puts("Metadata validated for #{val}")
    @search_screen.scroll_down
  end
end

Then("tapping on thumbnail of different rails on search page and validate") do
  @search_screen = SearchScreen.new
  @home_screen = HomeScreen.new
  rails = ["Trending Shows"]
  rails.each do |val|
    @home_screen.scroll_to_episode(val)
    @search_screen.search_result_image(val).first.click
    case val
    when "Trending Shows"
      step "I see show hero on top"
      step "I tap on back arrow button"
    when "New Episodes"
      step "video plays in portrait mode by default"
      step "I tap on 'player back' button"
    end
    puts("Tap validated for: #{val}")
  end
end

Then("I see X button on search bar") do
  @search_screen = SearchScreen.new
  step "keypad should be hidden"
  expect(@search_screen.clear_text.displayed?).to be_truthy
end

And("I see sub-nav {string} is highlighted") do |sub_nav|
  @search_screen = SearchScreen.new
  case sub_nav
  when "Shows"
    expect(@search_screen.shows_search_tab.attribute("selected")).to be_truthy
  when "Episodes"
    step "keypad should be hidden"
    @search_screen.episodes_search_tab.click
    expect(@search_screen.episodes_search_tab.attribute("selected")).to be_truthy
  when "Extras"
    step "keypad should be hidden"
    # @search_screen.specials_search_tab.click
    @search_screen.extras_search_tab.click
    expect(@search_screen.episodes_search_tab.attribute("selected")).to be_truthy
  when "Collections"
    step "keypad should be hidden"
    @search_screen.playlist_search_tab.click
    expect(@search_screen.playlist_search_tab.attribute("selected")).to be_truthy
  when "Specials"
    step "keypad should be hidden"
    @search_screen.specials_search_tab.click
    expect(@search_screen.specials_search_tab.attribute("selected")).to be_truthy
  end
end

Then("I see episode tab metadata") do
  @search_screen = SearchScreen.new
  expect(@search_screen.series_title.size.positive?).to be_truthy
  expect(@search_screen.clip_title.size.positive?).to be_truthy
  expect(@search_screen.episode_info.size.positive?).to be_truthy
end

Then("the warm start rails should disappear") do
  step "I see sub-nav 'Shows' is highlighted"
  expect(@search_screen.episodes_search_tab.displayed?).to be_truthy
  expect(@search_screen.specials_search_tab.displayed?).to be_truthy
end

Then("I see search results on the screen") do
  step "I see sub-nav 'Shows' is highlighted"
  step "I see metadata"
  step "I see sub-nav 'Episodes' is highlighted"
  step "I see episode tab metadata"
end

Then("I scroll multiple times and see more results appear") do
  @shows_screen = ShowScreen.new
  step "keypad should be hidden"
  grid_num = @shows_screen.list_of_shows.size
  grid_num.times do
    step "I scroll till end of the screen"
    expect(@shows_screen.list_of_shows.size.positive?).to be_truthy
  end
end

Then("I see playlist metadata") do
  @search_screen = SearchScreen.new
  expect(@search_screen.playlist_image.size.positive?).to be_truthy
  expect(@search_screen.searched_result_title.size.positive?).to be_truthy
end

And("I tap on any playlist thumbnail") do
  @search_screen = SearchScreen.new
  @search_screen.playlist_image.first.click
end

And("I tap on done using keypad") do
  @search_screen = SearchScreen.new
  @search_screen.device_enter
end

And("I delete one letter") do
  @search_screen = SearchScreen.new
  @search_screen.device_clear
end

And("I see results for shows and episodes tab") do
  step "I see sub-nav 'Shows' is highlighted"
  step "I see metadata"
  step "I see sub-nav 'Episodes' is highlighted"
  step "I see episode tab metadata"
end

Then("I see results for specials that does not match the query") do
  @search_screen = SearchScreen.new
  step "I see sub-nav 'Specials' is highlighted"
  @first_clip_title = @search_screen.clip_title.first.text
  searched_text = @search_screen.search_text_field.text
  if @first_clip_title.include? searched_text
    puts "Results available"
  else
    puts "Results not available"
  end
end

And("I click on first show from episode list") do
  @search_screen = SearchScreen.new
  @first_episode_name = @search_screen.first_episode.first.text
  @search_screen.wait_until(30) { @search_screen.first_episode.first.displayed? }
  @search_screen.first_episode.first.click
end

Then("I see respective episode playing") do
  @video_screen = VideoScreen.new
  @video_episode_name = @video_screen.video_episode_name.text
  expect(@first_episode_name.include?(@video_episode_name)).to be_truthy
end

And("I click on first show from Collections list") do
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.show_thumbnail.first.displayed? }
  @search_screen.show_thumbnail.first.click
end

And("I see home hero on detail view screen") do
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.hero_container.displayed? }
  @search_screen.hero_container.click
end

Then("results appear with correct spelling {string}") do |spelling|
  @search_screen = SearchScreen.new
  correct_spelling = @search_screen.searched_result_title.first.text
  expect(correct_spelling.include?(spelling)).to be_truthy
end
