class MatchDaysController < ApplicationController
  include Select, StatusEnum
  
  # TODO: Figure out why specs fail if this is put in StatusEnum 
  before_action :authorize_administrator,  only: [:pend, :activate, :finish, :update]

  def update
    @match_day = MatchDay.find(params[:id])
    date_str = update_params[:date]

    begin    
      if !date_str.empty?
        @match_day.date = Date.parse(date_str)
      else 
        @match_day.date = @match_day.date.postpone
      end
      
      if @match_day.save
        flash[:success] = "Match day date updated."
      else
        flash[:danger] = "The match day date could not be updated."
      end      
    rescue ArgumentError
      flash[:danger] = "The date '#{date_str}' is invalid."
    end
    
    redirect_to @match_day
  end

  private
    def update_params
      params.require(:match_day).permit(:date)
    end
    
end
