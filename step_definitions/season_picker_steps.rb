Given("I am on show with multiple season page") do
  step "I go to the 'Shows' screen"
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { @shows_screen.list_of_shows.size.positive? }
  shows_size = @shows_screen.list_of_shows.size
  (0..shows_size).each do |i|
    @shows_screen.list_of_shows[i].click
    total_seasons = @shows_screen.listed_seasons.size
    if total_seasons > 1
      puts "Seasons available"
      break
    else
      @shows_screen.back_arrow.click
    end
  end
end

When("I see the season numbers listed") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.season_picker_rail.displayed?).to be_truthy }
end

Then("I see seasons are in default hierarchy order of newest to oldest") do
  @shows_screen = ShowScreen.new
  latest_season = @shows_screen.listed_seasons[0].text.gsub("Season", "").strip.to_i
  total_seasons = @shows_screen.listed_seasons.size
  (1..total_seasons - 1).each do |season|
    next_season = @shows_screen.listed_seasons[season].text.gsub("Season", "").strip.to_i
    expect(latest_season < next_season).to be_truthy
    latest_season = next_season
  end
end

When("I select any of the available seasons") do
  @shows_screen = ShowScreen.new
  @shows_screen.season_picker_rail.click
  available_seasons = @shows_screen.listed_seasons.size
  to_select_season = 0
  if available_seasons > 1
    @selected_season = @shows_screen.listed_seasons[to_select_season + 1].text.gsub("S", "").strip.to_i
    @shows_screen.listed_seasons[to_select_season].click
  else
    @selected_season = @shows_screen.listed_seasons[to_select_season].text.gsub("S", "").strip.to_i
  end
end

When("I see episodes in order of newest episode to oldest episode for that season") do
  @shows_screen = ShowScreen.new
  step "I see show hero on top"
  @shows_screen.scroll_to_traves_complete_episode_list
  selected_season = @shows_screen.season_picker_rail.text.gsub("Season", "").strip.to_i
  latest_episode = @shows_screen.episode_number[0].text.gsub("S#{selected_season} E", "").strip.to_i
  total_episodes = @shows_screen.episode_number.size
  (1..total_episodes - 1).each do |episode|
    next_episode = @shows_screen.episode_number[episode].text.gsub("S#{selected_season} E", "").strip.to_i
    expect(latest_episode < next_episode).to be_truthy
    latest_episode = next_episode
  end
end

When("I see corresponding season is in selected state") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.selected_state_season(@selected_season).displayed?).to be_truthy }
  is_selected_season = @shows_screen.selected_state_season(@selected_season).attribute("selected")
  expect(is_selected_season).to be_truthy
end

When("I see season listed first in the seasons list is selected by Default") do
  @shows_screen = ShowScreen.new
  is_selected = @shows_screen.listed_seasons[0].attribute("selected")
  expect(is_selected).to be_truthy
end

Then("I scroll season picker to verify more seasons and season order") do
  @shows_screen = ShowScreen.new
  screen_seasons = @shows_screen.listed_seasons.size
  seasons = []
  store_index = 0
  (0..screen_seasons - 1).each do |i|
    seasons[store_index] = @shows_screen.listed_seasons[i].text.gsub("S", "").strip.to_i
    @shows_screen.listed_seasons[i].click
    @shows_screen.listed_seasons[i].attribute("selected")
    store_index += 1
  end
  available_seasons = seasons.uniq
  (0..available_seasons.size - 2).each do |season_index|
    expect(available_seasons[season_index] > available_seasons[season_index + 1]).to be_truthy
  end
end

When("the {string} tab is selected") do |tab_name|
  @shows_screen = ShowScreen.new
  case tab_name
  when "episodes"
    expect(@shows_screen.episode_tab.displayed?).to be_truthy
    expect(@shows_screen.episode_tab.attribute("selected")).to be_truthy
  when "details"
    expect(@shows_screen.details_tab.displayed?).to be_truthy
    @shows_screen.details_tab.click
    expect(@shows_screen.details_tab.attribute("selected")).to be_truthy
  when "channel"
    expect(@shows_screen.channel_tab.displayed?).to be_truthy
    @shows_screen.channel_tab.click
    expect(@shows_screen.channel_tab.attribute("selected")).to be_truthy
  end
end

Then("I see the latest season selected in the season dropdown") do
  @shows_screen = ShowScreen.new
  @shows_screen.seasons_dropdown.click
  step "I see season listed first in the seasons list is selected by Default"
end

And("I tap on season dropdown") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.seasons_dropdown.displayed?).to be_truthy
  @shows_screen.seasons_dropdown.click
end

And("I see season panel slides up") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.season_panel.displayed?).to be_truthy
end

And("I tap on another season") do
  @shows_screen = ShowScreen.new
  available_seasons = @shows_screen.listed_seasons.size
  to_select_season = 0
  if available_seasons > 1
    @selected_season = @shows_screen.listed_seasons[to_select_season + 1].text
    @shows_screen.listed_seasons[to_select_season + 1].click
  else
    @selected_season = @shows_screen.listed_seasons[to_select_season].text
  end
end

Then("I see selected season is displayed in the selector") do
  @shows_screen = ShowScreen.new
  season_displayed = @shows_screen.season_picker_rail.text
  expect(season_displayed == @selected_season).to be_truthy
end

Then("I shall see the details metadata") do
  @shows_screen = ShowScreen.new
  @home_screen = HomeScreen.new
  expect(@shows_screen.details_tab.displayed?).to be_truthy
  @home_screen.scroll_down
  expect(@shows_screen.episode_name.size.positive?).to be_truthy
  expect(@shows_screen.info_modal_desc.displayed?).to be_truthy
  expect(@shows_screen.categories_details.displayed?).to be_truthy
end
