# This is needed for rails_admin since rails_admin uses Kaminari and Kaminari
# doesn't play nice with will_paginate without this.
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end
