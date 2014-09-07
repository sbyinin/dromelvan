class CountriesDatatable
  include Datatable  

private

  def model_scope
    Country.all
  end
  
  def filter_columns 
    %w[name iso]
  end

  def sort_columns
    %w[name iso]
  end
  
  def data
    objects.map do |country|
      [
        object_name_link(country),
        render_partial('flag_image_tag', { country: country }),        
        country.iso,
      ] 
    end
  end

end