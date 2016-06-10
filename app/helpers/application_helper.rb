module ApplicationHelper
  
  def breadcrumbs(breadcrumbs, options = {}, select_where = {})
    render 'layouts/breadcrumbs', breadcrumbs: breadcrumbs, options: options, select_where: select_where
  end

  def route_exists?(options)
    Rails.application.routes.routes.map{|route| route.defaults}.include?(options)
  end
  
end
