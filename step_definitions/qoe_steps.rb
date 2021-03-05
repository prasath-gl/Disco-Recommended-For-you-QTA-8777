And("I am on video landing screen with qoe shows") do
  step "I go to the 'Search' screen"
  @search_screen = SearchScreen.new
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:show_name_atv_qoe])
  @search_screen.wait_until(30) { @search_screen.first_show.displayed? }
  @search_screen.first_show.click
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
  @search_screen.watch_button.click
end

Then("I perform simple VOD scenarios") do
  step "I pause and resume the video after some video playback"
  step "I scrub forward and rewind after some video playback"
  step "I wait for medium duration during video playback"
  step "Take video to beginning"
  step "I wait for medium duration during video playback"
end

Then("I pause and resume the video after some video playback") do
  step "I wait for medium duration during video playback"
  step "user pauses the video"
  step "I wait for small duration during video playback"
  step "user unpauses the video"
end

Then("user pauses the video") do
  # rubocop:disable Custom/SleepCop
  sleep 30
  # rubocop:enable Custom/SleepCop.
  @qoe_screen = QoEScreen.new
  @video_screen = VideoScreen.new
  @qoe_screen.video_screen.click
  begin
    @video_screen.video_pause_button.click
    Kernel.puts("pause button is clicked")
  rescue StandardError
    Kernel.puts("video is paused")
  end
end

Then("user unpauses the video") do
  # rubocop:disable Custom/SleepCop
  sleep 30
  # rubocop:enable Custom/SleepCop.
  @qoe_screen = QoEScreen.new
  @video_screen = VideoScreen.new
  @qoe_screen.video_screen.click
  begin
    @video_screen.video_play_button.click
    Kernel.puts("play button is clicked")
  rescue StandardError
    Kernel.puts("video is playing")
  end
end

Then("I scrub forward and rewind after some video playback") do
  step "I wait for medium duration during video playback"
  step "I scrub forward and rewind"
end

Then("I scrub forward and rewind") do
  @video_screen = VideoScreen.new
  @video_screen.video_container.click
  @initial_time = @video_screen.video_current_time
  Kernel.puts "current video time displayed : #{@initial_time}"
  @video_screen.video_container.click
  @video_screen.forward_button.click
  @after_forwarding = @video_screen.video_current_time
  Kernel.puts "video time displayed after forward : #{@after_forwarding}"
  @video_screen.video_container.click
  @video_screen.rewind_button.click
  @after_rewind = @video_screen.video_current_time
  Kernel.puts "video time displayed after rewind : #{@after_rewind}"
end

Then("Take video to beginning") do
  step "I wait for medium duration during video playback"
  @video_screen = VideoScreen.new
  @video_screen.scrub_backward(1)
end

Then("I take video to beginning and click cancel autoplay after long playback") do
  step "I wait for medium duration during video playback"
  step "Take video to beginning"
  step "I click cancel autoplay after long playback"
end

Then("I take app to background and relaunch app after video playback") do
  step "I wait for medium duration during video playback"
  step "Run app in background for few seconds and relaunch the app"
  step "I wait for medium duration during video playback"
end

Then("I click cancel autoplay after long playback") do
  wait = Selenium::WebDriver::Wait.new(timeout: 4000)
  @qoe_screen = QoEScreen.new
  element = wait.until { driver.find_element(:id, "play_next_close_layout") }
  element.click
  step "I wait for small duration during video playback"
end

Then("I perform forward and rewind scenarios") do
  step "I tap 10s forward button multiple times when paused"
  step "I tap 10s backward button multiple times when paused"
  step "I tap 10s forward button multiple times after video playback"
  step "I tap 10s backward button multiple times after video playback"
end

Then("I tap 10s forward button multiple times when paused") do
  step "I wait for medium duration during video playback"
  step "user pauses the video"
  step "video is playing I tap on 10sec forward button multiple times"
  step "user unpauses the video"
  step "I wait for medium duration during video playback"
  Kernel.puts("forward multiple pause done")
end

Then("I tap 10s backward button multiple times when paused") do
  step "I wait for medium duration during video playback"
  step "user pauses the video"
  step "video is playing I tap on 10sec backward button multiple times"
  step "user unpauses the video"
  step "I wait for medium duration during video playback"
  Kernel.puts("backward multiple pause done")
end

Then("I tap 10s forward button multiple times after video playback") do
  step "I wait for medium duration during video playback"
  step "user unpauses the video"
  step "I wait for medium duration during video playback"
  step "user enables player control"
  step "I tap on forward button multiple times"
  Kernel.puts("forward multiple done")
end

Then("I tap 10s backward button multiple times after video playback") do
  step "I wait for medium duration during video playback"
  step "user unpauses the video"
  step "I wait for medium duration during video playback"
  step "user enables player control"
  step "I tap on backward button multiple times"
  Kernel.puts("backward multiple done")
end

Then("user enables player control") do
  @video_screen = VideoScreen.new
  @video_screen.tap_by_coordinates(300, 150)
end

Then("I tap on forward button multiple times") do
  @video_screen = VideoScreen.new
  scrub_forward = 3
  (1..scrub_forward).each do
    @video_screen.forward_button.click
  end
  @after_forwarding = @video_screen.video_current_time
  Kernel.puts "video displayed #{@after_forwarding}"
end

Then("I tap on backward button multiple times") do
  @video_screen = VideoScreen.new
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

Then("I close the video") do
  driver.navigate.back
end

Then("I close the app and launch again") do
  step "user close the app and launch"
end

Then("user close the app and launch") do
  driver.close_app
  # rubocop:disable Custom/SleepCop
  sleep 10
  # rubocop:enable Custom/SleepCop.
  driver.activate_app(ENV["DTC_ANDROID_APP_PACKAGE"])
  # rubocop:disable Custom/SleepCop
  sleep 20
  # rubocop:enable Custom/SleepCop.
end

Then("I perform autoplay scenarios") do
  step "I wait for medium duration during video playback"
  step "Take video to end"
  Kernel.puts "progress bar moved"
  step "I wait for autoplay to come and allow autoplay"
  step "I wait for medium duration during video playback"
  Kernel.puts "Allow Autoplay completed"
  step "Take video to end"
  Kernel.puts "progress bar moved"
  step "I wait for autoplay to come and select autoplay"
  step "I wait for medium duration during video playback"
  Kernel.puts "Select Autoplay completed"
  step "Take video to end"
  step "I wait for medium duration during video playback"
  step "I wait for autoplay to come and cancel autoplay"
  Kernel.puts "Video reaching the end is completed"
end

Then("Take video to end") do
  step "I wait for medium duration during video playback"
  @video_screen = VideoScreen.new
  @video_screen.scrub_forward(1)
end

Then("I wait for autoplay to come and allow autoplay") do
  step "I wait for autoplay to come"
  step "I wait for medium duration during video playback"
end

Then("I wait for autoplay to come") do
  @video_screen = VideoScreen.new
  count = 0
  loop do
    count += 1
    break if count == 100

    break if @video_screen.up_next_label.size.positive?
  end
end

Then("I wait for autoplay to come and select autoplay") do
  step "I click select autoplay after long playback"
  step "I wait for medium duration during video playback"
end

Then("I click select autoplay after long playback") do
  wait = Selenium::WebDriver::Wait.new(timeout: 4000)
  @qoe_screen = QoEScreen.new
  element = wait.until { driver.find_element(:id, "play_next_play_icon") }
  element.click
  step "I wait for medium duration during video playback"
end

Then("I wait for autoplay to come and cancel autoplay") do
  step "I click cancel autoplay after long playback"
  step "I wait for small duration during video playback"
end

Then("user resume the video") do
  @video_screen = VideoScreen.new
  @video_screen.video_play_button.click
end

Then("I wait for small duration during video playback") do
  @video = VideoScreen.new
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  # rubocop:disable Custom/SleepCop
  sleep 30
  # rubocop:enable Custom/SleepCop.
end

Then("I wait for medium duration during video playback") do
  @video = VideoScreen.new
  Support::Eventually.eventually(timeout: 60) { @video.video_container.displayed? }
  # rubocop:disable Custom/SleepCop
  sleep 60
  # rubocop:enable Custom/SleepCop.
end

Then("I progress the video to 95%") do
  step "I wait for small duration during video playback"
  @video_screen = VideoScreen.new
  @qoe_screen = QoEScreen.new
  @player_screen = PlayerScreen.new
  @video_screen.video_container.click
  start_x = @video_screen.seek_bar.location.x
  start_y = @video_screen.seek_bar.location.y
  end_95x = start_x + (@video_screen.seek_bar.size.width * 0.9)
  @video_screen.video_container.click
  @time = @video_screen.video_current_time
  Kernel.puts "video displays current time: #{@time}"
  Kernel.puts "Now Move Progress Bar >>>"
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_95x,
                                                                                      y: start_y)
  @video_screen.video_container.click
  tap_action.perform
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time:  #{@time}"
  step "I wait for medium duration during video playback"
end

Then("I progress the video to beginning") do
  step "I wait for small duration during video playback"
  @video_screen = VideoScreen.new
  @qoe_screen = QoEScreen.new
  @player_screen = PlayerScreen.new
  @video_screen.video_container.click
  start_x = @video_screen.seek_bar.location.x
  start_y = @video_screen.seek_bar.location.y
  @time = @video_screen.video_current_time
  Kernel.puts "video displays current time: #{@time}"
  Kernel.puts "Now Move Progress Bar to beginning>>>"
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: start_x,
                                                                                      y: start_y)
  tap_action.perform
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time:  #{@time}"
end

Then("user click the cancel icon in autoplay") do
  @qoe_screen = QoEScreen.new
  @qoe_screen.cancel_auto_play
end

Then("user click next video in autoplay") do
  @qoe_screen = QoEScreen.new
  @qoe_screen.auto_play_button.click
end

Then("The video playback time should be increased") do
  @time_difference = @after_forwarding.split(":")[-1].to_i - @initial_time.split(":")[-1].to_i
  Kernel.puts "time differnece #{@time_difference}"
  expect(@time_difference).to be >= 1
end

Then("The video playback time should be decreased") do
  @time_difference = @after_rewind.split(":")[-1].to_i - @after_forwarding.split(":")[-1].to_i
  Kernel.puts "time differnece #{@time_difference}"
  expect(@time_difference).to be <= 1
end

And("I perform seek progress bar scenarios") do
  step "I wait for medium duration during video playback"
  step "I seek forward progress bar multiple times when paused"
  step "user tap on the video screen"
  step "I wait for small duration during video playback"
  Kernel.puts "Forward progress bar multiple times completed when paused"
  step "I wait for medium duration during video playback"
  step "I seek backward progress bar multiple times when paused"
  step "user tap on the video screen"
  step "I wait for small duration during video playback"
  Kernel.puts "Backward progress bar multiple times completed when paused"
  step "I wait for medium duration during video playback"
  step "I seek forward progress bar multiple times without pause"
  step "user tap on the video screen"
  step "I wait for small duration during video playback"
  Kernel.puts "Forward progress bar multiple times completed without pause"
  step "I wait for medium duration during video playback"
  step "I seek backward progress bar multiple times without pause"
  step "user tap on the video screen"
  step "I wait for small duration during video playback"
  Kernel.puts "Backward progress bar multiple times completed without pause"
end

Then("I seek forward progress bar multiple times when paused") do
  @player_screen = PlayerScreen.new
  @qoe_screen = QoEScreen.new
  @video_screen = VideoScreen.new
  Support::Eventually.eventually(timeout: 60) { @video_screen.video_episode_name.displayed? }
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }

  @video_screen.video_container.click
  start_x = @video_screen.seek_bar.location.x
  start_y = @video_screen.seek_bar.location.y
  @video_screen.video_container.click
  end_20x = start_x + (@video_screen.seek_bar.size.width * 0.2)
  end_50x = start_x + (@video_screen.seek_bar.size.width * 0.5)
  end_80x = start_x + (@video_screen.seek_bar.size.width * 0.8)

  @time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@time}"
  Kernel.puts "Now Move forward Progress Bar first time >>>"
  @video_screen.video_container.click
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_20x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for small duration during video playback"
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }

  Kernel.puts "Now Move forward Progress Bar second time >>>"
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_50x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for small duration during video playback"
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }

  Kernel.puts "Now Move forward Progress Bar third time >>>"
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_80x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for small duration during video playback"
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
end

Then("I seek backward progress bar multiple times when paused") do
  @player_screen = PlayerScreen.new
  @qoe_screen = QoEScreen.new
  @video_screen = VideoScreen.new
  Support::Eventually.eventually(timeout: 60) { @video_screen.video_episode_name.displayed? }
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
  Kernel.puts "backward button displayed successfully"

  @video_screen.video_container.click
  start_x = @video_screen.seek_bar.location.x
  start_y = @video_screen.seek_bar.location.y
  end_20x = start_x + (@video_screen.seek_bar.size.width * 0.2)
  end_50x = start_x + (@video_screen.seek_bar.size.width * 0.5)
  end_70x = start_x + (@video_screen.seek_bar.size.width * 0.7)
  Kernel.puts "got seek bar locations details successfully"

  @time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@time}"
  Kernel.puts "Now Move backward Progress Bar first time >>>"
  @video_screen.video_container.click
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_70x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for medium duration during video playback"
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }

  Kernel.puts "Now Move backward Progress Bar second time>>>"
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_50x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for medium duration during video playback"
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }

  Kernel.puts "Now Move backward Progress Bar third time >>>"
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_20x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for medium duration during video playback"
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
end

Then("I seek forward progress bar multiple times without pause") do
  @player_screen = PlayerScreen.new
  @qoe_screen = QoEScreen.new
  @video_screen = VideoScreen.new
  Support::Eventually.eventually(timeout: 60) { @video_screen.video_episode_name.displayed? }
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
  Kernel.puts "forward button displayed successfully"

  @video_screen.video_container.click
  start_x = @video_screen.seek_bar.location.x
  start_y = @video_screen.seek_bar.location.y
  @video_screen.video_container.click
  @video_screen.video_container.click
  end_20x = start_x + (@video_screen.seek_bar.size.width * 0.2)
  end_50x = start_x + (@video_screen.seek_bar.size.width * 0.5)
  end_80x = start_x + (@video_screen.seek_bar.size.width * 0.8)
  Kernel.puts "got seek bar locations details successfully"

  @video_screen.video_container.click
  @time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@time}"
  Kernel.puts "Now Move forward Progress Bar first time >>>"
  @video_screen.video_container.click
  @video_screen.video_container.click
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_20x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for medium duration during video playback"

  Kernel.puts "Now Move forward Progress Bar second time >>>"
  @video_screen.video_container.click
  @video_screen.video_container.click
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_50x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for medium duration during video playback"

  Kernel.puts "Now Move forward Progress Bar third time >>>"
  @video_screen.video_container.click
  @video_screen.video_container.click
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_80x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for medium duration during video playback"
end

Then("I seek backward progress bar multiple times without pause") do
  @player_screen = PlayerScreen.new
  @qoe_screen = QoEScreen.new
  @video_screen = VideoScreen.new
  Support::Eventually.eventually(timeout: 60) { @video_screen.video_episode_name.displayed? }
  @video_screen.video_container.click
  @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
  Kernel.puts "backward button displayed successfully"

  @video_screen.video_container.click
  start_x = @video_screen.seek_bar.location.x
  start_y = @video_screen.seek_bar.location.y
  @video_screen.video_container.click
  @video_screen.video_container.click
  end_20x = start_x + (@video_screen.seek_bar.size.width * 0.2)
  end_50x = start_x + (@video_screen.seek_bar.size.width * 0.5)
  end_70x = start_x + (@video_screen.seek_bar.size.width * 0.7)
  Kernel.puts "got seek bar locations details successfully"

  @video_screen.video_container.click
  @time = @video_screen.video_current_time
  Kernel.puts "video displayed current #{@time}"

  Kernel.puts "Now Move backward Progress Bar first time >>>"
  @video_screen.video_container.click
  @video_screen.video_container.click
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_70x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for medium duration during video playback"

  Kernel.puts "Now Move backward Progress Bar second time>>>"
  @video_screen.video_container.click
  @video_screen.video_container.click
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_50x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for medium duration during video playback"

  Kernel.puts "Now Move backward Progress Bar third time >>>"
  @video_screen.video_container.click
  @video_screen.video_container.click
  tap_action = Appium::TouchAction.new.press(element: @video_screen.seek_bar).move_to(element: @video_screen.seek_bar, x: end_20x,
                                                                                      y: start_y)
  tap_action.perform
  Support::Eventually.eventually(timeout: 30) { @video.video_container.displayed? }
  @time = @video_screen.video_current_time
  Kernel.puts "video progressed to time #{@time}"
  step "I wait for medium duration during video playback"
end

When("User tap on pause button when ad is playing") do
  @video_screen = VideoScreen.new
  @adtech_screen = AdtechScreen.new
  step "I should be able to see ad"
  @video_screen.wait_until(30) { expect(@video_screen.video_pause_button.displayed?).to be_truthy }
  @video_screen.video_pause_button.click
  @time_when_paused = @adtech_screen.ad_counter.text
  # rubocop:disable Custom/SleepCop
  sleep 5
  # rubocop:enable Custom/SleepCop.
end

And("I should be able to see ad") do
  @adtech_screen = AdtechScreen.new
  if @adtech_screen.ad_text.size.positive?
    expect(@adtech_screen.ad_counter.displayed?).to be_truthy
  else
    step "I scrub to the 'chapter 1'"
    step "I scrub to the 'chapter 2'"
    if @adtech_screen.ad_text.size.positive?
      Kernel.puts "Ad displayed"
    else
      Kernel.puts "Ad not yet displayed, scrubbing to chapter 3"
      step "I scrub to the 'chapter 3'"
    end
    Support::Eventually.eventually(timeout: 30) { @adtech_screen.ad_counter.displayed? }
  end
end

And("I scrub to the {string}") do |chapter|
  @video_screen = VideoScreen.new
  @adtech_screen = AdtechScreen.new
  step "user watches complete ad" if @adtech_screen.ad_text.size.positive?
  @video_screen.video_container.click
  @initial_time = @video_screen.video_current_time
  Kernel.puts "video displayed current 1 #{@initial_time}"
  case chapter
  when "chapter 1"
    @video_screen.scrub_backward(2)
    after_scrub_back = @video_screen.video_current_time
    Kernel.puts "video displayed current 2 #{after_scrub_back}"
  when "chapter 2"
    @video_screen.scrub_forward(2)
    # rubocop:disable Custom/SleepCop
    sleep 2
    # rubocop:enable Custom/SleepCop.
  when "chapter 3"
    @video_screen.scrub_forward(1.5)
    # rubocop:disable Custom/SleepCop
    sleep 2
    # rubocop:enable Custom/SleepCop.
  end
end

And("Ad should be paused and resumed") do
  @video_screen = VideoScreen.new
  @video_screen.wait_until(30) { @video_screen.video_play_button.displayed? }
  time_after_wait = @adtech_screen.ad_counter.text
  expect(@time_when_paused).to be == time_after_wait
  puts "Time after wait: #{time_after_wait}"
  @video_screen.wait_until(10) { expect(@video_screen.video_play_button.displayed?).to be_truthy }
  # rubocop:disable Custom/SleepCop
  sleep 5
  # rubocop:enable Custom/SleepCop.
  @video_screen.video_play_button.click
  time_when_resume = @adtech_screen.ad_counter.text
  puts "time when resume: #{time_when_resume}"
  # rubocop:disable Custom/SleepCop
  sleep 5
  # rubocop:enable Custom/SleepCop.
end

And("Ad should not be replayed on scrub backward") do
  @video_screen = VideoScreen.new
  @video_screen.scrub_backward(2)
  @video_screen.wait_until(10) { expect(@video_screen.seek_bar.displayed?).to be_truthy }
end

Then("I pause and resume Ad play") do
  step "User tap on pause button when ad is playing"
  step "Ad should be paused and resumed"
end

And("Ad should not be replayed on rewind") do
  step "user watches complete ad"
  step "Ad should not be replayed on scrub backward"
end
