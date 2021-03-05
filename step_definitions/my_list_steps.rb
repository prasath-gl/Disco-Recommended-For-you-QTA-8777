Given("I am on show page to add to favorites") do
  @search_screen = SearchScreen.new
  step "I see home hero"
  step "I go to the 'Search' screen"
  expect(@search_screen.search_text_field.displayed?).to be_truthy
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:show_with_extra_clips])
  @search_screen.wait_until(30) { expect(@search_screen.search_shows_tab.displayed?).to be_truthy }
  step "I tap on any show in the result"
  step "I am on show details screen"
end

When("I tap 'My List' button") do
  @playlist_screen = PlaylistScreen.new
  @shows_screen = ShowScreen.new
  @playlist_screen.wait_until(30) { expect(@playlist_screen.my_list_icon.displayed?).to be_truthy }
  @playlist_screen.my_list_icon.click
  @show_desc = @shows_screen.show_description.text
end

And("I navigate to my list page") do
  @search_screen = SearchScreen.new
  step "I tap on device back"
  step "I go to the 'My List' screen"
end

Then("I see the show listed on the page") do
  @shows_screen = ShowScreen.new
  @shows_screen.list_of_shows.first.click
  show_added = @shows_screen.show_description.text
  expect(show_added == @show_desc).to be_truthy
end

Then("I see show is removed from my list") do
  @shows_screen = ShowScreen.new
  step "I am on 'My List' screen"
  after_removal = @shows_screen.list_of_shows.size
  expect(after_removal < @current_shows).to be_truthy
end

Then("I see show name below each show thumbnail") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.episode_image.size.positive?).to be_truthy
  expect(@shows_screen.episode_name.size.positive?).to be_truthy
  expect(@shows_screen.more_episode_desc.size.positive?).to be_truthy
end

And("I tap my list button on info modal") do
  step "I validate info modal"
  @playlist_screen.my_list_icon.click
end

When("I see list of shows in my list page") do
  @shows_screen = ShowScreen.new
  @current_shows = @shows_screen.list_of_shows.size
end

And("I verify shows are present in my list page") do
  step "I go to the 'My List' screen"
  @playlist_screen = PlaylistScreen.new
  if @playlist_screen.no_shows.size.positive?
    step "I search and select a show having multiple season"
    step "I tap 'My List' button"
    step "I tap on device back"
  else
    puts "Show is already present"
  end
end

When("I add a show and navigate to my list page") do
  step "I search and select a show having single season"
  step "I tap 'My List' button"
  step "I navigate to my list page"
end

And("I remove show by tapping 3 dots button at the right corner of the show thumbnail") do
  @shows_screen = ShowScreen.new
  @playlist_screen = PlaylistScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.list_of_shows.size.positive?).to be_truthy }
  @addedshow = @shows_screen.list_of_shows[0].text
  puts "show name after adding to my list #{@addedshow}"
  @shows_screen.wait_until(30) { expect(@shows_screen.more_episode_desc.size.positive?).to be_truthy }
  @shows_screen.more_episode_desc.first.click
  @playlist_screen.wait_until(30) { expect(@playlist_screen.my_list_icon.displayed?).to be_truthy }
  @playlist_screen.my_list_icon.click
  step "I navigate to my list page"
end

When("I see particular show is removed from my list") do
  @shows_screen.wait_until(30) { expect(@shows_screen.list_of_shows.size.positive?).to be_truthy }
  @afterremoveshowname = @shows_screen.list_of_shows[0].text
  puts "show name after removal #{@afterremoveshowname}"
  expect(@addedshow.include?(@afterremoveshowname)).to be false
end

When("I add a new show and navigate to my list page") do
  step "I search and select a show for upnext"
  step "I tap 'My List' button"
  step "I navigate to my list page"
end

When("I validate sorting order") do
  @shows_screen.wait_until(30) { expect(@shows_screen.list_of_shows.size.positive?).to be_truthy }
  @firstshowname = @shows_screen.list_of_shows[0].text
  puts "first show name #{@firstshowname}"
  expect(NETWORK_DATA.show_search[:upnextShow].include?(@firstshowname)).to be true
end

Then("it is taken to that show's page") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.show_hero_title.displayed?).to be_truthy }
  @new_show_desc = @shows_screen.show_description.text
  expect(@show_desc.include?(@new_show_desc)).to be true
end

Then("I see the empty page placeholder") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.browse_shw_btn.displayed?).to be_truthy }
  @shows_screen.wait_until(30) { expect(@shows_screen.no_saved_show.displayed?).to be_truthy }
  @shows_screen.wait_until(30) { expect(@shows_screen.tap_text.displayed?).to be_truthy }
  @shows_screen.wait_until(30) { expect(@shows_screen.tap_to_save.displayed?).to be_truthy }
end

When("My list page should return to top") do
  @shows_screen = ShowScreen.new
  step "I go to the 'My List' screen"
  @shows_screen.wait_until(30) { expect(@shows_screen.my_list_screen_title.displayed?).to be_truthy }
end

When("I navigate to My list and tap on info button") do
  step "I go to the 'My List' screen"
  step "I add show to my list"
  step "I tap on show info btn in my list"
end

And("I tap on All episodes") do
  @playlist_screen = PlaylistScreen.new
  @playlist_screen.wait_until(30) { expect(@playlist_screen.playlist_title.displayed?).to be_truthy }
  @playlist_screen.wait_until(30) { expect(@playlist_screen.networkicon.displayed?).to be_truthy }
  @playlist_screen.wait_until(30) { expect(@playlist_screen.my_list_icon.displayed?).to be_truthy }
  @playlist_screen.wait_until(30) { expect(@playlist_screen.description.displayed?).to be_truthy }
  @playlist_screen.wait_until(30) { expect(@playlist_screen.info_modal_cta_btn.displayed?).to be_truthy }
  @playlist_screen.info_modal_cta_btn.click
end

Then("I should be taken to show details page") do
  step "I am on show details screen"
end

When("I tap on show info btn in my list") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.more_episode_desc.size.positive?).to be_truthy }
  @shows_screen.more_episode_desc[0].click
end

Then("I add show to my list") do
  @shows_screen = ShowScreen.new
  unless @shows_screen.list_of_shows.size.positive?
    step "I go to the 'Home' screen"
    step "I am on show page to add to favorites"
    step "I tap on add button"
    step "I tap on device back"
    step "I go to the 'My List' screen"
  end
end

When("I tap on add button") do
  @playlist_screen = PlaylistScreen.new
  @playlist_screen.wait_until(30) { expect(@playlist_screen.my_list_icon.displayed?).to be_truthy }
  @playlist_screen.my_list_icon.click
end

Then("I add the show to my list from show details screen") do
  step "I remove the shows from my list"
  step "I go to the 'Home' screen"
  step "I am on show page to add to favorites"
  step "I tap 'My List' button"
  step "I tap on device back"
end

Then("I should see show is removed from my list") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.no_saved_show.displayed?).to be_truthy }
  @shows_screen.no_saved_show.click
end

Then("I add the show to my List from show details") do
  step "I go to the 'My List' screen"
  step "I add the show to my list from show details screen"
end

Then("I see list of shows in My list") do
  step "I go to the 'My List' screen"
  step "I see list of shows in my list page"
end

Then("I remove the show from show details") do
  step "I go to the 'Home' screen"
  step "I am on show page to add to favorites"
  step "I tap 'My List' button"
end

And("I remove the shows from my list") do
  @shows_screen = ShowScreen.new
  @playlist_screen = PlaylistScreen.new
  list_size = @shows_screen.list_of_shows.size
  puts list_size
  length = 0
  count = 0
  while list_size.positive?
    length += 1
    count += 1
    if count == 4
      step "I go to the 'Home' screen"
      step "I go to the 'My List' screen"
      count = 0
    end
    @shows_screen.more_episode_desc[0].click
    expect(@playlist_screen.my_list_icon.displayed?).to be_truthy
    @playlist_screen.my_list_icon.click
    @playlist_screen.touch_out_side.click
    # rubocop:disable Custom/SleepCop.
    sleep 5
    # rubocop:enable Custom/SleepCop.
    list_size = @shows_screen.list_of_shows.size
    break if length == 50
  end
end
