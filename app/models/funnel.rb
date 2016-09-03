class Funnel
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def create_funnel
    funnel = {}
    week_start = @start_date

    while week_start < @end_date
      week_end = week_start.end_of_week
      week_end = @end_date if week_end > @end_date

      stats = Applicant.where(:updated_at => week_start..week_end).group(:workflow_state).count
      if stats.any?
        funnel["#{week_start.strftime "%Y-%m-%d"}-#{week_end.strftime "%Y-%m-%d"}"] = stats
      end

      week_start = week_end.next_week
    end

    return funnel
  end
end
