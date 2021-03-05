Given("I navigate to create account screen") do
  step "I am on welcome screen"
  step "I tap on 'Start Free Trial'"
  step "I choose 'Limited Ads' plan"
  step "I tap on 'Continue'"
  step "I am on create account screen"
end

Then("I see password instructions under password field") do
  step "I see error message below 'password' text box"
end

When("I enter email id that is not valid") do
  step "I enter email 'adcde'"
end

Then("I see error message below {string} text box") do |field|
  @login_screen = LoginScreen.new
  case field
  when "email"
    expect(@login_screen.email_error.displayed?).to be_truthy
  when "password"
    @registration_screen = RegistrationScreen.new
    expect(@registration_screen.invalid_password_error.displayed?).to be_truthy
  end
end

And("I enter password that does not meet requirement") do
  step "I enter password 'abcde'"
end

And("I left all input text fields empty") do
  @registration_screen = RegistrationScreen.new
  step "I am on create account screen"
  @registration_screen.wait_until(30) { expect(@registration_screen.email_field.displayed?).to be_truthy }
  @registration_screen.wait_until(30) { expect(@registration_screen.password_field.displayed?).to be_truthy }
end

When("I tap on Agree & Continue") do
  @registration_screen = RegistrationScreen.new
  @registration_screen.wait_until(30) { expect(@registration_screen.agree_and_continue_btn.displayed?).to be_truthy }
  @registration_screen.agree_and_continue_btn.click
end

Then("I should see a valid inline error message under username and password fields") do
  step "I get 'email' error"
  @registration_screen = RegistrationScreen.new
  @registration_screen.wait_until(30) { expect(@registration_screen.blank_pwd_error.displayed?).to be_truthy }
end

And("I should be on the create account screen") do
  step "I am on create account screen"
end

When("I enter the username, password and tap on outside of the keyboard") do
  step "I enter email 'android.123@test.com'"
  step "I tap on create Account title"
  step "The keyboard should be hidden"
  step "I tap on create account password input text field"
  step "The keyboard should be enabled"
  step "I enter password 'Android.123'"
  step "I tap on create Account title"
end

And("I should see create account screen with characters entered in username and password fields") do
  @registration_screen = RegistrationScreen.new
  @registration_screen.wait_until(30) { @registration_screen.password_field.displayed? }
  expect(@registration_screen.email_field.text).to eql("android.123@test.com")
  @registration_screen.wait_until(30) { @registration_screen.password_field.displayed? }
  expect(@registration_screen.password_field.text).to eql("Android.123")
end

Then("I tap on create Account title") do
  @login_screen = LoginScreen.new
  start_x = @login_screen.create_account_title.location.x
  start_y = @login_screen.create_account_title.location.y
  @login_screen.tap_by_coordinates(start_x, start_y)
end

Then("The keyboard should be hidden") do
  @registration_screen = RegistrationScreen.new
  @registration_screen.wait_until(30) { expect(@registration_screen.driver.is_keyboard_shown).to be_falsey }
end

Then("The keyboard should be enabled") do
  @registration_screen = RegistrationScreen.new
  @registration_screen.wait_until(30) { expect(@registration_screen.driver.is_keyboard_shown).to be_truthy }
end

Then("I tap on create account username input text field") do
  @registration_screen = RegistrationScreen.new
  @registration_screen.wait_until(30) { @registration_screen.email_field.displayed? }
  @registration_screen.email_field.click
end

Then("I tap on create account password input text field") do
  @registration_screen = RegistrationScreen.new
  @registration_screen.wait_until(30) { @registration_screen.password_field.displayed? }
  @registration_screen.password_field.click
end

Then("I enter email {string}") do |username|
  @registration_screen = RegistrationScreen.new
  @registration_screen.wait_until(30) { @registration_screen.email_field.displayed? }
  @registration_screen.email_field.send_keys(username)
end

Then("I enter password {string}") do |password|
  @registration_screen = RegistrationScreen.new
  @registration_screen.wait_until(30) { @registration_screen.password_field.displayed? }
  @registration_screen.password_field.send_keys(password)
end
