module StatusEnum
  extend ActiveSupport::Concern

  included do
    
    def pend      
      resource = controller_name.classify.constantize.find(status_enum_params[:id])
      update_status(resource, :pending)
    end
    
    def activate
      resource = controller_name.classify.constantize.find(status_enum_params[:id])
      update_status(resource, :active)
    end
    
    def finish
      resource = controller_name.classify.constantize.find(status_enum_params[:id])
      update_status(resource, :finished) 
    end
  end

  private
    def update_status(resource, status)
      resource.status = resource.class.statuses[status]
      if resource.save
        flash[:success] = "Status successfully changed to #{status}."
      else
        flash[:danger] = "Status could not be changed to #{status}."
      end
      redirect_to resource
    end
    
    def status_enum_params
      params.permit(:id)
    end
  
end