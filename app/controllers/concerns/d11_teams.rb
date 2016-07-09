module D11Teams
  extend ActiveSupport::Concern

  included do
    def show_d11_teams
      resource = controller_name.classify.constantize.find(params[:id])
      self.instance_variable_set "@#{controller_name.tableize.singularize}", resource
    end
    
    def select_d11_teams
      resource = controller_name.classify.constantize.find(select_d11_teams_params[:id])
      redirect_to public_send("show_d11_teams_#{controller_name.tableize.singularize}_path",resource)
    end    
  end

  private
    def select_d11_teams_params
      params.require(controller_name.tableize.singularize.to_sym).permit(:id)
    end
    
end