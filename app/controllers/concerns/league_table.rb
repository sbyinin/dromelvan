module LeagueTable
  extend ActiveSupport::Concern

  included do
    def show_table
      resource = controller_name.classify.constantize.find(params[:id])
      self.instance_variable_set "@#{controller_name.tableize.singularize}", resource
    end
    
    def select_table
      resource = controller_name.classify.constantize.find(select_table_params[:id])
      redirect_to public_send("show_table_#{controller_name.tableize.singularize}_path",resource)
    end    
  end

  private
    def select_table_params
      params.require(controller_name.tableize.singularize.to_sym).permit(:id)
    end
    
end