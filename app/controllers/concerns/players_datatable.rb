class PlayersDatatable
  include Datatable  

private

  def model_scope
    Player.joins(:country)
  end
  
  def filter_columns 
    %w[first_name last_name full_name countries.name whoscored_id]
  end

  def sort_columns
    %w[last_name countries.name whoscored_id date_of_birth height weight ]
  end
  
  def data
    objects.map do |player|
      [
        object_name_link(player),        
        render_partial('countries/flag_image_tag', { country: player.country }),
        if !player.whoscored_id.nil?
          link_to(player.whoscored_id, "http://www.whoscored.com/Players/#{player.whoscored_id}", target: "blank", class: "model-link")
        else
          ""
        end,
        if !player.date_of_birth.nil?
          player.date_of_birth
        else
          "Unknown"          
        end,
        if player.height > 0
          player.height
        else
          "Unknown"
        end,
        if player.weight > 0
          player.weight
        else
          "Unknown"
        end      
      ] 
    end
  end

end