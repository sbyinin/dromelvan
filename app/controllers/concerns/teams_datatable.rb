class TeamsDatatable
  include Datatable  

private

  def model_scope
    Team.all
  end
  
  def filter_columns 
    %w[name code nickname]
  end

  def sort_columns
    %w[name club_crest code nickname established motto whoscored_id ]
  end
  
  def data
    objects.map do |team|
      [
        object_name_link(team),
        image_tag(team.club_crest.url(:icon), alt: team.name),
        team.code,
        if !team.nickname.nil?
          team.nickname
        else
          ""          
        end,
        team.established,
        if !team.motto.nil?
          team.motto
        else
          ""          
        end,
        if !team.whoscored_id.nil?
          link_to(team.whoscored_id, "http://www.whoscored.com/Teams/#{team.whoscored_id}", target: "blank", class: "model-link")
        else
          ""
        end      
      ] 
    end
  end

end