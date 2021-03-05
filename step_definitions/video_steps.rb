And("I am on video landing screen") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:show_name_atv])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
  @search_screen.watch_button.click
end

Then("video plays in portrait mode by default") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.test_video_player.displayed?).to be_truthy }
  mode = driver.orientation
  expect(mode).to eq :portrait
end

Then("video metadata should be visible") do
  @video_screen = VideoScreen.new
  expect(@video_screen.video_title.displayed?).to be_truthy
  expect(@video_screen.video_desc.displayed?).to be_truthy
end

And("I change the video to landscape") do
  @video_screen = VideoScreen.new
  @video_screen.video_container.click
  @video_screen.wait_until(30) { @video_screen.full_screen_button.displayed? }
  @video_screen.full_screen_button.click
end

Then("the video plays in landscape mode") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.test_video_player.displayed?).to be_truthy }
  mode = driver.orientation
  expect(mode).to eq :landscape
end

Then("the video plays correctly") do
  @video_screen = VideoScreen.new
  # rubocop:disable Custom/SleepCop
  sleep 25
  # rubocop:enable Custom/SleepCop.
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.video_pause_button.displayed?).to be_truthy }
end

And("I scrub forward on the Video") do
  @video_screen = VideoScreen.new
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
  @initial_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@initial_time}"
  @video_screen.forward_button.click
  @after_forwarding = @video_screen.video_current_time
  Kernel.puts "video displayed after forward #{@after_forwarding}"
end

Then("the video playback time should be increased by 10 seconds") do
  @time_difference = @after_forwarding.split(":")[-1].to_i - @initial_time.split(":")[-1].to_i
  Kernel.puts "time differnece #{@time_difference}"
  expect(@time_difference).to be >= 10
end

Then("I see video shifts 10Xn times forward") do
  @time_difference = @after_forwarding.split(":")[-1].to_i - @initial_time.split(":")[-1].to_i
  Kernel.puts "time differnece #{@time_difference}"
  expect(@time_difference).to be >= 32
end

Then("I see video shifts 10Xn times backward") do
  @time_difference = @after_rewind.split(":")[-1].to_i - @start_time.split(":")[-1].to_i
  Kernel.puts "time differnece #{@time_difference}"
  expect(@time_difference).to be <= 32
end

And("I scrub backwards on the video") do
  @video_screen = VideoScreen.new
  @video_screen.tap_by_coordinates(300, 150)
  step "I scrub forward on the Video"
  @video_screen.rewind_button.click
  @after_rewind = @video_screen.video_current_time
  Kernel.puts "video displayed after rewind#{@after_rewind}"
end

Then("the video playback time should be decreased by 10 seconds") do
  @time_difference = @after_rewind.split(":")[-1].to_i - @after_forwarding.split(":")[-1].to_i
  Kernel.puts "time differnece #{@time_difference}"
  expect(@time_difference).to be <= 10
end

When("I scroll till end of the screen") do
  @video_screen = VideoScreen.new
  @video_screen.scroll_to_bottom
end

Then("I see Extra Clips") do
  @video_screen = VideoScreen.new
  expect(@video_screen.extra_clips.displayed?).to be_truthy
end

Then("I see {string} on the player") do |player_control|
  @video_screen = VideoScreen.new
  @video_screen.video_container.click
  case player_control
  when "pause"
    @video_screen.video_play.first.click if @video_screen.video_play.size.positive?
    # @video_screen.wait_until(30) { expect(@video_screen.video_pause_button.displayed?).to be_truthy }

  when "play"
    # @video_screen.wait_until(30) { expect(@video_screen.video_play_button.displayed?).to be_truthy }
    expect(@video_screen.video_play_button.displayed?).to be_truthy
  when "forward"
    expect(@video_screen.forward_button.displayed?).to be_truthy

  when "backward"
    expect(@video_screen.rewind_button.displayed?).to be_truthy

  when "back"
    expect(@video_screen.player_back_button.displayed?).to be_truthy

  when "full screen"
    @video_screen.wait_until(30) { expect(@video_screen.full_screen_button.displayed?).to be_truthy }

  when "cc"
    expect(@video_screen.cc_button.displayed?).to be_truthy
  end
end

And("I tap on {string} button") do |button|
  @video_screen = VideoScreen.new
  case button
  when "pause"
    # rubocop:disable Custom/SleepCop
    sleep 5
    # rubocop:enable Custom/SleepCop.
    @video_screen.video_container.click
    @video_screen.wait_until(30) { expect(@video_screen.video_pause_button.displayed?).to be_truthy }
    @video_screen.video_pause_button.click
    @time_when_paused = @video_screen.video_current_time
    puts "Time when paused:#{@time_when_paused}"

  when "play"
    step "I tap on 'pause' button"
    @video_screen.video_play_button.click

  when "player back"
    step "I see 'back' on the player"
    @video_screen.player_back_button.click

  when "episode list back"
    @video_screen.episode_list_back_button.click

  when "cc"
    step "I see 'cc' on the player"
    @video_screen.cc_button.click
  end
end

Then("video should be paused") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { @video_screen.video_play_button.displayed? }
  time_after_wait = @video_screen.video_current_time
  expect(@time_when_paused).to be == time_after_wait
  puts "Time after wait: #{time_after_wait}"
end

Then("I see previous screen from where playback was initiated") do
  @video_screen = SearchScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.watch_button.displayed?).to be_truthy }
end

Then("I see metadata and validate") do
  @video_screen = VideoScreen.new
  portrait_show_title = @video_screen.video_title.text
  puts "Portrait title: #{portrait_show_title}"
  step "I change the video to landscape"
  landscape_show_title = @video_screen.landscape_video_title.text
  puts "Landscape title: #{landscape_show_title}"
  expect(portrait_show_title).to be == landscape_show_title
end

Then("I tap on X button at left top corner in landscape") do
  @video_screen = VideoScreen.new
  expect(@video_screen.player_back_button.displayed?).to be_truthy
  @video_screen.player_back_button.click
  @video_screen.player_back_button.click
end

Then("I tap on start series button") do
  @video_screen = VideoScreen.new
  expect(@video_screen.start_series_button.displayed?).to be_truthy
  @video_screen.start_series_button.click
end

Then("I see episode title of partially watched episode") do
  @video_screen = VideoScreen.new
  expect(@video_screen.episode_title_shows.displayed?).to be_truthy
  expect(@video_screen.video_desc.displayed?).to be_truthy
end

Then("I see affiliate logo at top right corner and back arrow button at left top corner") do
  @video_screen = VideoScreen.new
  expect(@video_screen.affiliate_logo.displayed?).to be_truthy
  expect(@video_screen.player_back_button.displayed?).to be_truthy
end

Then("I open show detail screen which is already watched") do
  step "I tap on 'Resume' button on show episodes screen"
  step "I scrub forward on the Video"
  step "I tap on 'player back' button"
  step "I tap on 'episode list back' button"
end

Then("video is playing I tap on 10sec forward button multiple times") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
  @initial_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@initial_time}"
  scrub_forward = 3
  (1..scrub_forward).each do
    @video_screen.forward_button.click
  end
  @after_forwarding = @video_screen.video_current_time
  Kernel.puts "video displayed #{@after_forwarding}"
end

Then("video is playing I tap on 10sec backward button multiple times") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.rewind_button.displayed?).to be_truthy }
  scrub_forward = 3
  (1..scrub_forward).each do
    @video_screen.forward_button.click
  end
  @start_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@start_time}"
  scrub_backward = 3
  (1..scrub_backward).each do
    @video_screen.rewind_button.click
  end
  @after_rewind = @video_screen.video_current_time
  Kernel.puts "video displayed #{@after_rewind}"
end

And("I tap on {string} button on show episodes screen") do |button|
  @video_screen = VideoScreen.new
  @search_screen = SearchScreen.new
  case button
  when "Watch Now"
    @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
    @search_screen.watch_button.click
  when "Resume"
    expect(@video_screen.resume_button.displayed?).to be_truthy
    @video_screen.resume_button.click
  end
end

And("I change the video to portrait") do
  @video_screen = VideoScreen.new
  @video_screen.video_container.click
  @video_screen.wait_until(30) { @video_screen.full_screen_button.displayed? }
  @video_screen.full_screen_button.click
end

And("I see Depending on the state of the close captions") do
  @video_screen = VideoScreen.new
  step "I see 'cc' on the player"
  step "I tap on 'cc' button"
  expect(@video_screen.video_cc_check.eql?("true")).to be true
  step "I tap on 'cc' button"
  expect(@video_screen.video_cc_check.eql?("false")).to be true
end

And("I see Resume button on show episodes screen") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { @video_screen.resume_button.displayed? }
end

Then("Wait for 30 seconds countdown appears") do
  @video_screen = VideoScreen.new
  count = 0
  loop do
    count += 1
    break if count == 15

    break if @video_screen.up_next_label.size.positive?
  end
end

And("I validate UpNext panel metadata") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(60) { @video_screen.up_next_label.first.displayed? }
  expect(@video_screen.up_next_progressbar.displayed?).to be_truthy
  expect(@video_screen.up_next_season_episode_number.displayed?).to be_truthy
  expect(@video_screen.up_next_show_title.displayed?).to be_truthy
  @upnext_show_title = @video_screen.up_next_show_title.text
  expect(@video_screen.up_next_close_btn.displayed?).to be_truthy
end

Then("I see next video starts playing") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(60) { @video_screen.video_pause_button.displayed? }
  @next_video_title = @video_screen.video_title.text
  puts "video title is #{@next_video_title}"
  expect(@upnext_show_title.include?(@next_video_title)).to be true
end

And("I search and select a show for upnext") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:upnextShow])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
end

When("I finish watching the current episode") do
  @shows_screen = ShowScreen.new
  @video_screen = VideoScreen.new
  step "I search and select a show for upnext"
  @shows_screen.scroll_down
  @current_episode = @shows_screen.episode_name[0].text
  @next_episode = @shows_screen.episode_name[1].text
  puts "current episode on show details #{@current_episode}"
  puts "current episode on show details #{@next_episode}"
  @shows_screen.episode_name[0].click
  @video_screen.scrub_forward(1)
  step "Wait for 30 seconds countdown appears"
  expect(@video_screen.up_next_label.first.displayed?).to be_truthy
end

Then("I see next episode in the list from the same show starts playing") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(60) { @video_screen.video_pause_button.displayed? }
  @next_video_title = @video_screen.video_title.text
  puts "video title is #{@next_video_title}"
  expect(@next_episode.include?(@next_video_title)).to be true
  expect(@upnext_show_title.include?(@next_video_title)).to be true
end

And("I search and select a playlist") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @shows_screen = ShowScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:upnext_playlistshow])
  step "I see sub-nav 'Collections' is highlighted"
  step "I click on first show from Collections list"
  @shows_screen.wait_until(30) { expect(@shows_screen.show_hero_image.displayed?).to be_truthy }
end

When("I finish watching an episode from a curated playlist collection") do
  step "I search and select a playlist"
  @shows_screen = ShowScreen.new
  @video_screen = VideoScreen.new
  @shows_screen.scroll_down
  @current_episode = @shows_screen.episode_name[1].text
  @next_episode = @shows_screen.episode_name[2].text
  puts "current episode on show details #{@current_episode}"
  puts "current episode on show details #{@next_episode}"
  @shows_screen.episode_name[1].click
  @video_screen.scrub_forward(1)
  step "Wait for 30 seconds countdown appears"
  expect(@video_screen.up_next_label.first.displayed?).to be_truthy
end

Then("I see next episode in the playlist collection starts playing") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(60) { @video_screen.video_pause_button.displayed? }
  @next_video_title = @video_screen.video_title.text
  puts "video title is #{@next_video_title}"
  expect(@next_episode.include?(@next_video_title)).to be true
end

When("I finish watching the last episode of the current season") do
  @shows_screen = ShowScreen.new
  step "I search and select a show for upnext"
  @shows_screen = ShowScreen.new
  @shows_screen.season_picker_rail.click
  @shows_screen.listed_seasons[1].click
  # rubocop:disable Custom/SleepCop
  sleep 7 # to load the next season episode
  # rubocop:enable Custom/SleepCop.
  @next_season_first_episode = @shows_screen.episode_name[0].text
  puts "first episode of next season #{@next_season_first_episode}"
  @shows_screen.season_picker_rail.click
  @shows_screen.listed_seasons[0].click
  # rubocop:disable Custom/SleepCop
  sleep 7 # to load the next season episode
  # rubocop:enable Custom/SleepCop.
  5.times { @shows_screen.scroll_down }
  @shows_screen.episode_name.last.click
end

When("I see upnext lable on video player") do
  @video_screen = VideoScreen.new
  @video_screen.scrub_forward(1)
  step "Wait for 30 seconds countdown appears"
  expect(@video_screen.up_next_label.first.displayed?).to be_truthy
end

Then("I see first episode of the next season starts playing") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(60) { @video_screen.video_pause_button.displayed? }
  @next_video_title = @video_screen.video_title.text
  puts "video title is #{@next_video_title}"
  expect(@next_season_first_episode.include?(@next_video_title)).to be true
end

When("I finish watching the last episode of playlist") do
  step "I search and select a playlist"
  @shows_screen = ShowScreen.new
  @video_screen = VideoScreen.new
  5.times { @shows_screen.scroll_down }
  @shows_screen.episode_name.last.click
  @video_screen.scrub_forward(1)
  step "Wait for 30 seconds countdown appears"
  expect(@video_screen.up_next_label.first.displayed?).to be_truthy
  @upnext_show_title = @video_screen.up_next_show_title.text
end

And("if user exits the player while playing that related video") do
  step "I tap on device back"
end

And("user is returned to the Playlist landing page") do
  @shows_screen = ShowScreen.new
  # rubocop:disable Custom/SleepCop
  sleep 7 # to load the previous playlist
  # rubocop:enable Custom/SleepCop.
  5.times { @shows_screen.scroll_up }
  @playlist_title = @shows_screen.episode_name[0].text
  puts "Playlist title  #{@playlist_title}"
  expect(NETWORK_DATA.show_search[:upnext_playlistshow].include?(@playlist_title)).to be true
end

Then("I scrub forward and backward and verify") do
  @video_screen = VideoScreen.new
  @initial_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@initial_time}"
  @video_screen.scrub_backward(2)
  @video_screen.video_container.click
  @after_backward = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@after_backward}"
  expect(@after_backward < @initial_time).to be_truthy
  @video_screen.scrub_forward(2)
  @video_screen.video_container.click
  @after_forwarding = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@after_forwarding}"
  expect(@after_forwarding > @after_backward).to be_truthy
end

Then("I scrub while video is paused and verify") do
  step "I tap on 'pause' button"
  step "I scrub forward and backward and verify"
  step "I tap on 'pause' button"
end

Then("I should see video player,Up Next List and metadata") do
  step "video plays in portrait mode by default"
  step "I should see metadata below the video player"
  step "I should see Up Next List below the video player"
end

Then("I should see Up Next List below the video player") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.more_episodes_text.displayed?).to be_truthy }
  @video_screen.wait_until(30) { expect(@video_screen.episodes_list.size.positive?) }
  @video_screen.wait_until(30) { expect(@video_screen.episode_image.size.positive?) }
end

Then("I should see metadata below the video player") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.video_container.displayed?).to be_truthy }
  @video_screen.wait_until(30) { expect(@video_screen.video_series_title.displayed?).to be_truthy }
  @video_screen.wait_until(30) { expect(@video_screen.video_title.displayed?).to be_truthy }
  @video_screen.wait_until(30) { expect(@video_screen.video_metadata.displayed?).to be_truthy }
end

Given("I navigate to video landing screen") do
  step "I am an auth user"
  step "I am on video landing screen"
  step "video plays in portrait mode by default"
end

When("I tap on episode info button") do
  @shows_screen = ShowScreen.new
  # rubocop:disable Custom/SleepCop
  sleep(10)
  # rubocop:enable Custom/SleepCop.
  @shows_screen.wait_until(30) { expect(@shows_screen.more_episode_desc[1].displayed?).to be_truthy }
  @shows_screen.more_episode_desc[1].click
end

Then("I should see episode metadata, description and network badge") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.series_title.displayed?).to be_truthy }
  @video_screen.wait_until(30) { expect(@video_screen.sub_title.displayed?).to be_truthy }
  @video_screen.wait_until(30) { expect(@video_screen.network_icon.displayed?).to be_truthy }
  @video_screen.wait_until(30) { expect(@video_screen.episodes_list.size.positive?).to be_truthy }
  @episode_name = @video_screen.episodes_list[0].text if @video_screen.episodes_list.size == 1
  @video_screen.wait_until(30) { expect(@video_screen.just_added_desc.displayed?).to be_truthy }
end

And("I tap on watch now button") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.watch_now_btn.displayed?).to be_truthy }
  if @video_screen.now_playing_list.size.positive?
    x = driver.window_size.width / 2
    y = driver.window_size.height / 2
    @video_screen.tap_by_coordinates(x, y)
  elsif @video_screen.watch_now_list.size.positive?
    @video_screen.watch_now_btn.click
  end
end

Then("I should see video playing in video player") do
  @video_screen = VideoScreen.new
  @video_screen.video_container.click unless @video_screen.watch_now_list.size.positive?
  @video_screen.wait_until(60) { expect(@video_screen.video_pause_button.displayed?).to be_truthy }
  @video_screen.wait_until(60) { expect(@video_screen.video_title.text).to eql(@episode_name) }
end

Then("I should be able to see the ad playing in landscape mode") do
  @video_screen = VideoScreen.new
  @adtech_screen = AdtechScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.test_video_player.displayed?).to be_truthy }
  mode = driver.orientation
  expect(mode).to eq :landscape
  @video_screen.video_container.click
  @video_screen.video_play.first.click if @video_screen.video_play.size.positive?
  @video_screen.wait_until(30) { expect(@video_screen.video_pause_button.displayed?).to be_truthy }
  expect(@adtech_screen.ad_label.displayed?).to be_truthy
end

Then("The video will remain paused") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { expect(@video_screen.video_play_button.displayed?).to be_truthy }
end

When("I am casting to a Casting Device") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(60) { @video_screen.cast_icon.displayed? }
  @video_screen.cast_icon.click
  @video_screen.wait_until(30) { @video_screen.cast_device.displayed? }
  @video_screen.cast_device.click
  @video_screen.wait_until(30) { @video_screen.player_cast_view_title.displayed? }
  # rubocop:disable Custom/SleepCop
  sleep 20 # video loading on sender and receiver device
  # rubocop:enable Custom/SleepCop.
end

And("I saw the device casted successfully") do
  val = nil
  @video_screen = VideoScreen.new
  @video_screen.video_container.click # clicking on pause button to fetch the xml
  metadata_list_item = fetchingxmldata
  metadata_list_item.each do |name|
    next unless NETWORK_DATA.show_search[:show_name_atv].include?(name)

    val = name
    puts val
    break
  end
  expect(NETWORK_DATA.show_search[:show_name_atv].include?(val)).to be true
end

Then("I saw show details on the connected device") do
  @video_screen = VideoScreen.new
  series_title = @video_screen.video_series_title.text
  videotitle = @video_screen.video_title.text
  videoendtime = @video_screen.video_duration
  step "I saw the device casted successfully"
  metadata_list_item = fetchingxmldata
  videocurrenttime = @video_screen.video_current_time
  expect(metadata_list_item.include?(series_title)).to be true
  expect(metadata_list_item.any? { |s| s.include?(videocurrenttime) }).to be true
  expect(metadata_list_item.any? { |s| s.include?(videoendtime) }).to be true
  expect(metadata_list_item.any? { |s| s.include?(videotitle) }).to be true
  step "I am stopping the casted video"
end

Then("I am stopping the casted video") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(60) { @video_screen.cast_icon.displayed? }
  @video_screen.cast_icon.click
  @video_screen.wait_until(60) { @video_screen.player_stopcasting.displayed? }
  @video_screen.player_stopcasting.click
  ChromeCast.connect_to_chromecast
  doc = ChromeCast.read_ui_screen_elements
  expect(doc.xpath("//*").children[1].get_attribute("package").include?("com.google.android.apps.tv.launcherx")).to be_truthy
end

Then("I scrub the progress bar on video player in sender device to the same position on connected device") do
  @video_screen = VideoScreen.new
  step "I scrub forward on the Video"
  metadata_list_item = fetchingxmldata
  expect(metadata_list_item.any? { |s| s.include?(@after_forwarding) }).to be true
  step "I am stopping the casted video"
end

def fetchingxmldata
  @video_screen = VideoScreen.new
  metadata_list_item = []
  ChromeCast.connect_to_chromecast
  doc = ChromeCast.read_ui_screen_elements
  attributes = doc.xpath("//*[@text]")
  attributes.each do |name|
    if name.get_attribute("text") != ""
      val = name.get_attribute("text")
      metadata_list_item << val
    end
  end
  metadata_list_item
end

When("I see playback shifts 10 sec forward and video starts playing smoothly") do
  @video_screen = VideoScreen.new
  step "I scrub forward on the Video"
  metadata_list_item = fetchingxmldata
  expect(metadata_list_item.any? { |s| s.include?(@after_forwarding) }).to be true
  step "the video plays correctly"
  step "the video playback time should be increased by 10 seconds"
  step "I am stopping the casted video"
end

Then("I see playback shifts 10 sec backward and video starts playing smoothly") do
  @video_screen = VideoScreen.new
  step "I scrub backwards on the video"
  metadata_list_item = fetchingxmldata
  expect(metadata_list_item.any? { |s| s.include?(@after_rewind) }).to be true
  step "the video plays correctly"
  step "the video playback time should be decreased by 10 seconds"
  step "I am stopping the casted video"
end
