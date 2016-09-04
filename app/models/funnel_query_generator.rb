class FunnelQueryGenerator
  def self.query(start_date, end_date)
    sql = self.sql_statement(start_date, end_date)
    results = ActiveRecord::Base.connection.execute sql
    funnel = reformat_funnel results
  end


  def self.sql_statement(start_date, end_date)
    "SELECT date(updated_at, 'weekday 0', '-6 days') || '-' || date(updated_at, 'weekday 0') as week_start, "\
    "count(CASE WHEN workflow_state='applied' THEN 1 END) as applied, "\
    "count(CASE WHEN workflow_state='quiz_started' THEN 1 END) as quiz_started, "\
    "count(CASE WHEN workflow_state='quize_completed' THEN 1 END) as quize_completed, "\
    "count(CASE WHEN workflow_state='onboarding_requested' THEN 1 END) as onboarding_requested, "\
    "count(CASE WHEN workflow_state='onboarding_completed' THEN 1 END) as onboarding_completed, "\
    "count(CASE WHEN workflow_state='hired' THEN 1 END) as hired, "\
    "count(CASE WHEN workflow_state='rejected' THEN 1 END) as rejected "\
    "FROM applicants "\
    "WHERE updated_at between date('#{start_date}') and date('#{end_date}') "\
    "GROUP by strftime('%W', updated_at) "\
    "ORDER by updated_at ASC"
  end

  def self.reformat_funnel(results)
    funnel = {}
    results.each do |week|
      funnel[week["week_start"]] = {"applied"=> week["applied"],
                      "quiz_started" => week["quiz_started"],
                      "quiz_completed" => week["quiz_completed"],
                      "onboarding_started" => week["onboarding_started"],
                      "onboarding_completed" => week["onboarding_complet,ed"],
                      "hired" => week["hired"],
                      "rejected" => week["rejected"]
                    }
    end

    funnel
  end
end
