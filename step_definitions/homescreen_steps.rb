Given("I am on home screen") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(60) { @home_screen.home_hero.displayed? }
  @home_screen.wait_until(60) { @home_screen.home_icon.displayed? }
end

When("I see home hero") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { @home_screen.home_hero.displayed? }
end

When("I start home hero series") do
  step "I see home hero"
  @home_screen.cta_button.click
end

Then("I see home hero metadata") do
  @home_screen = HomeScreen.new
  @shows_screen = ShowScreen.new
  @home_screen.wait_until(30) { expect(@home_screen.homeherotitleimage.displayed?).to be_truthy }
  @home_screen.wait_until(30) { expect(@shows_screen.show_description.displayed?).to be_truthy }
  @home_screen.wait_until(30) { expect(@home_screen.cta_button.displayed?).to be_truthy }
  @home_screen.wait_until(30) { expect(@home_screen.hero_genre.displayed?).to be_truthy }
  @home_screen.wait_until(30) { expect(@home_screen.hero_show_logo.displayed?).to be_truthy }
end

Then("I see the show detail screen page") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.show_hero_image.displayed?).to be_truthy }
end

Then("Validating different rails on home screen") do
  @home_screen = HomeScreen.new
  episodes_name = ["Just Added", "Unlocked Episodes", "Trending Shows", "Continue Watching"]
  @home_screen.scroll_down
  @home_screen.scroll_down if @home_screen.rail_section_title.displayed?
  scroll_count = 0
  loop do
    @carousel_name = @home_screen.rail_section_title.text
    if episodes_name.include?(@carousel_name)
      expect(@home_screen.wait_until(30) { @home_screen.rail_section_title.displayed? }).to be true
      puts "Validating Home screen rail as: #{@home_screen.rail_section_title.text}"
      step "I see carousel title on rail"
    else
      puts "#{@carousel_name} rail is not under validation"
    end
    @home_screen.scroll_down
    scroll_count += 1
    break if scroll_count == 15
  end
end

Then("I see carousel title on rail") do
  @home_screen = HomeScreen.new
  expect(@home_screen.carousels(@carousel_name).displayed?).to be_truthy
  puts "#{@home_screen.rail_section_title.text} rail is present in home screen with title."
end

Then("Validating {string} rail tiles on home screen") do |header_title|
  @home_screen = HomeScreen.new
  @home_screen.scroll_to_episode(header_title)
end

Then("I see {string} rail with tiles") do |carouselname|
  @home_screen = HomeScreen.new
  max_swapping_round = 3
  start_tile_index = 1
  start_x = @home_screen.carousel_header_desc(carouselname).location.x + 600
  start_y = @home_screen.carousel_header_desc(carouselname).location.y + 500
  end_x = start_x - 400
  end_y = start_y
  (1..max_swapping_round).each do |_i|
    expect(@home_screen.just_added_tiles(carouselname, start_tile_index).displayed?).to be_truthy
    expect(@home_screen.just_added_tiles(carouselname, start_tile_index + 1).displayed?).to be_truthy
    @home_screen.scroll_by_coordinates(start_x, start_y, end_x, end_y)
  end
end

Then("I scroll horizontally {string} for {string} rail tiles and verify") do |direction, carousel|
  @home_screen = HomeScreen.new
  start_x = @home_screen.rail_header_name(carousel).location.x + 600
  start_y = @home_screen.rail_header_name(carousel).location.y + 250
  end_x = start_x - 400
  end_y = start_y
  case direction
  when "left"
    tile_before_scroll = @home_screen.carousel_tile_name(carousel).text
    @home_screen.scroll_by_coordinates(start_x, start_y, end_x, end_y)
    tile_after_scroll = @home_screen.carousel_tile_name(carousel).text
  when "right"
    tile_before_scroll = @home_screen.carousel_tile_name(carousel).text
    @home_screen.scroll_by_coordinates(end_x, start_y, start_x, end_y)
    tile_after_scroll = @home_screen.carousel_tile_name(carousel).text
  end
  @home_screen.wait_until(30) { expect(tile_before_scroll != tile_after_scroll).to be_truthy }
end

Then("I see Shows rail with tiles") do
  @home_screen = HomeScreen.new
  max_swapping_round = 3
  first_tile_index = 1
  tile_size = @home_screen.show_tile(first_tile_index).size
  start_x = driver.window_size.width - tile_size.width
  start_y = @home_screen.shows_header_desc.location.y + tile_size.height / 2
  end_x = start_x - tile_size.width
  end_y = start_y
  (1..max_swapping_round).each do |_i|
    expect(@home_screen.show_tile(first_tile_index).displayed?).to be_truthy
    expect(@home_screen.show_tile(first_tile_index + 1).displayed?).to be_truthy
    @home_screen.scroll_by_coordinates(start_x, start_y, end_x, end_y)
  end
end

When("I tap on show tile in rail") do
  @home_screen = HomeScreen.new
  tile_name = @home_screen.show_tile_name("Trending Shows").text
  puts tile_name.to_s
  @home_screen.show_tile_name("Trending Shows").click
end

When("I see playlist details screen") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.show_hero_image.displayed?).to be_truthy
end

Then("I open all navigation screens and validate network logo in it") do
  @home_screen = HomeScreen.new
  expect(@home_screen.network_logo.displayed?).to be_truthy
  step "I go to the 'Shows' screen"
  expect(@home_screen.network_logo.displayed?).to be_truthy
  step "I go to the 'Live' screen"
  expect(@home_screen.network_logo.displayed?).to be_truthy
  step "I go to the 'Search' screen"
  expect(@home_screen.network_logo.displayed?).to be_truthy
  step "I go to the 'Account' screen"
  expect(@home_screen.network_logo.displayed?).to be_truthy
end

Then("I tap on network logo in all navigation screen and it returns to homepage") do
  @home_screen = HomeScreen.new
  @home_screen.network_logo.click
  step "I am on 'Home' screen"
  step "I go to the 'Shows' screen"
  @home_screen.network_logo.click
  step "I am on 'Home' screen"
  step "I go to the 'Live' screen"
  @home_screen.network_logo.click
  step "I am on 'Home' screen"
  step "I go to the 'Search' screen"
  @home_screen.network_logo.click
  step "I am on 'Home' screen"
  step "I go to the 'Account' screen"
  @home_screen.network_logo.click
  step "I am on 'Home' screen"
end

And("I scroll down") do
  @home_screen = HomeScreen.new
  @home_screen.scroll_down
end

And("I scroll up") do
  @home_screen = HomeScreen.new
  @home_screen.scroll_up
end

And("I scroll up and header slides down and is visible") do
  @home_screen = HomeScreen.new
  @home_screen.scroll_up
  expect(@home_screen.network_logo.displayed?).to be_truthy
end

And("I select a playlist through hero carousel") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { @home_screen.cta_button_text("View Playlist").displayed? }
  @home_screen.cta_button_text("View Playlist").click
end

Then("I see Hero carousel indicator") do
  @home_screen = HomeScreen.new
  expect(@home_screen.hero_carousel_indicator.displayed?).to be_truthy
end

Then("I see network logo on the top-right in the home page") do
  @home_screen = HomeScreen.new
  expect(@home_screen.affiliate_logo.displayed?).to be_truthy
end

Then("I see maximum number slides to be one") do
  @home_screen = HomeScreen.new
  max_slides = 4
  first_title = @home_screen.subtitle.text
  count = 0
  while count < max_slides
    @home_screen.scroll_home_hero_left
    current_title = @home_screen.subtitle.text
    count += 1
    break if first_title == current_title
  end
  puts "No of slides: #{count}"
end

Then("I scrolled the homepage to the On Now Rail") do
  step "Validating 'Streaming Live on GO' rail tiles on home screen"
  step "I scroll down"
end

Then("I see Metadata on each tile containing, thumbnail image, title, subtitle & Progressed indicator") do
  @home_screen = HomeScreen.new
  expect(@home_screen.continue_watching_progress.displayed?).to be_truthy
  expect(@home_screen.thumbnail_image.displayed?).to be_truthy
  expect(@home_screen.title.displayed?).to be_truthy
end

Then("I tap on any tile in the on {string} rail") do |carouselname|
  @home_screen = HomeScreen.new
  @home_screen.first_episode_on_rail(carouselname).click
end

Then("I tap on any tile in the on now rail") do
  @home_screen = HomeScreen.new
  expect(@home_screen.liveon_lockicon.displayed?).to be_truthy
  @home_screen.liveon_lockicon.click
end

Then("I scroll horizontally {string} for {string} rail tiles with tag and verify") do |direction, carousel|
  @home_screen = HomeScreen.new
  start_x = @home_screen.rail_header_name(carousel).location.x + 600
  start_y = @home_screen.rail_header_name(carousel).location.y + 250
  end_x = start_x - 400
  end_y = start_y
  case direction
  when "left"
    tile_before_scroll = @home_screen.tile_name_with_tag(carousel).text
    @home_screen.scroll_by_coordinates(start_x, start_y, end_x, end_y)
    tile_after_scroll = @home_screen.tile_name_with_tag(carousel).text
  when "right"
    tile_before_scroll = @home_screen.tile_name_with_tag(carousel).text
    @home_screen.scroll_by_coordinates(end_x, start_y, start_x, end_y)
    tile_after_scroll = @home_screen.tile_name_with_tag(carousel).text
  end
  @home_screen.wait_until(30) { expect(tile_before_scroll != tile_after_scroll).to be_truthy }
end

And("I have watched few episodes partially") do
  @search_screen = SearchScreen.new
  @home_screen = HomeScreen.new
  step "video is playing I tap on 10sec forward button multiple times"
  step "I see 'pause' on the player"
  step "I tap on 'player back' button"
  step "I tap on device back"
  step "I tap on 'x' button in search text field"
  @search_screen.wait_until(30) { @search_screen.search_text_field.displayed? }
  @search_screen.search_text_field.send_keys(NETWORK_DATA.show_search[:show_name_atv])
  @search_screen.wait_until(30) { @search_screen.second_show.displayed? }
  @search_screen.second_show.click
  @search_screen.wait_until(30) { @search_screen.watch_button.displayed? }
  @search_screen.watch_button.click
  step "video is playing I tap on 10sec forward button multiple times"
  step "I see 'pause' on the player"
  step "I tap on 'player back' button"
  step "I tap on device back"
  step "I go to the 'Home' screen"
end

Then("I tap on {string} and header slides down and is visible") do |option|
  @base_screen = BaseScreen.new
  @home_screen = HomeScreen.new
  @shows_screen = ShowScreen.new
  @search_screen = SearchScreen.new

  case option
  when "Home"
    expect(@base_screen.home_icon.displayed?).to be_truthy
    @base_screen.home_icon.click
    expect(@home_screen.network_logo.displayed?).to be_truthy

  when "Live"
    expect(@base_screen.live_icon.displayed?).to be_truthy
    @base_screen.live_icon.click
    expect(@shows_screen.shows_network_list.size.positive?).to be_truthy
    expect(@home_screen.network_logo.displayed?).to be_truthy

  when "Search"
    expect(@search_screen.search_text_field.displayed?).to be_truthy
    expect(@base_screen.search_icon.displayed?).to be_truthy
    @base_screen.search_icon.click
    expect(@home_screen.network_logo.displayed?).to be_truthy
  end
end

Then("I scroll down in all navigation tabs later switch tab and validate scroll position") do
  @home_screen = HomeScreen.new
  @shows_screen = ShowScreen.new
  step "I scroll down"
  rail_before_switch = @home_screen.rail_section_title.text
  step "I go to the 'Shows' screen"
  step "I go to the 'Home' screen"
  rail_after_switch = @home_screen.rail_section_title.text
  expect(rail_before_switch == rail_after_switch).to be_truthy
  puts "Scroll position verified for Home screen"
  step "I go to the 'Shows' screen"
  step "I scroll down"
  show_before_switch = @shows_screen.list_of_shows.first.text
  step "I go to the 'Home' screen"
  step "I go to the 'Shows' screen"
  show_after_switch = @shows_screen.list_of_shows.first.text
  expect(show_before_switch == show_after_switch).to be_truthy
  puts "Scroll position verified for Shows screen"
  step "I go to the 'Search' screen"
  step "I scroll down"
  rail_before_switch = @home_screen.rail_section_title.text
  step "I go to the 'Home' screen"
  step "I go to the 'Search' screen"
  rail_after_switch = @home_screen.rail_section_title.text
  expect(rail_before_switch == rail_after_switch).to be_truthy
  puts "Scroll position verified for Search screen"
end

Then("I validate metadata on rails") do
  @home_screen = HomeScreen.new
  rails_name = ["Just Added", "Trending Shows"]
  rails_name.each do |val|
    @home_screen.scroll_to_episode(val)
    show_name_list = @home_screen.show_title_list(val)
    show_name_list.each do |showtitle|
      puts "#{showtitle.text} is show title for #{val} Rail"
      expect(showtitle.text.empty?).not_to be_truthy
    end
    expect(@home_screen.show_image_list(val).size.positive?).to be_truthy
    expect(@home_screen.show_logo_list(val).size.positive?).to be_truthy
  end
end

Then("I scroll left and right on sub-nav") do
  @home_screen = HomeScreen.new
  @home_screen.scroll_down
  @home_screen.scroll_sub_nav_left
  puts "Swiped Left"
  expect(@home_screen.network_logo.displayed?).to be_truthy
  @home_screen.scroll_sub_nav_right
  puts "Swiped Right"
  expect(@home_screen.network_logo.displayed?).to be_truthy
end

And("I select a {string} from home screen") do |header_title|
  @home_screen = HomeScreen.new
  @shows_screen = ShowScreen.new
  case header_title
  when "DiscoveryPlusOriginals"
    @home_screen.scroll_down
    @home_screen.network_name.first.click
  when "TLC"
    @shows_screen.wait_until(30) { @shows_screen.back_arrow.displayed? }
    if @home_screen.network_name.size.positive?
      @home_screen.network_name.last.displayed?
    else
      @home_screen.scroll_to_episode("Discover Our Originals")
      @home_screen.scroll_down
    end
    @home_screen.network_name.last.click
  end
end

And("I see network logo, hero image and network description") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { expect(@home_screen.network_hero_title_image.first.displayed?).to be_truthy }
end

Then("I see Dplus logo on the top in the home page") do
  @home_screen = HomeScreen.new
  expect(@home_screen.dplus_logo.first.displayed?).to be_truthy
end

And("I scroll down and see sub nav still appears and Dplus logo disappear") do
  @shows_screen = ShowScreen.new
  4.times { @shows_screen.scroll_down }
  @home_screen.wait_until(30) { @home_screen.for_you.displayed? }
  expect(@home_screen.dplus_logo.size.positive?).to be false
end

Then("I am taken to the specific network screen") do
  @home_screen = HomeScreen.new
  step "I tap on device back"
  25.times { @home_screen.scroll_down }
  @home_screen.wait_until(30) { expect(@home_screen.ntwrk_name_discoveryoriginals.displayed?).to be_truthy }
end

Then("I see the TV Network logo does not remain persistent in the top left") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { expect(@home_screen.navigate_back.displayed?).to be_truthy }
  @home_screen.wait_until(30) { expect(@home_screen.network_hero_title_image.first.displayed?).to be_truthy }
  4.times { @home_screen.scroll_down }
  @home_screen.wait_until(30) { expect(@home_screen.ntwrk_name_tlc.displayed?).to be_truthy }
  expect(@home_screen.network_hero_title_image.size.positive?).to be false
end

Then("I swipe left-right within sub-nav and validate hero metadata") do
  @home_screen = HomeScreen.new
  max_slides = ["For You", "Relationships", "True Crime", "Home"]
  (1..max_slides.length - 1).each do |i|
    @home_screen.sub_nav_tab(max_slides[i]).click
    step "I see home hero metadata"
  end
end

When("I tap on any tile from playlist rail") do
  @home_screen = HomeScreen.new
  step "I navigate to 'discovery+ Collections' rail with tiles"
  @home_screen.wait_until(30) { expect(@home_screen.show_tile_name("discovery+ Collections").displayed?).to be_truthy }
  @home_screen.show_tile_name("discovery+ Collections").click
end

When("I tap on any episode tile from playlist landing screen") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.show_hero_image.displayed?).to be_truthy }
  @shows_screen.list_of_shows[1].click
end

And("I validate playlist landing page metadata") do
  @shows_screen = ShowScreen.new
  @shows_screen.wait_until(30) { expect(@shows_screen.show_hero_image.displayed?).to be_truthy }
  expect(@shows_screen.list_of_shows.size.positive?).to be_truthy
end

Then("I swipe left-right within sub-nav and validate page changes") do
  @home_screen = HomeScreen.new
  max_slides = 5
  @before_swipe_hero_desc = @home_screen.home_hero_show_description.text
  puts "before swipe hero desc  #{@before_swipe_hero_desc}"
  puts @home_screen.sub_nav_list.size
  (1..max_slides - 1).each do |i|
    @home_screen.sub_nav_list[i].click
    @home_screen.wait_until(60) { @home_screen.homeherotitleimage.displayed? }
    @after_swipe_hero_desc = @home_screen.home_hero_show_description.text
    puts "After swipe hero desc  #{@after_swipe_hero_desc}"
    expect(@before_swipe_hero_desc.include?(@after_swipe_hero_desc)).to be false
  end
end

Then("I see For You sub-nav item is shown or in focus") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { @home_screen.for_you.displayed? }
  @home_screen.wait_until(30) { expect(@home_screen.for_you.attribute("selected")).to be_truthy }
end

Then("I see the {string} in first position") do |_carouselname|
  step "I see carousel title on rail"
end

Then("I have previously in-progress episodes in continue watching rail") do
  step "I open show detail screen in which an episode is partly watched"
  step "I tap on device back"
  step "I go to the 'Home' screen"
  step "I navigate to 'Continue Watching' rail with tiles"
end

Then("I tap on any video in continue watching rail button and verify episode resuming from where I left") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { expect(@home_screen.show_tile_name("Continue Watching").displayed?).to be_truthy }
  @home_screen.show_tile_name("Continue Watching").click
  step "Verify episode resuming from where I left"
end

And("I tap on For You sub-nav item from sub-nav bar") do
  step "I see For You sub-nav item is shown or in focus"
  @home_screen.for_you.click
end

Then("I tap on relationships sub-nav item from sub-nav bar") do
  @home_screen = HomeScreen.new
  @home_screen.wait_until(30) { @home_screen.relationships.displayed? }
  @home_screen.relationships.click
  @home_screen.wait_until(30) { expect(@home_screen.relationships.attribute("selected")).to be_truthy }
end

Then("I am taken to the DiscoveryPlus Originals network screen") do
  @home_screen = HomeScreen.new
  5.times { @home_screen.scroll_down }
  @home_screen.wait_until(30) { expect(@home_screen.ntwrk_name_discoveryoriginals.displayed?).to be_truthy }
end

When('I tap on any show tile on {string} rail') do |string|
  @home_screen = HomeScreen.new
  tile_name = @home_screen.show_tile_name("Recommended For You").text
  puts tile_name.to_s
  @home_screen.show_tile_name("Recommended For You").click
end

Then("I see show details screen for that show") do
  @shows_screen = ShowScreen.new
  expect(@shows_screen.show_hero_image.displayed?).to be_truthy
end  
