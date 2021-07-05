class CalendarsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_date

  def index
  end

  private

    def correct_date
      if params[:start_date].present?
        redirect_to "/calendar" unless date_valid?(params[:start_date])
      end
    end

    def date_valid?(str)
      !! Date.parse(str) rescue false
    end
end
