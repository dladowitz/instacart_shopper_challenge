class FunnelsController < ApplicationController
  def index
    @database_type = ActiveRecord::Base.connection.instance_values["config"][:adapter]
    puts "Database Type: #{@database_type}"

    unless @database_type == "sqlite3"
      puts "Trying to render 'sorry'"
      render :sorry
    end

    puts "trying to run FunnelQueryGenerator"

    @funnel = FunnelQueryGenerator.query(params[:start_date], params[:end_date])

    respond_to do |format|
      format.html { @chart_funnel = formatted_funnel }
      format.json { render json: @funnel }
    end
  end

  private

  def set_dates
    if params[:start_date] && params[:end_date]
      @start_date = DateTime.parse(params[:start_date])
      @end_date = DateTime.parse(params[:end_date])
    else
      @start_date = DateTime.parse("2014-12-01")
      @end_date = DateTime.parse("2014-12-21")
    end
  end

  # generates a formatted version of the funnel for display in d3
  def formatted_funnel
    formatted = Hash.new { |h, k| h[k] = [] }

    @funnel.each do |date, state_counts|
      state_counts.each do |state, count|
        formatted[state] << {label: date, value: count}
      end
    end

    formatted.map do |k, v|
      {
        key: k.humanize,
        values: v
      }
    end
  end
end
