module ApplicationHelper
  
  def breadcrumbs(breadcrumbs, select_where = {})
    render 'layouts/breadcrumbs', breadcrumbs: breadcrumbs, select_where: select_where
  end
  
end
