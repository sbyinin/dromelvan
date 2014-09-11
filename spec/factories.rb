include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com"}
    sequence(:name) { |n| "user#{n}"}
    password "password"
    
    factory :admin do
      administrator true
    end    
  end

  factory :country do
    sequence(:name) { |n| "Country #{n}" }
    sequence(:iso) { |n| "#{('AAA'..'ZZZ').to_a[n]}" }    
  end

  factory :stadium do
    sequence(:name) { |n| "Test Stadium #{n}" }
    city "Test City"
    capacity 12345
    opened 1901
  end

  factory :player do
    sequence(:first_name)  { |n| "First #{n}" }
    sequence(:last_name)  { |n| "Last #{n}" }
    date_of_birth Date.today - 20.year
    country
    whoscored_id 1
  end

  factory :team do    
    sequence(:name) { |n| "Test Team #{n}" }
    sequence(:code) { |n| "#{('AAA'..'ZZZ').to_a[n]}" }
    sequence(:nickname) { |n| "Nickname #{n}" }
    established 1900  
    motto "Motto"
    stadium
    whoscored_id 1
  end

  factory :season do
    sequence(:name) do |n|
      start = "#{n}"
      start = "0" * (4 - start.length) + start
      stop = "#{n + 1}"
      stop = "0" * (4 - stop.length) + stop
      "#{start}-#{stop}"
    end
    
    date Date.today
  end

  factory :position do
    sequence(:name) { |n| "Position#{n}" }
    defender false
    sequence(:code) do |n|
      "C#{n}"
    end    
    sequence(:sort_order) do |n|
      n
    end    
  end
  
end