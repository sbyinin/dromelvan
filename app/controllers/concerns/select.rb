module Select
  extend ActiveSupport::Concern

  included do
    def select
      resource = controller_name.classify.constantize.find(select_params[:id])
      redirect_to resource
    end    
  end
end