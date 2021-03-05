When(/^I login as anonymous user$/) do
  @login_screen = LoginScreen.new
  @login_screen.debug_skip.first.click if @login_screen.debug_skip.size.positive?
end

And("I tap on {string}") do |button|
  @login_screen = LoginScreen.new
  case button
  when "Start Free Trial"
    @login_screen.wait_until(30) { @login_screen.free_trial.first.displayed? }
    @login_screen.free_trial.first.click
  when "Continue"
    @login_screen.wait_until(30) { @login_screen.continue_btn.displayed? }
    @login_screen.continue_btn.click
  when "Sign In"
    @login_screen.wait_until(30) { @login_screen.sign_in_button.displayed? }
    @login_screen.sign_in_button.click
  when "Forgot Password"
    @login_screen.wait_until(30) { @login_screen.sign_in_forgot_pwd.displayed? }
    @login_screen.sign_in_forgot_pwd.click
  end
end

And("I am in show detail screen") do
  step "I go to the 'Search' screen"
  step "I type 'Say yes to Atlanta' in search text field"
  step "I see 'Shows' results for searched text"
  step "I tap on any show in the result"
end

Given("I am on welcome screen") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { expect(@login_screen.welcome_msg.displayed?).to be_truthy }
end

Then("I see {string} button displayed") do |button_text|
  @login_screen = LoginScreen.new
  case button_text
  when "Start Free Trial"
    @login_screen.wait_until(30) { expect(@login_screen.free_trial.first.displayed?).to be_truthy }

  when "Sign In"
    @login_screen.wait_until(30) { expect(@login_screen.sign_in_button.displayed?).to be_truthy }
  end
end

Then("I validate welcome screen features") do
  @login_screen = LoginScreen.new
  expect(@login_screen.welcome_screen_logo.displayed?).to be_truthy
  expect(@login_screen.welcome_desc.displayed?).to be_truthy
  expect(@login_screen.offer_text.displayed?).to be_truthy
  step "I see 'Start Free Trial' button displayed"
  step "I see 'Sign In' button displayed"
end

Then("I am on plan picker screen") do
  @login_screen = LoginScreen.new
  expect(@login_screen.plan_picker_title.displayed?).to be_truthy
  expect(@login_screen.plan_picker_msg.displayed?).to be_truthy
  expect(@login_screen.limited_ads_plan.displayed?).to be_truthy
  expect(@login_screen.no_ads_plan.displayed?).to be_truthy
  expect(@login_screen.continue_btn.displayed?).to be_truthy
end

And("I choose {string} plan") do |button_text|
  @login_screen = LoginScreen.new
  case button_text
  when "Limited Ads"
    @login_screen.wait_until(30) { expect(@login_screen.limited_ads_plan.displayed?).to be_truthy }
    @login_screen.limited_ads_plan.click

  when "No Ads"
    @login_screen.wait_until(30) { expect(@login_screen.no_ads_plan.displayed?).to be_truthy }
    @login_screen.no_ads_plan.click
  end
end

Then("I am on create account screen") do
  @login_screen = LoginScreen.new
  expect(@login_screen.create_account_title.displayed?).to be_truthy
end

And("I shall be taken to Sign In screen") do
  @login_screen = LoginScreen.new
  expect(@login_screen.sign_in_screen.size.positive?).to be_truthy
end

Then("Run app in background for few seconds and relaunch the app") do
  $driver.background_app(5)
end

And("I am informed of free trial") do
  @login_screen = LoginScreen.new
  expect(@login_screen.plan_picker_msg.displayed?).to be_truthy
end

And("I tap on device back") do
  @login_screen = LoginScreen.new
  @login_screen.device_back
end

And("I focus on {string} text field") do |field|
  @login_screen = LoginScreen.new
  case field
  when "email"
    expect(@login_screen.sign_in_email.displayed?).to be_truthy
    @login_screen.sign_in_email.click
  when "password"
    expect(@login_screen.sign_in_pwd.displayed?).to be_truthy
    @login_screen.sign_in_pwd.click
  end
end

And("I change focus to {string}") do |field|
  @login_screen = LoginScreen.new
  case field
  when "email"
    step "I focus on 'email' text field"
  when "password"
    step "I focus on 'password' text field"
  end
end

Then("I get {string} error") do |field|
  @login_screen = LoginScreen.new
  case field
  when "email"
    expect(@login_screen.blank_email_error.displayed?).to be_truthy
  when "password"
    expect(@login_screen.blank_pwd_error.displayed?).to be_truthy
  end
end

Then("I shall be taken to reset password screen") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { expect(@login_screen.reset_pwd_screen.displayed?).to be_truthy }
end

Given("I am on reset password screen") do
  step "I tap on 'Sign In'"
  step "I tap on 'Forgot Password'"
  step "I shall be taken to reset password screen"
end

When("I enter invalid email address for resetting password") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.reset_pwd_email.displayed? }
  @login_screen.reset_pwd_email.send_keys("abcde")
end

And("I enter the email and password associated with my Discovery+ account") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.email_text_field.displayed? }
  @login_screen.email_text_field.click
  @login_screen.email_text_field.send_keys(ENV["DTC_EMAIL"])
  @login_screen.wait_until(30) { @login_screen.password_text_field.displayed? }
  @login_screen.password_text_field.click
  @login_screen.password_text_field.send_keys(ENV["DTC_PASSWORD"])
  @login_screen.driver.hide_keyboard
  retry_proc = proc do
    @login_screen.email_text_field.displayed?
    Kernel.puts "---------retrying to click continue------------"
  end
  Retriable.retriable(on: Selenium::WebDriver::Error::NoSuchElementError, tries: 7, base_interval: 1, on_retry: retry_proc) do
    expect(@login_screen.wait_until(30) { @login_screen.continue_btn.displayed? }).to be true
    @login_screen.continue_btn.click
  end
  step "I should select a profile from who is watching screen" if ENV["ANDROID_DEVICE_NAME"].include?("Tab")
end

And("I enter the adlite email and password associated with my Discovery+ account") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.email_text_field.displayed? }
  @login_screen.email_text_field.click
  @login_screen.email_text_field.send_keys(ENV["DTC_ADLITE_EMAIL"])
  @login_screen.wait_until(30) { @login_screen.password_text_field.displayed? }
  @login_screen.password_text_field.click
  @login_screen.password_text_field.send_keys(ENV["DTC_ADLITE_PASSWORD"])
  @login_screen.driver.hide_keyboard
  retry_proc = proc do
    @login_screen.email_text_field.displayed?
    Kernel.puts "---------retrying to click continue------------"
  end
  Retriable.retriable(on: Selenium::WebDriver::Error::NoSuchElementError, tries: 7, base_interval: 1, on_retry: retry_proc) do
    expect(@login_screen.wait_until(30) { @login_screen.continue_btn.displayed? }).to be true
    @login_screen.continue_btn.click
  end
  step "I should select a profile from who is watching screen" if ENV["ANDROID_DEVICE_NAME"].include?("Tab")
end

And("I enter the adlite2 email and password associated with my Discovery+ account") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.email_text_field.displayed? }
  @login_screen.email_text_field.click
  @login_screen.email_text_field.send_keys(ENV["DTC_ADLITE2_EMAIL"])
  @login_screen.wait_until(30) { @login_screen.password_text_field.displayed? }
  @login_screen.password_text_field.click
  @login_screen.password_text_field.send_keys(ENV["DTC_ADLITE2_PASSWORD"])
  @login_screen.driver.hide_keyboard
  retry_proc = proc do
    @login_screen.email_text_field.displayed?
    Kernel.puts "---------retrying to click continue------------"
  end
  Retriable.retriable(on: Selenium::WebDriver::Error::NoSuchElementError, tries: 7, base_interval: 1, on_retry: retry_proc) do
    expect(@login_screen.wait_until(30) { @login_screen.continue_btn.displayed? }).to be true
    @login_screen.continue_btn.click
  end
  step "I should select a profile from who is watching screen" if ENV["ANDROID_DEVICE_NAME"].include?("Tab")
end

Given("I login using adlite2 account") do
  step "I am on welcome screen"
  step "I tap on 'Sign In'"
  step "I enter the adlite2 email and password associated with my Discovery+ account"
  step "I am on home screen"
end

Given("I login using adlite account") do
  step "I am on welcome screen"
  step "I tap on 'Sign In'"
  step "I enter the adlite email and password associated with my Discovery+ account"
  step "I am on home screen"
end

Given("I am an auth user") do
  step "I am on welcome screen"
  step "I tap on 'Sign In'"
  step "I enter the email and password associated with my Discovery+ account"
  step "I am on home screen"
end

And("I select a default my profile") do
  @login_screen = LoginScreen.new
  @login_screen.my_profile.click
end

When("I should click on sign out button") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.sign_out_button.displayed? }
  @login_screen.sign_out_button.click
end

When("I should see a warning") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.sign_out_message.displayed? }
end

And("I should see and click on {string} button") do |button|
  @login_screen = LoginScreen.new
  case button
  when "Yes"
    @login_screen.wait_until(30) { expect(@login_screen.sign_out_yes.displayed?).to be_truthy }
    @login_screen.sign_out_yes.click
  when "No"
    @login_screen.wait_until(30) { expect(@login_screen.sign_out_no.displayed?).to be_truthy }
    @login_screen.sign_out_no.click
  end
end

When("I should see a invalid password error message") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.blank_pwd_error.displayed? }
end

When("I should see a invalid email error message") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.blank_email_error.displayed? }
end

When("I enter valid email address and invalid password") do
  @login_screen = LoginScreen.new
  @login_screen.email_text_field.send_keys("abcde@gmail.com")
  @login_screen.password_text_field.send_keys("abcde")
end

When("I enter invalid email address in sign in screen") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.email_text_field.displayed? }
  @login_screen.email_text_field.send_keys("abcde")
end

When("I should then see an error message with signup and tryagain button") do
  @login_screen = LoginScreen.new
  @login_screen.wait_until(30) { @login_screen.invalid_entry_message.displayed? }
  @login_screen.wait_until(30) { @login_screen.sign_up.displayed? }
  @login_screen.wait_until(30) { @login_screen.try_again.displayed? }
end

When("I am on manage account screen") do
  @account_screen = SettingScreen.new
  step "I go to the 'Account' screen"
  step "I am on 'Account' screen"
  @account_screen.wait_until(30) { @account_screen.manage_account_screen.size.positive? }
  @account_screen.manage_account_screen.first.click
end

And("I update invalid email address in manage account screen") do
  @account_screen = SettingScreen.new
  @account_screen.wait_until(30) { @account_screen.update_email_btn.displayed? }
  @account_screen.update_email_btn.click
  @account_screen.wait_until(30) { @account_screen.change_email_field.displayed? }
  @account_screen.change_email_field.send_keys("abcde")
end

And("I update same email address in manage account screen") do
  @account_screen = SettingScreen.new
  @account_screen.wait_until(30) { @account_screen.update_email_btn.displayed? }
  @account_screen.update_email_btn.click
  @account_screen.wait_until(30) { @account_screen.change_email_field.displayed? }
  @account_screen.change_email_field.send_keys(ENV["DTC_EMAIL"])
end

Then("I should be shown an error to inform me that the email entered is wrong") do
  @account_screen = SettingScreen.new
  expect(@account_screen.same_email_error.displayed?).to be_truthy
end
