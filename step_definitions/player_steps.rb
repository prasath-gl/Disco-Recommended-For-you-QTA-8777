And("I search and select a show for continue watching") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:continueWatching])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
end

When("I am watching the current episode") do
  @shows_screen = ShowScreen.new
  @video_screen = VideoScreen.new
  step "I search and select a show for continue watching"
  @shows_screen.scroll_down
  @current_episode = @shows_screen.episode_name[0].text
  @next_episode = @shows_screen.episode_name[1].text
  puts "current episode on show details #{@current_episode}"
  puts "current episode on show details #{@next_episode}"
  @shows_screen.episode_name[0].click
  step "user forward the video"
  step "I see 'pause' on the player"
  step "I tap on 'player back' button"
  step "I tap on device back"
  step "I go to the 'Home' screen"
end

Then("I navigate to {string} rail with episodes") do |header_title|
  step "user forward the video"
  step "I see 'pause' on the player"
  step "I tap on 'player back' button"
  step "I tap on device back"
  step "I go to the 'Home' screen"
  @home_screen = HomeScreen.new
  @player_screen = PlayerScreen.new
  @home_screen.scroll_to_episode(header_title)
  @home_screen.scroll_up if @home_screen.rail_section_title.displayed?
  @cntewatch_episodes = player_screen.continue_watching_rail[0]
  Kernel.puts "video displayed current #{@cntewatch_episodes}"
end

Then("I scrub the video and validate") do
  @video_screen = VideoScreen.new
  @initial_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@initial_time}"
  @video_screen.scrub_forward(2)
  @video_screen.video_container.click
  @after_forwarding = @video_screen.video_current_time
  Kernel.puts "video displayed after forwarding #{@after_forwarding}"
  expect(@after_forwarding > @initial_time).to be_truthy
end

Then("I validate the timestamp during the app relaunch") do
  step "user tap on the video screen"
  @current_time = @player_screen.video_current_time.text
  Kernel.puts "Video current time #{@current_time}"
  step("Run app in background for few seconds and relaunch the app")
  @current_time_rlnch = @player_screen.video_current_time.text
  Kernel.puts "Video current time #{@current_time_rlnch}"
  t1 = Time.parse(@current_time)
  t2 = Time.parse(@current_time_rlnch)
  @total_seconds = (t2 - t1) / 60
  Kernel.puts "Video current time #{@total_seconds}"
  expect(@total_seconds < 3).to be_truthy
end

Then("I validate the timeline") do
  step "user tap on the video screen"
  @video_screen.forward_button.click
  @current_time = @player_screen.video_current_time.text
  if @video_screen.forward_button.displayed?
    @video_screen.forward_button.click
    @current_time_fwd = @player_screen.video_current_time.text
    expect(@current_time_fwd > @current_time).to be_truthy
  end
end

Then("I validate the timestamp") do
  step "user tap on the video screen"
  if @player_screen.video_current_time.displayed?
    @current_time = @player_screen.video_current_time.text
    Kernel.puts "Video current time #{@current_time}"
  end
  if @shows_screen.episode_video_duration.displayed?
    @total_duration = @shows_screen.episode_video_duration.text
    Kernel.puts "Video total time #{@total_duration}"
  end
end

Then("I wait for small duration during video play") do
  @video = VideoScreen.new
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
end

Then("user validate Continue Watching band rail") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { expect(@home_screen.rail_section_title.displayed?).to be_truthy }
end

Then("I tap on 10sec forward button multiple times") do
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

And("I select watch now") do
  @player_screen = PlayerScreen.new
  # @player_screen.wait_until(30) { @player_screen.playlist_title.displayed? }
  # @player_screen.watch_now.click
  if @player_screen.watch_now.displayed?
    @player_screen.watch_now.click
  else
    @player_screen.resume.click
  end
end

Then("user validate the ad") do
  @video_screen = VideoScreen.new
end

And("user tap on the video screen") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { @video_screen.video_container.displayed? }
  @video_screen.video_container.click
end

Then("user validate the CC option") do
  @video_screen = VideoScreen.new
  @video_screen.cc_button.click
end

Then("user forward the video") do
  @video_screen = VideoScreen.new
  @video_screen.forward_button.click
end

And("user click fullscreen") do
  @video_screen = VideoScreen.new
  @video_screen.full_screen_button.click
end

And("user exit from full screen") do
  @video_screen = VideoScreen.new
  @video_screen.player_back_button.click
end

Then("user rewind the video") do
  @video_screen = VideoScreen.new
  @video_screen.rewind_button.click
end

Then("user close the video") do
  @video_screen = VideoScreen.new
  @video_screen.player_back_button.click
end

And("user resume the video") do
  @video_screen = VideoScreen.new
  @video_screen.video_play_button.click
end

Then("user enable and disable the closed captions") do
  step "user tap on the video screen"
  step "I tap on 'cc' button"
  step "user validate the CC option"
  step "user tap on the video screen"
  step "user validate the CC option"
end

Then("validate 10s skip rewind") do
  step "user tap on the video screen"
  step "user rewind the video"
end

Then("validate 10s skip forward") do
  step "user tap on the video screen"
  step "user forward the video"
end

Then("validate resume content") do
  step "I tap on 'pause' button"
  step "user tap on the video screen"
  step "I tap on 'play' button"
end

Then("validate close X option is visible") do
  step "user tap on the video screen"
  step "user close the video"
end

Then("validate all control players are visible") do
  step "user tap on the video screen"
  step "I see 'pause' on the player"
  step "I see 'forward' on the player"
  step "I see 'backward' on the player"
  step "I see 'player back' on the player"
  step "I see 'full screen' on the player"
  step "I see 'cc' on the player"
end

Then("user pause and resume the video") do
  step "I tap on 'pause' button"
  step "user tap on the video screen"
  step "user resume the video"
end

Then("validate landscape orientation mode is on") do
  step "user tap on the video screen"
  step "user click fullscreen"
  step "user tap on the video screen"
  step "I see 'full screen' on the player"
end

Then("validate remains paused in landscape orientation") do
  step "I tap on 'pause' button"
  step "user click fullscreen"
  step "user tap on the video screen"
  step "I see 'play' on the player"
end

When("I go to the Search screen and play an episode") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:show_name_atv])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  step "I select watch now"
end
