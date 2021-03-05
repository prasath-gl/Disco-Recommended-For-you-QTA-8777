Given(/^I click on Link TV Provider Button$/) do
  @login_screen = LoginScreen.new
  @login_screen.link_tv_provider.first.click if @login_screen.link_tv_provider.size.positive?
end

Then(/^I click on cancel button on Link_TV_Provider page$/) do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.cancel_button.displayed? }
  @login_screen.cancel_button.click
end

Then("I click on player progress bar") do
  @eventor = Eventor.new
  @video_screen = VideoScreen.new
  retry_proc = proc do
    @video_screen.video_container.click
    Kernel.puts "---------retrying to click container------------"
  end
  @video_screen.video_container.click
  Retriable.retriable(on: Selenium::WebDriver::Error::NoSuchElementError, tries: 7, base_interval: 1, on_retry: retry_proc) do
    expect(@eventor.wait_until(30) { @eventor.player_progress_bar.displayed? }).to be true
    @eventor.player_progress_bar.click
  end
end

And("I tap on {string} button for eventor") do |button|
  @video_screen = VideoScreen.new
  case button
  when "pause"
    retry_proc = proc do
      @video_screen.video_container.click
      Kernel.puts "---------retrying to click container------------"
    end
    @video_screen.video_container.click
    Retriable.retriable(on: Selenium::WebDriver::Error::NoSuchElementError, tries: 5, base_interval: 1, on_retry: retry_proc) do
      expect(@video_screen.video_pause_button.displayed?).to be_truthy
      @video_screen.video_pause_button.click
      @time_when_paused = @video_screen.video_current_time
      puts "Time when paused:#{@time_when_paused}"
    end
  end
end

And("I scrub forward on the Video for eventor") do
  @video_screen = VideoScreen.new
  retry_proc = proc do
    @video_screen.video_container.click
    Kernel.puts "---------retrying to click container------------"
  end
  @video_screen.video_container.click
  Retriable.retriable(on: Selenium::WebDriver::Error::NoSuchElementError, tries: 5, base_interval: 1, on_retry: retry_proc) do
    @video_screen.wait_until(30) { expect(@video_screen.forward_button.displayed?).to be_truthy }
    @initial_time = @video_screen.video_current_time
    Kernel.puts "video displayed current #{@initial_time}"
    @video_screen.forward_button.click
    @after_forwarding = @video_screen.video_current_time
    Kernel.puts "video displayed #{@after_forwarding}"
  end
end

And("I scrub backwards on the video for eventor") do
  @video_screen = VideoScreen.new
  retry_proc = proc do
    @video_screen.video_container.click
    Kernel.puts "---------retrying to click container------------"
  end
  @video_screen.video_container.click
  Retriable.retriable(on: Selenium::WebDriver::Error::NoSuchElementError, tries: 5, base_interval: 1, on_retry: retry_proc) do
    expect(@video_screen.rewind_button.displayed?).to be_truthy
    @start_time = @video_screen.video_current_time
    Kernel.puts "video displayed current #{@start_time}"
    @video_screen.rewind_button.click
    @after_rewind = @video_screen.video_current_time
    Kernel.puts "video displayed #{@after_rewind}"
  end
end
