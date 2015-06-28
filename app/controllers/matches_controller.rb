class MatchesController < ApplicationController
  include Select, StatusEnum

  before_action :authorize_administrator,  only: [:pend, :activate, :finish, :update]

  def update
    @match = Match.find(params[:id])
    datetime_str = update_params[:datetime]

    begin    
      if !datetime_str.empty?
        @match.datetime = DateTime.parse(datetime_str)
      else 
        @match.datetime = @match.postpone
      end
      
      if @match.save
        flash[:success] = "Match datetime updated."
      else
        flash[:danger] = "The match datetime could not be updated."
      end      
    rescue ArgumentError
      flash[:danger] = "The datetime '#{datetime_str}' is invalid."
    end
    
    redirect_to @match.match_day
  end

  private
    def update_params
      params.require(:match).permit(:datetime)
    end

end
