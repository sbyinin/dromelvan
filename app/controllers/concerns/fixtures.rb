module Fixtures
  extend ActiveSupport::Concern

  included do
    def show_fixtures
      find_season
      resource = controller_name.classify.constantize.find(params[:id])
      self.instance_variable_set "@#{controller_name.tableize.singularize}", resource
    end
    
    def select_fixtures
      find_season
      resource = controller_name.classify.constantize.find(select_fixtures_params[:id])
      redirect_to public_send("show_fixtures_#{controller_name.tableize.singularize}_path",resource, @season)
    end    
  end

  private
    def select_fixtures_params
      params.require(controller_name.tableize.singularize.to_sym).permit(:id)
    end    
        
end