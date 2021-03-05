When("I go to account") do
  @account_screen = SettingScreen.new
  @account_screen.wait_until(30) { @account_screen.account_icon.displayed? }
  @account_screen.account_icon.click
end

And("I go to {string} screen") do |screen_name|
  @account_screen = SettingScreen.new
  case screen_name
  when "About"
    step "I am on 'Account' screen"
    expect(@account_screen.about_option.displayed?).to be_truthy
    @account_screen.about_option.click
  when "Help"
    expect(@account_screen.help_option.displayed?).to be_truthy
    @account_screen.help_option.click
  when "Visitor Agreement"
    expect(@account_screen.visitor_agreement_option.displayed?).to be_truthy
    @account_screen.visitor_agreement_option.click
  when "Nielsen Measurement"
    expect(@account_screen.nielsen_measurement_option.displayed?).to be_truthy
    @account_screen.nielsen_measurement_option.click
  when "Privacy Policy"
    expect(@account_screen.privacy_policy_option.displayed?).to be_truthy
    @account_screen.privacy_policy_option.click
  when "Calif. Do Not Sell My Info"
    expect(@account_screen.do_not_sell_option.displayed?).to be_truthy
    @account_screen.do_not_sell_option.click
  when "Online Closed Captioning"
    expect(@account_screen.online_captioning_option.displayed?).to be_truthy
    @account_screen.online_captioning_option.click
  when "My List"
    expect(@account_screen.my_list_option.displayed?).to be_truthy
    @account_screen.my_list_option.click
  when "Settings"
    step "I should see the following tabs - Account, Settings, Help, About and Sign Out"
    @account_screen.wait_until(30) { expect(@account_screen.settings.displayed?).to be_truthy }
    @account_screen.settings.click
  when "Push Notifications"
    expect(@account_screen.push_notification_option.displayed?).to be_truthy
    @account_screen.push_notification_option.click
  when "Manage Profile"
    expect(@account_screen.manage_profile.displayed?).to be_truthy
    @account_screen.manage_profile.click
  end
end

And("I see {string} on about screen") do |option_name|
  @account_screen = SettingScreen.new
  case option_name
  when "Visitor Agreement"
    expect(@account_screen.visitor_agreement_option.displayed?).to be_truthy
  when "Nielsen Measurement"
    expect(@account_screen.nielsen_measurement_option.displayed?).to be_truthy
  when "Privacy Policy"
    expect(@account_screen.privacy_policy_option.displayed?).to be_truthy
  when "Calif. Do Not Sell My Info"
    expect(@account_screen.do_not_sell_option.displayed?).to be_truthy
  when "Online Closed Captioning"
    expect(@account_screen.online_captioning_option.displayed?).to be_truthy
  end
end

Then("I should be able to see app info") do
  @account_screen = SettingScreen.new
  expect(@account_screen.app_info_option.displayed?).to be_truthy
end

Then("I should see error message") do
  @account_screen = SettingScreen.new
  expect(@account_screen.error_message.displayed?).to be_truthy
end

Then("I see web view of help page") do
  @account_screen = SettingScreen.new
  expect(@account_screen.help_web_view.displayed?).to be_truthy
end

Then("I see list of options") do
  @account_screen = SettingScreen.new
  expect(@account_screen.visitor_agreement_option.displayed?).to be_truthy
  expect(@account_screen.privacy_policy_option.displayed?).to be_truthy
  expect(@account_screen.online_captioning_option.displayed?).to be_truthy
  expect(@account_screen.do_not_sell_option.displayed?).to be_truthy
end

Then("I see my list screen") do
  @account_screen = SettingScreen.new
  expect(@account_screen.web_view_toolbar.text.match("My List")).to be_truthy
end

Then("I see Account page with affiliate logo") do
  @account_screen = SettingScreen.new
  @account_screen.wait_until(30) { @account_screen.affiliate_logo_acc_src.displayed? }
end

Then("I see message on account page to login") do
  @account_screen = SettingScreen.new
  @account_screen.wait_until(30) { @account_screen.link_tv_provider_text.displayed? }
end

Then("I see logged in message with affiliate name") do
  @account_screen = SettingScreen.new
  @account_screen.wait_until(30) { @account_screen.logged_in_message.displayed? }
  @account_screen.wait_until(30) { @account_screen.affiliate_logo_acc_src.displayed? }
end

Then("I tap on the Unlink Your TV Provider button") do
  @affiliate_screen = AffiliateLoginScreen.new
  @affiliate_screen.wait_until(30) { @affiliate_screen.unlink_tvprovider.displayed? }
  @affiliate_screen.unlink_tvprovider.click
end

Then("I see the message Link your TV provider to unlock all your favorite shows") do
  @account_screen = SettingScreen.new
  @account_screen.wait_until(30) { @account_screen.link_tv_provider_text.displayed? }
end

Then("I tap on back button") do
  @account_screen = SettingScreen.new
  @account_screen.account_back_btn
end

Then("{string} should be visible") do |screen|
  @account_screen = SettingScreen.new
  case screen
  when "Visitor Agreement"
    expect(@account_screen.web_view_toolbar.text.match("Visitor Agreement")).to be_truthy
  when "Privacy Policy"
    expect(@account_screen.web_view_toolbar.text.match("Privacy Notice")).to be_truthy
    expect(@account_screen.privacy_notice.displayed?).to be_truthy
  when "Online Closed Captioning"
    expect(@account_screen.web_view_toolbar.text.match("Closed Captioning")).to be_truthy
    expect(@account_screen.captioning_screen.displayed?).to be_truthy
  when "Calif. Do Not Sell Info"
    expect(@account_screen.calif_info.displayed?).to be_truthy
  when "Nielsen Measurement"
    expect(@account_screen.web_view_toolbar.text.match("Nielsen Measurement")).to be_truthy
    expect(@account_screen.nielsen_screen.displayed?).to be_truthy
  when "Push Notifications"
    expect(@account_screen.notification_screen.displayed?).to be_truthy
  when "About"
    expect(@account_screen.web_view_toolbar.text.match("About")).to be_truthy
  when "Settings"
    expect(@account_screen.web_view_toolbar.text.match("Settings")).to be_truthy
  when "Manage Account"
    expect(@account_screen.manage_account.displayed?).to be_truthy
  when "Sign Out"
    expect(@account_screen.sign_out.displayed?).to be_truthy
  when "Manage Profile"
    expect(@account_screen.manage_profile.displayed?).to be_truthy
  end
end

Then("I should see the following tabs - Account, Settings, Help, About and Sign Out") do
  @account_screen = SettingScreen.new
  expect(@account_screen.about_option.displayed?).to be_truthy
  expect(@account_screen.settings.displayed?).to be_truthy
  step "'Manage Account' should be visible"
  step "'Sign Out' should be visible"
end
