module TasksHelper
    def achievement_average(date)
      @average = current_user.tasks.where(date: date).average(:achievement)
      if @average.present?
        @average.to_f.round
      end
    end
  end
  