# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Time::DATE_FORMATS[:post_time] = "%B %d %Y at %H:%M"
Date::DATE_FORMATS[:default_date] = "%-e.%-m %Y"
Date::DATE_FORMATS[:shortest_date] = "%e.%m %y"
# Tested in Match specs.
Time::DATE_FORMATS[:kickoff_time] = "%H:%M"
Date::DATE_FORMATS[:match_date] = "%A, %B %d %Y"
Date::DATE_FORMATS[:match_date_short] = "%A, %-e.%-m %Y"
Date::DATE_FORMATS[:match_date_short_no_weekday] = "%-e.%-m %Y"
Date::DATE_FORMATS[:match_date_shortest] = "%-e.%-m"
