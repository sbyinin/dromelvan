# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Time::DATE_FORMATS[:post_time] = "%B %d %Y at %H:%M"
# Tested in Match specs.
Time::DATE_FORMATS[:kickoff_time] = "%H:%M"
Date::DATE_FORMATS[:match_date] = "%A, %B %d %Y"
Date::DATE_FORMATS[:match_date_short] = "%A, %-e.%-m %Y"
