# Module that deals with incoming AJAX requests from JQuery Datatables and formats
# a JSON response to the request.
module Datatable
  delegate :params, :render, :link_to, :image_tag, to: :@view
  delegate :h, to: 'ERB::Util'
  delegate :url_helpers, to: 'Rails.application.routes'

  def initialize(view, scope_params)
    @view = view
    @scope_params = filter_scope_params(scope_params)
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: table_scope.count,
      iTotalDisplayRecords: objects.total_entries,
      aaData: data
    }
  end

private

  def objects
    @objects ||= fetch_objects
  end

  def fetch_objects    
    objects = params[:order].present? ? table_scope.reorder("#{sort_params(sort_column.to_s)}") : table_scope
    objects = objects.page(page).per_page(per_page)
    if params[:search].present?
      puts(params[:search])
      search_params = params[:search]["value"].split

      # This bit turns search_params 'Foo', 'Bar' and filter_columns 'A','B','C' into
      # ['(A like ? or B like ? or C like ?) AND (A like ? or B like ? or C like ?)', 'Foo', 'Foo', 'Foo', 'Bar', 'Bar', 'Bar']
      # for the query in the where method.
      fetch_params = []
      fetch_query = ""
      filter_columns.each do | search_column|
        fetch_query << "lower (" + search_column + ") like lower(?)"
        if search_column != filter_columns[-1]
          fetch_query << " or "
        end
        fetch_params = (fetch_params + search_params).sort
      end

      objects = objects.where([(['(' + fetch_query + ')'] * search_params.length).join(' AND ')] + fetch_params.map { |search_param| "%#{search_param}%" })
    end
    objects
  end

  def object_link(text, object)
    link_to(text, object, class: "model-link")
  end

  def object_name_link(object)
    object_link(object.name, object)
  end
  
  def render_partial(partial, locals)
    render(partial: partial, formats: [:html], locals: locals)
  end
  
  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = sort_columns    
    columns[params[:order]["0"]["column"].to_i]
  end

  def sort_direction
    params[:order]["0"]["dir"] == "desc" ? "desc" : "asc"
  end

  def sort_params(sort_column)
    # Turn 'first_name,last_name' into 'first_name desc,last_name desc"
    sort_params = ""
    split = sort_column.split(",")
    split.each do |param|
      sort_params += param + " " + sort_direction
      if param != split.last then
        sort_params += ","
      end
    end    
    sort_params
  end
  
  def filter_scope_params(scope_params)
    scope_params
  end
  
  def table_scope
    where_clause = []
    @scope_params.keys.each do |key|
      where_clause += [ "#{key} = #{@scope_params[key]}" ]
    end
    where_clause = where_clause.join(" AND ")
    model_scope.where(where_clause)
  end
end
