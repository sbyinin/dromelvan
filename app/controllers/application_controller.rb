class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :sanitize_devise_parameters, if: :devise_controller?
  
  helper_method :administrator_signed_in?
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render '/public/404', status: :not_found
  end
  
  def index
    respond_to do |format|
      format.html do
        resources = controller_name.classify.constantize.all
        self.instance_variable_set "@#{controller_name.classify.pluralize.downcase}", resources
      end
      format.json do
        datatable_class_name = controller_name.classify.pluralize + "Datatable"
        render json:  datatable_class_name.constantize.new(view_context, ajax_params)
      end
    end    
  end

  def show
    #@season = Season.current
    @season = Season.find(params[:season_id])
    resource = controller_name.classify.constantize.find(params[:id])
    self.instance_variable_set "@#{controller_name.classify.downcase}", resource
  end
  
  def select_season
    redirect_to show_season_player_path(id: params[:id], season_id: params[:season][:id])  
  end
  
  def select
    resource = controller_name.classify.constantize.find(select_params[:id])
    redirect_to resource
  end

  def administrator_signed_in?
    current_user.try(:administrator?)
  end
  
  def ajax_params
    {}
  end
  
  protected
    def sanitize_devise_parameters
       devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
       devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
    end       
  
  private
    def select_params
      params.require(controller_name.singularize.downcase.to_sym).permit(:id)
    end
  
end
