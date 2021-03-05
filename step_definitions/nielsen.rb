Then("Let the video play for {string} mins") do |wait_time|
  # rubocop:disable Custom/SleepCop
  @video_screen = VideoScreen.new
  @video_screen.tap_by_coordinates(300, 150)
  sleep(20)
  case wait_time
  when "1"
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(5)
  when "2"
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(5)
  when "3"
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(20)
    @video_screen.tap_by_coordinates(300, 150)
    sleep(5)
  end
  # rubocop:enable Custom/SleepCop.
end

Then("Ad start playing in player") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { @video_screen.ad_timer.displayed? }
end

Then("I close video player") do
  # rubocop:disable Custom/SleepCop
  @video_screen = VideoScreen.new
  @video_screen.tap_by_coordinates(300, 150)
  @video_screen.wait_until(30) { @video_screen.player_back_button.displayed? }
  @video_screen.player_back_button.click
  sleep(5)
  # rubocop:enable Custom/SleepCop.
end

Then("I exit app") do
  # rubocop:disable Custom/SleepCop
  $driver.close_app
  sleep(5)
  # rubocop:enable Custom/SleepCop.
end

Then("Pause the video for {string} secs") do |wait_time|
  # rubocop:disable Custom/SleepCop
  @video_screen = VideoScreen.new
  @video_screen.tap_by_coordinates(300, 150)
  step "I tap on 'pause' button"
  case wait_time
  when "30"
    sleep(30)
  end
  # rubocop:enable Custom/SleepCop.
end

Then("Seek forward for {string} min") do |wait_time|
  @video_screen = VideoScreen.new
  @video_screen.tap_by_coordinates(300, 150)
  case wait_time
  when "1"
    scroll_count = 0
    loop do
      @video_screen.wait_until(30) { expect(@video_screen.forward_button.click).to be_truthy }
      scroll_count += 1
      break if scroll_count == 6
    end
  end
end

Then("Seek backward for {string} min") do |wait_time|
  @video_screen = VideoScreen.new
  @video_screen.tap_by_coordinates(300, 150)
  case wait_time
  when "1"
    scroll_count = 0
    loop do
      @video_screen.wait_until(30) { expect(@video_screen.rewind_button.click).to be_truthy }
      scroll_count += 1
      break if scroll_count == 6
    end
  end
end
