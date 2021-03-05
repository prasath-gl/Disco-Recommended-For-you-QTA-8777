And("I validate info modal") do
  @playlist_screen = PlaylistScreen.new
  @shows_screen = ShowScreen.new
  step "I see show hero on top"
  @home_screen.scroll_down
  @shows_screen.more_episode_desc.first.click
  expect(@playlist_screen.info_modal.displayed?).to be_truthy
  expect(@shows_screen.info_modal_desc.displayed?).to be_truthy
  expect(@playlist_screen.info_modal_cta_btn.displayed?).to be_truthy
end

And("I tap outside the modal") do
  @playlist_screen = PlaylistScreen.new
  @playlist_screen.device_back
end

Then("I see info modal closes") do
  step "I see episode list in the season"
end

And("I tap on 'Watch Now' button on info modal") do
  @playlist_screen = PlaylistScreen.new
  @playlist_screen.wait_until(30) { @playlist_screen.info_modal_cta_btn.displayed? }
  @playlist_screen.info_modal_cta_btn.click
end

And("I see playlist metadata on hero") do
  @playlist_screen = PlaylistScreen.new
  @shows_screen = ShowScreen.new
  expect(@shows_screen.show_hero_image.displayed?).to be_truthy
  expect(@playlist_screen.playlist_title.displayed?).to be_truthy
end

Then("I navigate to {string} rail with tiles") do |header_title|
  @home_screen = HomeScreen.new
  @home_screen.scroll_to_episode(header_title)
  @home_screen.scroll_down if @home_screen.rail_section_title.displayed?
end

Then("I see {string} curated rail metadata") do |carousel|
  @playlist_screen = HomeScreen.new
  max_swapping_round = 3
  start_tile_index = 1
  step "I scroll to '#{carousel}' rail"
  start_x = @playlist_screen.carousel_header_desc(carousel).location.x + 600
  start_y = @playlist_screen.carousel_header_desc(carousel).location.y + 500
  end_x = start_x - 400
  end_y = start_y
  (1..max_swapping_round).each do |_i|
    expect(@playlist_screen.just_added_tiles(carousel, start_tile_index).displayed?).to be_truthy
    expect(@playlist_screen.just_added_tiles(carousel, start_tile_index + 1).displayed?).to be_truthy
    expect(@playlist_screen.carousel_tile_name(carousel).displayed?).to be_truthy
    @playlist_screen.scroll_by_coordinates(start_x, start_y, end_x, end_y)
  end
end

And("I tap on any tile in the curated list") do
  @playlist_screen = PlaylistScreen.new
  @playlist_screen.wait_until(30) { @playlist_screen.curated_rail_tile.displayed? }
  @playlist_screen.curated_rail_tile.click
end

Then("I am back to home screen") do
  @home_screen = HomeScreen.new
  expect(@home_screen.home_icon.attribute("selected")).to be_truthy
end

When("I am on playlist landing screen") do
  step "I am on home screen"
  step "Validating 'discovery+ Collections' rail tiles on home screen"
  step "I tap on any tile in the curated list"
end

Then("I see metadata on playlist tiles") do
  @playlist_screen = ShowScreen.new
  expect(@playlist_screen.episode_name.size.positive?).to be_truthy
  expect(@playlist_screen.episode_duration.size.positive?).to be_truthy
  expect(@playlist_screen.episode_image.size.positive?).to be_truthy
  expect(@playlist_screen.more_episode_desc.size.positive?).to be_truthy
end

Then("I see cta button and add to my list") do
  step "I go to the 'My List' screen"
  step "I remove the shows from my list"
  step "I go to the 'Home' screen"
  @home_screen = HomeScreen.new
  @playlist_screen = PlaylistScreen.new
  @home_screen.wait_until(30) { expect(@home_screen.cta_button.displayed?).to be_truthy }
  @playlist_screen.wait_until(30) { expect(@playlist_screen.my_list_icon.displayed?).to be_truthy }
end

Then("I see a page with no shows message") do
  @playlist_screen = PlaylistScreen.new
  expect(@playlist_screen.my_list_cta_btn.displayed?).to be_truthy
  expect(@playlist_screen.no_shows_msg.displayed?).to be_truthy
end

Then("I scroll to {string} rail") do |carousel|
  @home_screen = HomeScreen.new
  length = 2
  height = driver.window_size.height / 2
  y = @home_screen.rail_header_name(carousel).location.y
  if y > height
    (1..length).each do |_i|
      start_x = driver.window_size.width / 2
      start_y = (driver.window_size.height / 2) + 150
      end_x = driver.window_size.width / 2
      end_y = driver.window_size.height / 2
      @home_screen.scroll_by_coordinates(end_x, start_y, start_x, end_y)
    end
  end
end
