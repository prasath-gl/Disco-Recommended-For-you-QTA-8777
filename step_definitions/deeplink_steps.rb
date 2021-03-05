Given("I enter the deep link URL of any unlocked promotional show") do
  driver.get("#{NETWORK_DATA.deeplink_prefix}/show/90-day-fiance-the-other-way")
end

Given("I enter the deep link URL of home screen") do
  driver.get("#{NETWORK_DATA.deeplink_prefix}/home")
end

Given("I enter the deep link URL of any video episode from show screen") do
  driver.get("#{NETWORK_DATA.deeplink_prefix}/video/what-you-get-for-the-money/300000-home-showcase")
end

Given("I enter the deep link URL of browse screen") do
  driver.get("#{NETWORK_DATA.deeplink_prefix}/shows")
end

Given("I enter the deep link URL of account screen") do
  driver.get("#{NETWORK_DATA.deeplink_prefix}/account")
end

Given("I enter the deep link URL of mylist screen") do
  driver.get("#{NETWORK_DATA.deeplink_prefix}/my-list")
end

Given("I enter the deep link URL of playlist screen") do
  driver.get("#{NETWORK_DATA.deeplink_prefix}/playlist/food-on-the-road")
end
