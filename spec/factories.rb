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

  factory :d11_team do    
    sequence(:name) { |n| "Test D11 Team #{n}" }
    sequence(:code) { |n| "#{('AAA'..'ZZZ').to_a[n]}" }    
    association :owner, factory: :user
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

  factory :player_season_info do
    player
    season
    team
    d11_team
    position
    value 0
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

  factory :premier_league do
    name "Barclays Premier League"
    season
  end

  factory :match_day do
    premier_league        
    date Date.today
    match_day_number 1
  end

  factory :match do
    match_day
    association :home_team, factory: :team
    association :away_team, factory: :team
    home_team_goals 0
    away_team_goals 0
    status 0
    datetime Time.now
    elapsed "N/A"
    stadium { home_team.stadium }
    whoscored_id 1
  end

  factory :d11_league do
    name "Drömelvan"
    season
  end

  factory :d11_match_day do
    d11_league
    date Date.today
    match_day_number 1
  end

  factory :d11_match do
    d11_match_day
    association :home_d11_team, factory: :d11_team
    association :away_d11_team, factory: :d11_team    
    home_team_goals 0
    away_team_goals 0
    home_team_points 0
    away_team_points 0    
    status 0    
  end
  
end