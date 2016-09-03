class FunnelsController < ApplicationController
  def index
    set_dates
    @funnel = Funnel.new(@start_date, @end_date).create_funnel

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
