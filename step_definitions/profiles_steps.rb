Then("I tap on Add Profile") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { @profiles_screen.add_profile_btn.displayed? }
  @profiles_screen.add_profile_btn.click
end

And("I am on create profile Screen") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { @profiles_screen.create_profile_screen.displayed? }
end

Then("I should see list of profiles, Add Profile and Manage profile options") do
  @profiles_screen = ProfilesScreen.new
  count = @profiles_screen.profile_names_list.size
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  @profiles_screen.wait_until(30) { expect(@profiles_screen.add_profile_button.displayed?).to be_truthy } if count < 3
  if count >= 3 && count < 5
    step "Scroll to left"
    @profiles_screen.wait_until(30) { expect(@profiles_screen.add_profile_button.displayed?).to be_truthy }
  end
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profiles_list.size.positive?).to be_truthy }
end

And("I tap on Add Profile button") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  name_count = @profiles_screen.profile_names_list.size
  if name_count < 3
    @profiles_screen.wait_until(30) { @profiles_screen.add_profile_button.displayed? }
    @profiles_screen.add_profile_button.click
  end

  if name_count >= 3 && name_count < 5
    step "Scroll to left"
    @profiles_screen.wait_until(30) { @profiles_screen.add_profile_button.displayed? }
    @profiles_screen.add_profile_button.click
  end
end

And("I tap on profile name input text field and enter profile name") do
  @profiles_screen = ProfilesScreen.new
  @p_name = @profiles_screen.random_string
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name_input_field.displayed?).to be_truthy }
  @profiles_screen.profile_name_input_field.click
  @profiles_screen.profile_name_input_field.clear
  @profiles_screen.profile_name_input_field.send_keys(@p_name)
  @profiles_screen.device_done_btn
end

And("I tap on save") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_button.displayed?).to be_truthy }
  @profiles_screen.save_button.click
  @profiles_screen.wait(5)
  size = @profiles_screen.save_text.size
  @profiles_screen.save_button.click if size.positive?
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profiles.displayed?).to be_truthy }
end

Then("I should see created profile in profiles") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  names_count = @profiles_screen.profile_names_list.size
  if names_count <= 3
    ######
    @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@p_name).displayed?).to be_truthy }
  end

  if names_count > 3 && names_count <= 5
    step "Scroll to left"
    @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@p_name).displayed?).to be_truthy }
  end
end

When("I tap on the Profile I would like to use") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  list = @profiles_screen.profile_names_list_overlay
  if list.size == 1
    step "I tap on Add Profile button"
    step "I tap on profile name input text field and enter profile name"
    step "I tap on save"
    step "I tap on Navigate up button"
    list = @profiles_screen.profile_names_list_overlay
  end
  @highlighted_profile = @profiles_screen.instance_variable_get(:@overlay_profile_name)
  puts list
  overlay_item_index = list.index(@highlighted_profile)
  puts @highlighted_profile
  puts overlay_item_index
  @random_number_var = @profiles_screen.random_num(0, list.size - 1)
  @random_number_var = @profiles_screen.random_num(0, list.size - 1) while @random_number_var == overlay_item_index
  @profiles_screen.wait(5)
  @active_profile = list[@random_number_var]
  puts @active_profile
  if @random_number_var <= 2
    @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@active_profile).displayed?).to be_truthy }
    @profiles_screen.profile_name(@active_profile).click
  elsif @random_number_var >= 2 && @random_number_var <= 4
    step "Scroll to left"
    @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@active_profile).displayed?).to be_truthy }
    @profiles_screen.profile_name(@active_profile).click
  end
end

Then("I should be taken to Home screen") do
  @home_screen = HomeScreen.new
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait(15)
  @home_screen.wait_until(30) { expect(@home_screen.dplus_logo.size.positive?).to be_truthy }
end

Then("I should see the Profile highlighted in frame on the Account Screen") do
  @profiles_screen = ProfilesScreen.new
  list = @profiles_screen.profile_names_list_overlay
  @highlighted_profile = @profiles_screen.instance_variable_get(:@overlay_profile_name)
  @highlighted_profile.should eq(@active_profile) if list.size >= 1
end

When("Scroll to left") do
  @profiles_screen = ProfilesScreen.new
  (1..2).each do |_i|
    @profiles_screen.scroll_to_left
  end
end

When("scroll to right") do
  @profiles_screen = ProfilesScreen.new
  (1..2).each do |_i|
    @profiles_screen.scroll_to_right
  end
end

And("I tap on Manage Profiles") do
  @profiles_screen = ProfilesScreen.new
  size = @profiles_screen.profile_names_list.size
  if size == 1
    step "I tap on Add Profile button"
    step "I tap on profile name input text field and enter profile name"
    step "I tap on save"
    step "I tap on Navigate up button"
  end
  @profiles_screen.profile_names_list_overlay
  @highlighted_profile = @profiles_screen.instance_variable_get(:@overlay_profile_name)
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  @profiles_screen.manage_profile_button.click
end

And("I tap on edit profile icon") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait(5)
  puts @highlighted_profile
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@highlighted_profile).displayed?).to be_truthy }
  @profiles_screen.profile_name(@highlighted_profile).click
  @profiles_screen.wait_until(30) { expect(@profiles_screen.edit_profile.displayed?).to be_truthy }
end

When("I tap on Delete Profile") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.delete_button.displayed?).to be_truthy }
  @profiles_screen.delete_button.click
end

Then("I Should see a pop up with Delete and Cancel options") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.popup_cancel_button.displayed?).to be_truthy }
  @profiles_screen.wait_until(30) { expect(@profiles_screen.popup_delete_button.displayed?).to be_truthy }
end

When("I tap on delete Profile option") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.popup_delete_button.displayed?).to be_truthy }
  @profiles_screen.popup_delete_button.click
end

When("I select a profile from who is watching screen") do
  @profiles_screen = ProfilesScreen.new
  list = @profiles_screen.profile_names_list
  puts list
  index = @profiles_screen.random_num(0, list.size - 1)
  @active_profile = list[index]
  puts @active_profile
  if list.size >= 1
    @profiles_screen.wait(5)
    @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@active_profile).displayed?).to be_truthy }
    @profiles_screen.profile_name(@active_profile).click
  end
end

When("I navigate to edit profile screen") do
  step "I go to account"
  step "I tap on Manage Profiles"
  step "I tap on edit profile icon"
end

When("I tap on delete profile and validate popup") do
  step "I tap on Delete Profile"
  step "I Should see a pop up with Delete and Cancel options"
end

When("I delete a profile and select a new profile") do
  step "I tap on delete profile and validate popup"
  step "I tap on delete Profile option"
  @profiles_screen = ProfilesScreen.new
  size = @profiles_screen.whos_watching.size
  if size.positive?
    step "I select a profile from who is watching screen"
    step "I should be taken to Home screen"
    step "I go to account"
  end
end

And("I navigate to edit profile page") do
  step "I go to account"
  step "I tap on Manage Profiles in account page"
  step "I tap on edit profile icon in manage profiles"
end

And("I tap on Manage Profiles in account page") do
  @profiles_screen = ProfilesScreen.new
  @profiles = @profiles_screen.profile_names_list
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  @profiles_screen.manage_profile_button.click
end

And("I tap on edit profile icon in manage profiles") do
  @profiles_screen = ProfilesScreen.new
  index = @profiles_screen.random_num(0, @profiles.size - 1)
  @edit_profile_name = @profiles[index]
  @profiles_screen.wait(5)
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@edit_profile_name).displayed?).to be_truthy }
  @profiles_screen.profile_name(@edit_profile_name).click
end

When("I clear text from input field and enter name") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.edit_profile.displayed?).to be_truthy }
  @profiles_screen.edit_profile.click
  @profiles_screen.wait_until(30) { expect(@profiles_screen.driver.is_keyboard_shown).to be_truthy }
  @profiles_screen.edit_profile.clear
  @profiles_screen.edit_profile.send_keys(@p_name)
  @profiles_screen.device_done_btn
  @profiles_screen.wait_until(30) { expect(@profiles_screen.driver.is_keyboard_shown).to be_falsy }
end

And("I tap on update profile name input text field and enter profile name") do
  @p_name = @profiles_screen.random_string
  step "I clear text from input field and enter name"
end

When("I select avatar and tap on save") do
  step "I Select avatar"
  step "I tap on save"
end

Then("I should be taken to manage profile screen") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profiles.displayed?).to be_truthy }
end

When("I update profile name and tap on save") do
  step "I tap on update profile name input text field and enter profile name"
  step "I tap on save"
end

And("I Select avatar") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.avatar_image.click
  @profiles_screen.wait_until(30) { expect(@profiles_screen.select_profile_image.displayed?).to be_truthy }
  @profiles_screen.wait_until(30) { expect(@profiles_screen.avatar_image_list.size.positive?).to be_truthy }
  size = @profiles_screen.avatar_image_list.size
  index = @profiles_screen.random_num(1, size)
  @profiles_screen.scroll_down if index > 8
  avatar_images = @profiles_screen.avatar_image_list
  count = 1
  avatar_images.each do |image|
    image.click if count == index
    count += 1
  end
end

And("The profile name should be updated") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@p_name).displayed?).to be_truthy }
end

And("I navigate to manage profiles screen") do
  step "I go to account"
  step "I tap on Manage Profiles in account page"
end

When("I tap on cancel") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_cancel.displayed?).to be_truthy }
  @profiles_screen.save_cancel.click
end

Then("The profile should not be created in profiles") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  names_count = @profiles_screen.profile_names_list.size
  if names_count <= 3
    ######
    @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name_list(@p_name).size.negative?).to be_falsey }
  end

  if names_count > 3 && names_count <= 5
    step "Scroll to left"
    @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name_list(@p_name).size.negative?).to be_falsey }
  end
end

And("I navigate to add profile screen") do
  step "I go to account"
  step "I tap on Add Profile button"
end

And("I tap on Add Profile button in manage profiles") do
  @profiles_screen = ProfilesScreen.new
  name_count = @profiles.size
  if name_count < 5
    @profiles_screen.wait(5)
    @profiles_screen.wait_until(30) { expect(@profiles_screen.add_profile_button.displayed?).to be_truthy }
    @profiles_screen.add_profile_button.click
  end
end

And("I navigate to add profile screen from manage profiles") do
  step "I go to account"
  step "I tap on Manage Profiles in account page"
  step "I tap on Add Profile button in manage profiles"
end

When("I save empty profile") do
  @empty_profile_name = " "
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name_input_field.displayed?).to be_truthy }
  @profiles_screen.profile_name_input_field.click
  @profiles_screen.profile_name_input_field.send_keys(@empty_profile_name)
  @profiles_screen.driver.hide_keyboard
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_button.displayed?).to be_truthy }
  @profiles_screen.save_button.click
end

Then("I should see Required field error message") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.error_message.displayed?).to be_truthy }
end

When("I enter profile name more than 30 chars") do
  @profiles_screen = ProfilesScreen.new
  @lengthy_profile_name = "qetuwi34682AJgcbkK@eyts.,_v-sga"
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name_input_field.displayed?).to be_truthy }
  @profiles_screen.profile_name_input_field.click
  @profiles_screen.profile_name_input_field.send_keys(@lengthy_profile_name)
  @profiles_screen.driver.hide_keyboard
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_button.displayed?).to be_truthy }
  @profiles_screen.save_button.click
end

Then("I should see valid error message") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.invalid_profile_name.displayed?).to be_truthy }
end

And("The save button should be disabled") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_button.enabled?).to be_falsey }
end

Then("I should be taken to profiles screen") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
end

When("I enter the profile name that meets requirements") do
  @valid_profile_name = "Android_Test_Automation@1.2.3$"
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name_input_field.displayed?).to be_truthy }
  @profiles_screen.profile_name_input_field.click
  @profiles_screen.profile_name_input_field.send_keys(@valid_profile_name)
  @profiles_screen.driver.hide_keyboard
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_button.displayed?).to be_truthy }
  @profiles_screen.save_button.click
  @profiles_screen.wait(5)
  size = @profiles_screen.save_text.size
  @profiles_screen.save_button.click if size.positive?
end

When("I enter the profile name that does not meet the requirements") do
  @invalid_profile_name = "sjhdyej,aorfja.i@Uhfikzbvwlefnlzvnl"
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.edit_profile.displayed?).to be_truthy }
  @profiles_screen.edit_profile.click
  @profiles_screen.edit_profile.clear
  @profiles_screen.edit_profile.send_keys(@invalid_profile_name)
  @profiles_screen.driver.hide_keyboard
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_button.displayed?).to be_truthy }
  @profiles_screen.save_button.click
end

When("I am a customer with one profile in account") do
  step "I navigate to edit profile page"
  while @profiles.size > 1
    step "I delete a profile and select a new profile"
    step "I navigate to edit profile page"
  end
end

Then("I should not see delete profile option in edit profile page") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_cancel.displayed?).to be_truthy }
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_button.displayed?).to be_truthy }
  @profiles_screen.wait_until(30) { expect(@profiles_screen.edit_profile.displayed?).to be_truthy }
  @profiles_screen.wait_until(30) { expect(@profiles_screen.delete_profile.size.positive?).to be_falsey }
end

When("I tap on CANCEL from delete popup") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.popup_cancel_button.displayed?).to be_truthy }
  @profiles_screen.popup_cancel_button.click
end

Then("I should be taken back to edit profile screen") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.edit_profile_text.displayed?).to be_truthy }
end

And("The Profile should not be deleted") do
  step "I tap on cancel"
  step "I should be taken to manage profile screen"
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@edit_profile_name).displayed?).to be_truthy }
end

And("I tap on Edit") do
  @profiles_screen = ProfilesScreen.new
  step "I should see Add Profile, Edit, Profiles list and who is watching UI components"
  @profiles_screen.wait_until(30) { expect(@profiles_screen.edit_button.displayed?).to be_truthy }
  @profiles_screen.edit_button.click
end

Then("I should not see who is watching screen") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.whos_watching.size.negative?).to be_falsey }
end

When("I delete the first profile") do
  step "I go to account"
  step "I tap on manage profile"
  step "I tap on first profile edit button"
  step "I delete a profile and select a new profile"
end

When("I tap on manage profile") do
  @profiles_screen = ProfilesScreen.new
  size = @profiles_screen.profile_names_list.size
  if size == 1
    step "I tap on Add Profile button"
    step "I tap on profile name input text field and enter profile name"
    step "I tap on save"
  end
  step "I tap on Manage Profiles in account page"
end

When("I tap on first profile edit button") do
  @profiles_screen = ProfilesScreen.new
  @edit_first_profile = @profiles[0]
  @profiles_screen.wait(5)
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@edit_first_profile).displayed?).to be_truthy }
  @profiles_screen.profile_name(@edit_first_profile).click
end

Then("I should not see the deleted profile in profiles") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name_list(@edit_first_profile).size.negative?).to be_falsey }
end

Given("I tap on sign in") do
  step "I am on welcome screen"
  step "I tap on 'Sign In'"
end

When("I sign in as user with one profile") do
  step "I enter the adlite email and password associated with my Discovery+ account"
end

When("I sign in as a user with more than one profile") do
  step "I enter the adlite email and password associated with my Discovery+ account"
end

Then("I should see who is watching screen") do
  @profiles_screen = ProfilesScreen.new
  if @profiles_screen.whos_watching.size.positive?
    @profiles_screen.wait_until(30) { expect(@profiles_screen.whos_watching.size.positive?).to be_truthy }
  end
end

When("I tap on add profile from who is watching screen") do
  @profiles_screen = ProfilesScreen.new
  @multiple_profiles = @profiles_screen.whos_watching.size
  if @multiple_profiles.positive?
    @profiles_screen.wait_until(30) { expect(@profiles_screen.whos_watching.size.positive?).to be_truthy }
    if @profiles_screen.profiles_list.size == 5
      @profiles_screen.wait_until(30) { expect(@profiles_screen.add_profile_option.size.positive?).to be_falsey }
    else
      @profiles_screen.wait_until(30) { expect(@profiles_screen.add_profile_option.size.positive?).to be_truthy }
      @profiles_screen.add_profile_button.click
    end
  end
end

Then("I should be taken to add profile screen") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.create_profile.displayed?).to be_truthy } if @multiple_profiles.positive?
end

When("I tap on Edit from who is watching screen") do
  @profiles_screen = ProfilesScreen.new
  @who_is_watching = @profiles_screen.whos_watching.size
  step "I tap on Edit" if @who_is_watching.positive?
end

Then("I should be taken to Manage Profiles from Who is watching") do
  step "I should be taken to manage profile screen" if @who_is_watching.positive?
end

Then("I should select a profile from who is watching screen") do
  @profiles_screen = ProfilesScreen.new
  if @profiles_screen.whos_watching.size.positive?
    @profiles_screen.wait_until(30) { expect(@profiles_screen.whos_watching.size.positive?).to be_truthy }
    list = @profiles_screen.profiles_list
    list[0].click
  end
end

And("I create a profile") do
  step "I navigate to add profile screen"
  step "I tap on profile name input text field and enter profile name"
  step "I select avatar and tap on save"
end

When("I delete a profile") do
  step "I tap on Manage Profiles in account page"
  step "I select a profile to delete"
  step "I delete the created profile"
end

Then("I should not see the deleted profile in account") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name_list(@p_name).size.zero?).to be_truthy }
end

And("I select a profile to delete") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait(5)
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@p_name).displayed?).to be_truthy }
  @profiles_screen.profile_name(@p_name).click
end

When("I delete the created profile") do
  step "I delete a profile and select a new profile"
end

And("I tap on manage profiles and delete profile") do
  step "I tap on Manage Profiles in account page"
  step "I select a profile to delete"
  step "I delete a profile and select a new profile"
end

And("I add profile and navigate to manage profile") do
  @profiles_screen = ProfilesScreen.new
  @list_profiles = @profiles_screen.profile_names_list
  count = @list_profiles.size
  if count == 1
    step "I tap on Add Profile button"
    step "I tap on profile name input text field and enter profile name"
    step "I tap on save"
  end
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  @profiles_screen.manage_profile_button.click
end

And("I tap on the profile I would like to edit") do
  @profiles_screen = ProfilesScreen.new
  index = @profiles_screen.random_num(0, @list_profiles.size - 1)
  @edit_profile = @list_profiles[index]
  @profiles_screen.wait(5)
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@edit_profile).displayed?).to be_truthy }
  @profiles_screen.profile_name(@edit_profile).click
end

And("I navigate to edit profile") do
  step "I go to account"
  step "I add profile and navigate to manage profile"
  step "I tap on the profile I would like to edit"
end

Then("I should see created profile in account") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
  names_count = @profiles_screen.profile_names_list.size
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@valid_profile_name).displayed?).to be_truthy } if names_count <= 3

  if names_count > 3 && names_count <= 5
    step "Scroll to left"
    @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@valid_profile_name).displayed?).to be_truthy }
  end
end

And("I tap on manage profiles and delete the created profile") do
  step "I tap on Manage Profiles in account page"
  step "I delete created profile"
  step "I delete a profile and select a new profile"
end

And("I delete created profile") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait(5)
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@valid_profile_name).displayed?).to be_truthy }
  @profiles_screen.profile_name(@valid_profile_name).click
end

And("I should see the profile in manage profiles") do
  step "I tap on cancel"
  step "I should be taken to manage profile screen"
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name(@edit_profile).displayed?).to be_truthy }
end

When("I enter the profile name that already exists") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profile_name_input_field.displayed?).to be_truthy }
  @profiles_screen.profile_name_input_field.click
  (1..2).each do |_i|
    @profiles_screen.profile_name_input_field.clear
    @profiles_screen.profile_name_input_field.send_keys("Android_Test_Automation@1.2.3$")
  end
  @profiles_screen.driver.hide_keyboard
  @profiles_screen.wait_until(30) { expect(@profiles_screen.save_button.displayed?).to be_truthy }
end

When("I should see inline error message") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait(5)
  @profiles_screen.wait_until(30) { expect(@profiles_screen.create_profile_error.displayed?).to be_truthy }
  step "The save button should be disabled"
  step "I tap on cancel"
  @profiles_screen.wait_until(30) { expect(@profiles_screen.manage_profile_button.displayed?).to be_truthy }
end

Then("I should see Add Profile, Edit, Profiles list and who is watching UI components") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.wait_until(30) { expect(@profiles_screen.edit_button.displayed?).to be_truthy }
  @profiles_screen.wait_until(30) { expect(@profiles_screen.whos_watching.size.positive?).to be_truthy }
  @profiles_screen.wait_until(30) { expect(@profiles_screen.profiles_list.size.positive?).to be_truthy }
  list = @profiles_screen.profiles_list
  if list.size == 5
    @profiles_screen.wait_until(30) { expect(@profiles_screen.add_profile_option.size.positive?).to be_falsey }
  else
    @profiles_screen.wait_until(30) { expect(@profiles_screen.add_profile_option.size.positive?).to be_truthy }
  end
end

And("I create a profile from account screen") do
  step "I navigate to add profile screen"
  step "I enter the profile name that meets requirements"
  step "I should see created profile in account"
end

When("I again try to create a profile that is already in use") do
  step "I tap on Add Profile button"
  step "I enter the profile name that already exists"
end

When("I navigate to Account screen and select a profile") do
  step "I go to account"
  step "I tap on the Profile I would like to use"
  step "I should be taken to Home screen"
end

And("I close and relaunch the app") do
  @profiles_screen = ProfilesScreen.new
  @profiles_screen.driver.background_app(10)
end

Then("The profile selected should be same I was using in my last session") do
  step "I go to account"
  step "I should see the Profile highlighted in frame on the Account Screen"
end

Given("I login with account which has 5 profiles") do
  step "I login using adlite2 account"
end

When("I am on who is watching screen with 5 profiles") do
  @profiles_screen = ProfilesScreen.new
  if @profiles_screen.whos_watching.size.positive?
    profiles_list_size = @profiles_screen.profiles_list.size
    profiles_list_size.eql?(5)
    while profiles_list_size <= 5
      i = 1
      @profiles_screen.profiles_list[i].attribute(:selected).to be_falsey
      i = +1
    end
  end
end

Then("The Add Profile button should be hidden on who is watching screen") do
  @profiles_screen = ProfilesScreen.new
  list_size = @profiles_screen.whos_watching.size
  expect(@profiles_screen.add_profile_whos_wataching.size.positive?).to be_falsey if list_size.positive?
end

And("I tap on Navigate up button") do
  @profiles_screen = ProfilesScreen.new
  expect(@profiles_screen.navigate_up.displayed?).to be_truthy
  @profiles_screen.navigate_up.click
end
