class Match::ScheduleResultsController < ApplicationController
  def index
    @schedule_results = ScheduleResult.all.order(section: "ASC")
  end

  def new
    @schedule_results = ScheduleResult.new
  end

  def create
    @schedule_result = ScheduleResult.create(schedule_result_params)
    if @schedule_result.save
      flash[:success] = '投稿が完了しました'
      redirect_to match_schedule_results_path
    else
      flash[:danger] = '投稿が失敗しました'
      render new
    end
  end

  private

  def schedule_result_params
    params.require(:schedule_result).permit(:match_date_time, :section, :opponent, :match_result, :stadium, :home_and_away)
  end
end
