RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_admin)

  config.authorize_with do
    not_found unless administrator_signed_in?
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    # export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
  config.model Team do
    exclude_fields :home_matches, :away_matches, :player_match_stats, :goals, :cards, :substitutions, :player_season_infos, :transfer_listings, :team_table_stats, :team_registrations, :team_match_squad_stats, :team_season_squad_stats
  end

  config.model D11Team do
    exclude_fields :home_d11_matches, :away_d11_matches, :player_match_stats, :player_season_infos, :transfer_listings, :d11_team_table_stats, :d11_team_registrations, :d11_team_match_squad_stats, :d11_team_season_squad_stats
  end

  config.model Player do
    exclude_fields :player_match_stats, :goals, :cards, :substitutions, :in_substitutions, :player_season_infos, :player_season_stats, :transfer_listings
  end

end
