require "appium_lib"
require "dotenv"
require "byebug"
require "net/http"
require "cucumber"
require "require_all"
require "retriable"
require_relative "../../../../support/paths"
require_relative "../../../../support/provider_affiliates"
require_rel "../../../../support/browsermob"
require_rel "../../../../support/chromecast"

require "active_support/core_ext/hash/deep_merge"
require "active_support/core_ext/hash/keys"
require "json"

Dotenv.load(File.join(Support::Paths.dtc_android_root, ".env"))

BMP = BrowserMobProxy.new if ENV["PROXY"]
ChromeCast = ChromeCastSetup.new if ENV["ADB_DEVICE"]

# require_relative "../paths"
require_rel "../../../../support/profiles"
require_rel "../../../../support/test_platform/remote_helpers"
require_rel "../../../../support/"

class AppiumWorld
end

ENV["platformName"] = "Android"
ENV["platformType"] = "dtc"
ENV["test_rail_config_path"] = File.join(File.dirname(__FILE__), "test_rail_config.json")

PROFILE = Support::Profiles::Cucumber.new(ENV["CUCUMBER_PROFILE"])
TEST_PLATFORM = Support::TestPlatform.new(PROFILE.test_platform)
Appium.promote_appium_methods AppiumWorld

World do
  AppiumWorld.new
end

#  Need to require base screen first since other screens rely on it.
# require File.join(File.dirname(__FILE__), "../../screens/base_screen_android")
require_relative "../../screens/base_screen"
require_all File.join(File.dirname(__FILE__), "../../../../screens/screen_helpers/")
require_all File.join(File.dirname(__FILE__), "../../screens/")
require_relative "../../../../support/hooks"

#  This loads data for each of our network based off the ENV["APP_PACKAGE"] value.
#  This lets tests use NETWORK_DATA.show or NETWORK_DATA.network_code etc.
NETWORK_DATA = ScreenHelpers::NetworkDataHelper.new
