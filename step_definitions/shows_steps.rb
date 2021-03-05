Given("I am on Shows screen") do
  @shows_screen = BaseScreen.new
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { @home_screen.home_hero.displayed? }
  @shows_screen.wait_until(30) { @shows_screen.shows_icon.displayed? }
  @shows_screen.shows_icon.click
end

Then("A list of shows are displayed") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.list_of_shows.count).to be >= 1
end

When("I select a show") do
  @shows_screen = ShowScreen.new
  @shows_screen.list_of_shows.first.click
end

Given("I am on show details page") do
  @home_screen = HomeScreen.new
  step "I am on home screen"
  @home_screen.scroll_to_episode("Trending Shows")
  @search_screen = SearchScreen.new
  @search_screen.search_result_image("Trending Shows").first.click
end

When("I click more option on first available episode description") do
  @shows_screen = ShowScreen.new
  @shows_screen.more_episode_desc.first.click
end

Then("I see description option changed to {string} option") do |after_option|
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.more_less_option(after_option).displayed?).to be_truthy }
end

Then("I see episode description") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.info_modal_desc.displayed?).to be_truthy }
end

Then("I see episode metadata for episode art , title , number and duration") do
  @shows_screen = ShowScreen.new
  @home_screen = HomeScreen.new
  size = @shows_screen.episode_image.size
  max_swapping_round = 3
  (1..max_swapping_round).each do |_i|
    (1..size - 2).each do |j|
      @shows_screen.wait_until(30) { expect(@shows_screen.episode_image[j].displayed?).to be_truthy }
      @shows_screen.wait_until(30) { expect(@shows_screen.episode_number[j].displayed?).to be_truthy }
      @shows_screen.wait_until(30) { expect(@shows_screen.episode_name[j].displayed?).to be_truthy }
      @shows_screen.wait_until(30) { expect(@shows_screen.episode_duration[j].displayed?).to be_truthy }
    end
    @shows_screen.scroll_to_traves_complete_episode_list
  end
end

Then("I see episode list in the season") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.episode_list.displayed?).to be_truthy }
end

Then("I see show hero on top") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.show_hero_image.displayed?).to be_truthy }
end

Then("I see Show Title over the Show Hero") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.show_hero_title.displayed?).to be_truthy }
end

Then("I tap on back arrow button") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { @shows_screen.back_arrow.displayed? }
  @shows_screen.back_arrow.click
end

Then("I see shows list screen") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.list_of_shows.first.displayed?).to be_truthy }
end

Given("I am on show details screen with extra clip") do
  @search_screen = SearchScreen.new
  step "I am an auth user"
  step "I go to the 'Search' screen"
  expect(@search_screen.search_text_field.displayed?).to be_truthy
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:show_with_extra_clips])
  @search_screen.wait_until(30) { expect(@search_screen.search_shows_tab.displayed?).to be_truthy }
  step "I tap on any show in the result"
  step "I am on show details screen"
end

Given("I am on show details screen") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.details_tab.displayed?).to be_truthy }
end

And("I tap on the Clips tab") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.extra_clip_tab.displayed?).to be_truthy }
  @shows_screen.extra_clip_tab.click
end

And("I tap on any extra clip") do
  step "I navigate to Extra Clips"
  @shows_screen.extra_clip_thumbnail.click
end

Given("I am on show details screen of special show with multiple episodes") do
  @search_screen = SearchScreen.new
  step "I login as anonymous user"
  step "I go to the 'Search' screen"
  expect(@search_screen.search_text_field.displayed?).to be_truthy
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:special_show_with_multiple_episodes])
  @search_screen.wait_until(30) { expect(@search_screen.search_shows_tab.displayed?).to be_truthy }
  step "I tap on any show in the result"
  step "I am on show details screen"
end

Given("I am on show details screen of special show with single episode") do
  @search_screen = SearchScreen.new
  step "I login as anonymous user"
  step "I go to the 'Search' screen"
  expect(@search_screen.search_text_field.displayed?).to be_truthy
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:special_show_with_single_episode])
  @search_screen.wait_until(30) { expect(@search_screen.search_shows_tab.displayed?).to be_truthy }
  step "I tap on any show in the result"
  step "I am on show details screen"
end

Then("I see Watch Now button on hero tile") do
  @home_screen = HomeScreen.new
  @search_screen.wait_until(30) { expect(@home_screen.cta_button.displayed?).to be_truthy }
end

And("I see list of networks on top of page") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.shows_network_list.size.positive?).to be_truthy
end

And("I scroll through the list horizontally") do
  @shows_screen = ShowScreen.new
  start_x = driver.window_size.width * 0.8
  avg_dist = 300
  start_y = avg_dist
  end_x = start_x - avg_dist
  end_y = start_y
  @shows_screen.scroll_by_coordinates(start_x, start_y, end_x, end_y)
  expect(@shows_screen.shows_network_list.size.positive?).to be_truthy
  @shows_screen.scroll_by_coordinates(end_x, start_y, start_x, end_y)
end

Then("I select different networks and validate functionality") do
  @shows_screen = ShowScreen.new
  list_size = @shows_screen.shows_network_list.size
  list_size.times do |i|
    @shows_screen.shows_network_list[i].click
    expect(@shows_screen.shows_network_list[i].attribute("selected")).to be_truthy
  end
end

Then("I select {string} network") do |network_name|
  @shows_screen = ShowScreen.new
  step "I see list of networks on top of page"
  case network_name
  when "All"
    @shows_screen.all_network.click
  when "TLC"
    @shows_screen.shows_network_list.first.click
  end
end

Then("I see shows listed in alphabetical order") do
  @shows_screen = ShowScreen.new
  shows = @shows_screen.list_of_shows
  i = 1
  @shows_screen.wait_until(30) { expect(shows.size.positive?).to be_truthy }
  while i < shows.size
    puts "shows alphabetical order: #{shows[i].text} and #{shows[i - 1].text}"
    expect(shows[i].text >= shows[i - 1].text).to be_truthy
    i += 1
  end
end

Then("I see shows details {string} network is selected") do |network_name|
  @shows_screen = ShowScreen.new
  case network_name
  when "Trending"
    @shows_screen.filter_list("Trending").click
    expect(@shows_screen.filter_list("Trending").attribute("selected")).to be_truthy
  when "A-Z"
    @shows_screen.filter_list("A-Z").click
    expect(@shows_screen.filter_list("A-Z").attribute("selected")).to be_truthy
  end
end

Then("I choose different filters and validate shows") do
  step "I see shows details 'Trending' network is selected"
  expect(@shows_screen.list_of_shows.size.positive?).to be_truthy
  step "I see shows details 'A-Z' network is selected"
  expect(@shows_screen.list_of_shows.size.positive?).to be_truthy
end

And("I scroll down and see filter list still appears and Network Row disappear") do
  @shows_screen = ShowScreen.new
  @shows_screen.filter_list("Trending").displayed?
  4.times { @shows_screen.scroll_down }
  expect(@shows_screen.filters.displayed?).to be_truthy
  expect(@shows_screen.shows_network_list.size.positive?).to be false
end

Then("I tap on browse and see page scrolls back to top") do
  @shows_screen = ShowScreen.new
  2.times { @shows_screen.shows_icon.click }
  expect(@shows_screen.shows_network_list.size.positive?).to be_truthy
end

And("I scrolls back to top and see Network Switcher row  appear") do
  @shows_screen = ShowScreen.new
  4.times { @shows_screen.scroll_up }
  expect(@shows_screen.shows_network_list.size.positive?).to be_truthy
end

And("I scroll left and right on filter list") do
  @shows_screen = ShowScreen.new
  step "I select 'TLC' network"
  start_x = driver.window_size.width * 0.8
  start_y = driver.window_size.height * 0.25
  end_x = driver.window_size.width * 0.2
  end_y = start_y
  puts "Left swipe"
  @shows_screen.scroll_by_coordinates(start_x, start_y, end_x, end_y)
  expect(@shows_screen.list_of_shows.size.positive?).to be_truthy
  puts "Right swipe"
  @shows_screen.scroll_by_coordinates(end_x, start_y, start_x, end_y)
  expect(@shows_screen.list_of_shows.size.positive?).to be_truthy
end

Then("I see network logo on show hero") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.show_page_network_logo.displayed?).to be_truthy
end

Then("I tap on Sign In to Watch on the show hero") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.start_series_button.displayed?).to be_truthy
  @shows_screen.start_series_button.click
end

Then("I validate episode duration") do
  @shows_screen = ShowScreen.new
  step "I see network logo on show hero"
  @shows_screen.scroll_to_traves_complete_episode_list
  @shows_screen.wait_until(30) { expect(@shows_screen.episode_duration.size.positive?).to be_truthy }
  # @shows_screen.scroll_to_traves_complete_episode_list
  episode_list_size = @shows_screen.episode_duration.size
  (0...episode_list_size).each do |j|
    show_episode_duration = @shows_screen.episode_duration[j].text
    puts "Show episode duration in Shows screen: #{show_episode_duration}"
    if show_episode_duration.include?("h") && show_episode_duration.include?("m")
      puts "More than an hour"
    else
      puts "Less than an hour"
    end
  end
end

Then("I see show metadata on hero") do
  @shows_screen = ShowScreen.new
  @home_screen = HomeScreen.new
  expect(@shows_screen.show_hero_title.displayed?).to be_truthy
  expect(@shows_screen.show_description.displayed?).to be_truthy
  expect(@home_screen.hero_genre.displayed?).to be_truthy
end

Then("Episode metadata - Episode title, Show Title, Season number, Episode number, Episode description") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.episode_name.displayed?).to be_truthy
  expect(@shows_screen.episode_name_shows.displayed?).to be_truthy
  expect(@shows_screen.episode_show_number.displayed?).to be_truthy
  expect(@shows_screen.episode_description.displayed?).to be_truthy
end

When("I click {string} button next to show description") do |option|
  @shows_screen = ShowScreen.new
  @shows_screen.more_less_option(option).click
end

When("I see remaining time progress bar for the duration played below the Resume button") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.progress_bar_below_resume_button.displayed?).to be_truthy
end

When("I see Season 1, Episode 1 or earliest episode available playing") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.episode_number_shows.displayed?).to be_truthy
end

Then("I see {string} description of the show") do |type|
  @shows_screen = ShowScreen.new
  case type
  when "complete"
    expect(@shows_screen.more_less_option("Less").displayed?).to be_truthy

  when "short"
    expect(@shows_screen.more_less_option("More").displayed?).to be_truthy
  end
end

And("I navigate to related shows rail") do
  @shows_screen = ShowScreen.new
  @shows_screen.scroll_to_you_might_also_like
end

And("I tap on any show from related shows") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.related_shows_thumbnail.size.positive?).to be_truthy
  @shows_screen.related_shows_thumbnail.first.click
end

When("I am on show page with multiple episodes") do
  @home_screen = HomeScreen.new
  @shows_screen = ShowScreen.new
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:show_name_atv])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  step "I tap on season dropdown"
  @shows_screen.first_season.click
  expect(@shows_screen.episode_number_shows.displayed?).to be_truthy
  @shows_screen.episode_number_shows.click
  @first_episode_num = @shows_screen.episode_name.first.text
end

Then("I see earliest season episode available playing") do
  @video_screen = VideoScreen.new
  video_episode_num = @video_screen.video_episode_name.text
  puts @first_episode_num
  puts @video_episode_num
  expect(@first_episode_num == video_episode_num).to be_truthy
end

And("I navigate to {string} filter") do |filter_text|
  @shows_screen = ShowScreen.new
  case filter_text
  when "A-Z"
    @shows_screen.filter_list("A-Z").click
    expect(@shows_screen.filter_list("A-Z").attribute("selected")).to be_truthy
  when "Most Popular Shows"
    @shows_screen.filter_list("Most Popular Shows").click
    expect(@shows_screen.filter_list("Most Popular Shows").attribute("selected")).to be_truthy
  end
end

Then("I select different networks and validate page changes") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.shows_network_list.size.positive?).to be_truthy
  list_size = @shows_screen.shows_network_list.size
  @shows_screen.shows_network_list[0].click
  @shows_screen.wait_until(30) { expect(@shows_screen.list_of_shows[0].displayed?).to be_truthy }
  # rubocop:disable Custom/SleepCop.
  sleep 8
  @before_click_show_name = @shows_screen.list_of_shows.first.text
  puts "before click show name  #{@before_click_show_name}"
  (1..list_size - 2).each do |i|
    @shows_screen.shows_network_list[i].click
    sleep 8
    @shows_screen.wait_until(30) { expect(@shows_screen.shows_network_list[i].attribute("selected")).to be_truthy }
    sleep 8
    @shows_screen.wait_until(30) { expect(@shows_screen.list_of_shows.first.displayed?).to be_truthy }
    # rubocop:enable Custom/SleepCop.
    @after_click_show_name = @shows_screen.list_of_shows.first.text
    puts "after click show name  #{@after_click_show_name}"
    @shows_screen.wait_until(30) { expect(@before_click_show_name.include?(@after_click_show_name)).to be false }
  end
end

And("I see drop down list in bottom half of the screen") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { @shows_screen.season_dropdown.displayed? }
  @shows_screen.season_dropdown.click
  @shows_screen.wait_until(30) { @shows_screen.dropdown_list.displayed? }
end

And("I shall see Show cards with thumbnail, show title, and network icon") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { @shows_screen.networkicon.displayed? }
  @shows_screen.wait_until(30) { @shows_screen.episode_image.first.displayed? }
  @shows_screen.wait_until(30) { @shows_screen.episode_name.first.displayed? }
end

And("The Network row scrolled with the page") do
  @shows_screen = ShowScreen.new
  step "I select 'TLC' network"
  @shows_screen.scroll_down
  step "I tap on 'Trending' tab"
  step "I select 'TLC' network"
end

Then("I tap on {string} tab") do |tab|
  @shows_screen = ShowScreen.new
  case tab
  when "Trending"
    @shows_screen.wait_until(30) { @shows_screen.trending_tab.displayed? }
    @shows_screen.trending_tab.click
  when "New"
    @shows_screen.wait_until(30) { @shows_screen.new_tab.displayed? }
    @shows_screen.new_tab.click
  end
end

And("I see remaining time progress bar below the Resume button") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.progress_bar_resume.displayed?).to be_truthy }
end

Then("I am on show details page with single episode") do
  @search_screen = SearchScreen.new
  step "I go to the 'Search' screen"
  expect(@search_screen.search_text_field.displayed?).to be_truthy
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:episode_1])
  @search_screen.wait_until(30) { expect(@search_screen.search_shows_tab.displayed?).to be_truthy }
  step "I tap on any show in the result"
  step "I am on show details screen"
end

And("I open show detail screen in which an episode is partly watched") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @video_screen = VideoScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:show_with_resume])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
  @search_screen.watch_button.click
  step "Let the video play for '2' mins"
  @video_screen.tap_by_coordinates(300, 150)
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
  # rubocop:disable Custom/SleepCop
  sleep(5)
  # rubocop:enable Custom/SleepCop.
  @video_screen.tap_by_coordinates(300, 150)
  @time_before_resume = @video_screen.video_current_time.gsub(":", ".").to_f
  @before_video_title = @video_screen.video_title.text
  step "I tap on 'player back' button"
  step "I see Resume button on show episodes screen"
end

And("I tap on Resume button and verify episode resuming from where I left") do
  @video_screen = VideoScreen.new
  step "I tap on 'Resume' button on show episodes screen"
  step "Verify episode resuming from where I left"
end

And("Verify episode resuming from where I left") do
  step "Let the video play for '1' mins"
  @video_screen = VideoScreen.new
  # rubocop:disable Custom/SleepCop
  sleep(5)
  # rubocop:enable Custom/SleepCop.
  @video_screen.tap_by_coordinates(300, 150)
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
  @time_after_resume = @video_screen.video_current_time.gsub(":", ".").to_f
  @after_video_title = @video_screen.video_title.text
  puts "time before resume  #{@time_before_resume}"
  puts "time after resume  #{@time_after_resume}"
  expect(@time_after_resume >= @time_before_resume).to be_truthy
  puts "show name before  #{@before_video_title}"
  puts "show name after  #{@after_video_title}"
  expect(@before_video_title.include?(@after_video_title)).to be true
end

And("I search and select a show having single season") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:single_season_show])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
end

When("I watch last episode 95%") do
  @shows_screen = ShowScreen.new
  @video_screen = VideoScreen.new
  @first_episode = @shows_screen.episode_name[0].text
  5.times { @shows_screen.scroll_down }
  @last_episode = @shows_screen.episode_name.last.text
  puts "first episode on show details #{@first_episode}"
  puts "last episode on show details #{@last_episode}"
  @shows_screen.episode_name.last.click
  @video_screen.scrub_forward(1)
  step "Wait for 30 seconds countdown appears"
end

When("I open show detail screen in which the last episode is about 95% watched") do
  step "I search and select a show having single season"
  step "I watch last episode 95%"
  step "I tap on device back"
end

When("I tap on watch button and expect episode 1 starts playing") do
  @video_screen = VideoScreen.new
  @search_screen = SearchScreen.new
  # rubocop:disable Custom/SleepCop
  sleep 5 # to load page
  # rubocop:enable Custom/SleepCop.
  2.times { @shows_screen.scroll_up }
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
  @search_screen.watch_button.click
  @video_screen.wait_until(60) { @video_screen.video_pause_button.displayed? }
  @video_title = @video_screen.video_title.text
  puts "video title is #{@video_title}"
  expect(@first_episode.include?(@video_title)).to be true
end

And("I search and select a show having multiple season") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:multiple_season_show])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
end

When("I have previously finished watching the entire show") do
  @shows_screen = ShowScreen.new
  @video_screen = VideoScreen.new
  @first_episode = @shows_screen.episode_name[0].text
  puts "first season first epsiode on show details #{@first_episode}"
  @shows_screen.season_picker_rail.click
  @shows_screen.listed_seasons.last.click
  # rubocop:disable Custom/SleepCop
  sleep 7 # to load the next season episode
  # rubocop:enable Custom/SleepCop.
  5.times { @shows_screen.scroll_down }
  @shows_screen.episode_name.last.click
  @video_screen.scrub_forward(1)
  step "Wait for 30 seconds countdown appears"
end

When("I open show detail screen in which I have previously finished watching the entire show") do
  step "I search and select a show having multiple season"
  step "I have previously finished watching the entire show"
  step "I tap on device back"
end

And("I should see All Netwok and Genre filter is selected by default") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.all_tab.selected.eql?("true")).to be true
  expect(@shows_screen.trending_tab.selected.eql?("true")).to be true
end

And("I tap on you may also like tab") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { @shows_screen.you_may_also_like_tab.displayed? }
  @shows_screen.you_may_also_like_tab.click
end

And("I click on show tile in you may also like tab") do
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.second_show.displayed? }
  @search_screen.second_show.click
end

And("I see Show cards with thumbnail, show title, and network icon on you may like tab") do
  @shows_screen = ShowScreen.new
  @search_screen = SearchScreen.new
  step "I scroll down"
  @search_screen.wait_until(30) { @search_screen.second_show.displayed? }
  @shows_screen.wait_until(30) { @shows_screen.networkicon.displayed? }
  @shows_screen.wait_until(30) { @shows_screen.episode_image_you_may_like_tab.size.positive? }
  @shows_screen.wait_until(30) { @shows_screen.episode_name.size.positive? }
  @search_screen.second_show.click
end

Then("I select a network and its sub category shows") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.shows_network_list.size.positive?).to be_truthy
  list_size = @shows_screen.shows_network_list.size
  # rubocop:disable Custom/SleepCop.
  sleep 8
  @before_click_show_name = @shows_screen.list_of_shows.first.text
  puts "before click show name  #{@before_click_show_name}"
  (0..list_size - 1).each do |i|
    @before_click_show_name = @shows_screen.list_of_shows.first.text
    @shows_screen.shows_network_list[i].click
    sleep 8
    @shows_screen.wait_until(30) { expect(@shows_screen.shows_network_list[i].attribute("selected")).to be_truthy }
    sleep 8
    step "I choose different filters and validate shows"
    @shows_screen.wait_until(30) { expect(@shows_screen.list_of_shows.first.displayed?).to be_truthy }
    # rubocop:enable Custom/SleepCop.
    @after_click_show_name = @shows_screen.list_of_shows.first.text
    puts "after click show name  #{@after_click_show_name}"
  end
end

Then("I should see shows related to selected category") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@before_click_show_name.include?(@after_click_show_name)).to be false }
end
