class D11TeamsDatatable
  include Datatable  

private

  def model_scope
    D11Team.joins(:owner)
  end
  
  def filter_columns 
    %w[d11_teams.name code users.name]
  end

  def sort_columns
    %w[name club_crest code users.name users.name ]
  end
  
  def data
    objects.map do |d11_team|
      [
        object_name_link(d11_team),
        image_tag(d11_team.club_crest.url(:icon), alt: d11_team.name),
        d11_team.code,
        d11_team.owner.name,
        if !d11_team.co_owner.nil?
          d11_team.co_owner.name
        else
          ""          
        end      
      ] 
    end
  end

end