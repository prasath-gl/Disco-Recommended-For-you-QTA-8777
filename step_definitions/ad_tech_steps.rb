And("I am on video landing screen with {string}") do |search_string|
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  case search_string
  when "adshow1"
    @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:adshow1])
  when "adshow2"
    @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:adshow2])
  when "adshow3"
    @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:adshow3])
  when "adshow4"
    @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:adshow4])
  when "adshow5"
    @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:adshow5])
  when "adshow6"
    @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:adshow6])
  when "adshow7"
    @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:adshow7])
  when "adshow8"
    @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:adshow8])
  end
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
  @search_screen.watch_button.click
end

When("I tap on pause button when ad is playing") do
  @video_screen = VideoScreen.new
  @adtech_screen = AdtechScreen.new
  step "I should be able to see the ad"
  # rubocop:disable Custom/SleepCop
  sleep 5
  # rubocop:enable Custom/SleepCop.
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.video_pause_button.displayed?).to be_truthy }
  @video_screen.video_pause_button.click
  @time_when_paused = @adtech_screen.ad_counter.text
end

And("Ad should be paused") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { @video_screen.video_play_button.displayed? }
  time_after_wait = @adtech_screen.ad_counter.text
  expect(@time_when_paused).to be == time_after_wait
  puts "Time after wait: #{time_after_wait}"
end

And("I should be able to see the ad") do
  @video_screen = VideoScreen.new
  @adtech_screen = AdtechScreen.new
  @video_screen.video_container.click
  if @adtech_screen.ad_text.size.positive?
    expect(@adtech_screen.ad_counter.displayed?).to be_truthy
  else
    step "I scrub to 'chapter 1'"
    step "I scrub to 'chapter 2'"
    expect(@adtech_screen.ad_label.displayed?).to be_truthy
  end
end

Then("I should be able to toggle closed captions") do
  @video_screen = VideoScreen.new
  @video_screen.video_container.click
  @video_screen.wait_until(30) { @video_screen.cc_button.displayed? }
  @video_screen.cc_button.click
  expect(@video_screen.cc_button.attribute("enabled")).to be_truthy
end

And("I see ad timer counts down correctly") do
  @adtech_screen.wait_until(30) { expect(@adtech_screen.ad_counter.displayed?).to be_truthy }
  before_ad_time = @adtech_screen.ad_counter.text
  # rubocop:disable Custom/SleepCop
  sleep(2)
  after_ad_time = @adtech_screen.ad_counter.text
  puts "Before ad time: #{before_ad_time}"
  puts "After ad time: #{after_ad_time}"
  expect(before_ad_time).to be > after_ad_time
  # rubocop:enable Custom/SleepCop.
end

Then("I should be able to click through to advertisers site") do
  @adtech_screen = AdtechScreen.new
  expect(@adtech_screen.learn_more.displayed?).to be_truthy
  @adtech_screen.learn_more.click
end

Then("I should see the video plays correctly without any preroll ads") do
  @video_screen = VideoScreen.new
  step "video plays in portrait mode by default"
  @video_screen.wait_until(30) { @video_screen.video_pause_button.displayed? }
  @video_screen.video_pause_button.click if @video_screen.video_current_time > "00.02"
  expect(@video_screen.video_container.displayed?).to be_truthy
  expect(@video_screen.video_current_time > "00.02").to be_truthy
end

Then("I watch the video for sometime and exit the player") do
  @video_screen = VideoScreen.new
  step "video plays in portrait mode by default"
  # rubocop:disable Custom/SleepCop
  # @video_screen.wait_until(30) { @video_screen.video_pause_button.displayed? }
  sleep(15)
  @video_screen.video_container.click
  @initial_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@initial_time}"
  step "I tap on 'player back' button"
  step "I tap on device back"
  step "I go to the 'Home' screen"
end

And("I tap on previously watched video tile from continue watching rail and validate resume point") do
  @home_screen = HomeScreen.new
  @video_screen = VideoScreen.new
  @home_screen.scroll_to_episode("Continue Watching")
  sleep 5
  @home_screen.carousel_tile_name("Continue Watching").click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
  sleep 5
  @video_screen.video_container.click
  resumed_time = @video_screen.video_current_time
  Kernel.puts "video after resuming #{resumed_time}"
  expect(resumed_time >= @initial_time).to be_truthy
end

Then("I scrub till {string} and see the mid0 ad appears") do |chapter|
  @video_screen = VideoScreen.new
  @adtech_screen = AdtechScreen.new
  case chapter
  when "chapter 2"
    step "I scrub to 'chapter 1'"
    @video_screen.scrub_forward(2)
    @adtech_screen.wait_until(30) { expect(@adtech_screen.ad_label.displayed?).to be_truthy }
  when "chapter 3"
    step "I scrub to 'chapter 1'"
    step "I scrub to 'chapter 3'"
    @adtech_screen.wait_until(30) { expect(@adtech_screen.ad_label.displayed?).to be_truthy }
  end
end

And("user watches complete ad") do
  @video_screen = VideoScreen.new
  @adtech_screen = AdtechScreen.new
  count = 0
  loop do
    count += 1
    break if @adtech_screen.ad_text.empty?
    break if count == 350
  end
  puts count
end

And("I scrub to {string}") do |chapter|
  @video_screen = VideoScreen.new
  @adtech_screen = AdtechScreen.new
  step "user watches complete ad" if @adtech_screen.ad_text.size.positive?
  @video_screen.video_container.click
  @video_screen.wait_until(30) { @video_screen.forward_button.displayed? }
  @initial_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@initial_time}"
  case chapter
  when "chapter 1"
    @video_screen.scrub_backward(2)
    sleep(10)
  when "chapter 2"
    @video_screen.scrub_forward(2)
    sleep(10)
  when "chapter 3"
    @video_screen.scrub_forward(1.5)
    sleep(10)
  end
end

When("I am selecting a video from cont watch list") do
  @home_screen = HomeScreen.new
  @video_screen = VideoScreen.new
  @home_screen.scroll_to_episode("Continue Watching")
  sleep 5
  @home_screen.carousel_tile_name("Continue Watching").click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
end

Then("I see no brief ad clip before content begins") do
  @adtech_screen = AdtechScreen.new
  @video_screen.video_container.click
  @initial_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@initial_time}"
  expect(@adtech_screen.ad_text.size.positive?).to be_falsey
end

Then("video resumes and starts playing") do
  @video_screen.video_container.click
  @initial_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@initial_time}"
  sleep 2
  # rubocop:enable Custom/SleepCop.
  @video_screen.video_container.click
  @elapsed_time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@elapsed_time}"
  expect(@elapsed_time > @initial_time).to be_truthy
end

Then("no ad breaks will be played for those slots") do
  step "I scrub to 'chapter 1'"
  step "I scrub to 'chapter 2'"
  step "video plays in portrait mode by default"
  step "I scrub to 'chapter 3'"
  step "video plays in portrait mode by default"
end

Then("I can't fast forward through the ads") do
  @video_screen = VideoScreen.new
  expect(@video_screen.ad_progress_bar.size.positive?).to be_falsey
end
