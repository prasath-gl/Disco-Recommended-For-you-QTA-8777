When("I tap on live tv icon") do
  @livetv_screen = BaseScreen.new
  @livetv_screen.wait_until(30) { @livetv_screen.live_icon.displayed? }
  @livetv_screen.live_icon.click
end

And("I should see series and episode count details") do
  @livetv_screen = LiveScreen.new
  @livetv_screen.wait_until(30) { @livetv_screen.series_episode_count.displayed? }
end

Then("I should see episode name below video player") do
  @livetv_screen = LiveScreen.new
  @livetv_screen.wait_until(30) { @livetv_screen.episode_title.displayed? }
end

When("I should see video discription") do
  @livetv_screen = LiveScreen.new
  @livetv_screen.wait_until(30) { @livetv_screen.video_discription.displayed? }
end

When("I should see series title") do
  @livetv_screen = LiveScreen.new
  @livetv_screen.wait_until(30) { @livetv_screen.series_title.displayed? }
end

And("I should Navigate to episode details") do
  @livetv_screen = LiveScreen.new
  @livetv_screen.wait_until(30) { @livetv_screen.episode_title.displayed? }
  @livetv_screen.episode_title.click
end

When("I should see episode name on description screen") do
  @livetv_screen = LiveScreen.new
  @livetv_screen.wait_until(30) { @livetv_screen.episode_name_detail_view_src.displayed? }
end

Then("I should see next up on tlc section header") do
  @livetv_screen = LiveScreen.new
  @livetv_screen.wait_until(30) { @livetv_screen.next_up_on_tlc.displayed? }
end

Then("I should see live content play's next with info") do
  @livetv_screen = LiveScreen.new
  @livetv_screen.wait_until(30) { @livetv_screen.scheduled_start.displayed? }
  @livetv_screen.wait_until(30) { @livetv_screen.nxt_video_thumbnail.displayed? }
  @livetv_screen.wait_until(30) { @livetv_screen.nxt_show_name.displayed? }
  @livetv_screen.wait_until(30) { @livetv_screen.episode_number.displayed? }
end

Then("I should see hero image with live badge") do
  @livetv_screen = LiveScreen.new
  expect(@livetv_screen.nxt_video_thumbnail.displayed?).to be_truthy
  expect(@livetv_screen.live_badge.displayed?).to be_truthy
  expect(@livetv_screen.live_badge.text.eql?("LIVE"))
end

Then("I should see live content metadata") do
  @livetv_screen = LiveScreen.new
  @shows_screen = ShowScreen.new
  expect(@livetv_screen.nxt_show_name.displayed?).to be_truthy
  expect(@livetv_screen.series_episode_count.displayed?).to be_truthy
  expect(@shows_screen.episode_description.displayed?).to be_truthy
end

Then("I see a list of contents in Upnext") do
  @livetv_screen = LiveScreen.new
  expect(@livetv_screen.upnext_header.displayed?).to be_truthy
end

Then("I see the Next item up with a play icon on it") do
  @livetv_screen = LiveScreen.new
  expect(@livetv_screen.playicon.displayed?).to be_truthy
  @livetv_screen.playicon.click
end

Then("I should see {string} in live page") do |icon_name|
  @livetv_screen = LiveScreen.new
  case icon_name
  when "progress bar"
    @livetv_screen.wait_until(30) { expect(@livetv_screen.progress_bar.displayed?).to be_truthy }
  when "On Now title"
    @livetv_screen.wait_until(30) { expect(@livetv_screen.section_title.displayed?).to be_truthy }
    expect(@livetv_screen.section_title.text.eql?("On Now"))
  when "hero title"
    @livetv_screen.wait_until(30) { expect(@livetv_screen.episode_title.displayed?).to be_truthy }
  end
end

Then("I click on live badge") do
  @livetv_screen = LiveScreen.new
  expect(@livetv_screen.live_badge.displayed?).to be_truthy
  @livetv_screen.live_badge.click
end

Then("I am a user on the app watching a LIVE asset") do
  step "I click on live badge"
  step "I complete the authentication successfully"
  step "video plays in portrait mode by default"
end

Then("I see live schedule of programs on all different networks") do
  @livetv_screen = LiveScreen.new
  @shows_screen = ShowScreen.new
  network_list = ["TLC", "Investigation Discovery", "HGTV", "Food Network", "Discovery", "Animal Planet"]
  list_size = @shows_screen.shows_network_list.size
  list_size.times do |i|
    @shows_screen.shows_network_list[i].click
    expect(@shows_screen.shows_network_list[i].attribute("selected")).to be_truthy
    puts("Network selected: #{network_list[i]}")
    if @livetv_screen.upnext_for_network(network_list[i]).displayed?
      puts("Up next available for selected network")
    else
      puts("Up next not available for selected network")
    end
  end
end
