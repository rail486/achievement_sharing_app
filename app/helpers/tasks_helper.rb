module TasksHelper
    def achievement_average(date)
      current_user.tasks.where(date: date).average(:achievement)
    end
  end
  