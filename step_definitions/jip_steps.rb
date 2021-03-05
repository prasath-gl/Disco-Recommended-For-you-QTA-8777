When("I am on JIP channel show details screen") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:jip_show_name_atv])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
end

And("I click on JIP channel tile under channel tab") do
  step "the 'channel' tab is selected"
  @show_screen = ShowScreen.new
  @show_screen.episode_image.first.click
end

Then("I shouldn't see any metadata other than progress bar and cc") do
  @video_screen = VideoScreen.new
  @jip_screen = JipScreen.new
  expect(@video_screen.seek_bar.displayed?).to be_truthy
  expect(@video_screen.cc_button.displayed?).to be_truthy
  expect(@jip_screen.jip_video_desc.size.positive?).to be_falsey
  expect(@jip_screen.jip_video_metadata.size.positive?).to be_falsey
end

Then("I see there is no player control button in this player") do
  @jip_screen = JipScreen.new
  expect(@jip_screen.jip_pause_button.size.positive?).to be_falsey
  expect(@jip_screen.jip_play_button.size.positive?).to be_falsey
  expect(@jip_screen.jip_forward_button.size.positive?).to be_falsey
  expect(@jip_screen.jip_rewind_button.size.positive?).to be_falsey
end

Then("Live stream plays without any issue") do
  @jip_screen = JipScreen.new
  @jip_screen.wait_until(30) { @jip_screen.jip_progress_bar.displayed? }
end

Then("I should see hero image,title,description, channel and network logo on show details page") do
  @playlist_screen = PlaylistScreen.new
  @jip_screen = JipScreen.new
  @shows_screen = ShowScreen.new
  expect(@playlist_screen.my_list_icon.displayed?).to be_truthy
  expect(@jip_screen.genres_txt.displayed?).to be_truthy
  expect(@shows_screen.show_description.displayed?).to be_truthy
  expect(@shows_screen.show_hero_title.displayed?).to be_truthy
  expect(@jip_screen.hero_image.displayed?).to be_truthy
  expect(@shows_screen.show_page_network_logo.displayed?).to be_truthy
end

Then("I should not see Watch now CTA button on show details page") do
  @video_screen = VideoScreen.new
  expect(@video_screen.watch_now_list.size.positive?).to be_falsey
end

Then("Ordering and regions of the show should be channel,extras and about the show") do
  @shows_screen = ShowScreen.new
  @jip_screen = JipScreen.new
  @video_screen = VideoScreen.new
  expect(@shows_screen.channel_tab.displayed?).to be_truthy
  @shows_screen.channel_tab.click
  expect(@jip_screen.clickable_container.displayed?).to be_truthy
  expect(@video_screen.extra_clips.displayed?).to be_truthy
  @video_screen.extra_clips.click
  expect(@jip_screen.clickable_container.displayed?).to be_truthy
  expect(@shows_screen.details_tab.displayed?).to be_truthy
  @shows_screen.details_tab.click
  expect(@shows_screen.list_of_shows.size.positive?).to be_truthy
  expect(@shows_screen.info_modal_desc.displayed?).to be_truthy
  expect(@shows_screen.categories_details.displayed?).to be_truthy
end

When("I play the channel from show details screen") do
  @shows_screen = ShowScreen.new
  @jip_screen = JipScreen.new
  expect(@shows_screen.channel_tab.displayed?).to be_truthy
  @shows_screen.channel_tab.click
  expect(@jip_screen.clickable_container.displayed?).to be_truthy
  @jip_screen.clickable_container.click
end

Then("I should not see the metadata on show details page") do
  @video_screen = VideoScreen.new
  expect(@video_screen.more_episodes_text.displayed?).to be_truthy
  expect(@video_screen.video_episode_name.displayed?).to be_truthy
  expect(@video_screen.video_container.displayed?).to be_truthy
end
