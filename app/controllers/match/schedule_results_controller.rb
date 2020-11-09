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
      flash[:success] = '登録が完了しました'
      redirect_to match_schedule_results_path
    else
      flash[:danger] = '登録が失敗しました'
      render :new
    end
  end

  def edit
    #TODO: 編集画面に移ると、データが初期化されるため修正したい
    @schedule_result = ScheduleResult.find(params[:id])
  end

  def update
    @schedule_result = ScheduleResult.find(params[:id])
    @schedule_result.update_attributes(match_date_time: params[:match_date_time],
                            section: params[:section],
                            opponent: params[:opponent],
                            match_result: params[:match_result],
                            stadium: params[:stadium],
                            home_and_away: params[:home_and_away])
    flash[:success] = '更新が完了しました'
    redirect_to match_schedule_results_path
  end

  def destroy
    schedule_result = ScheduleResult.find_by(params[:id])
    schedule_result.destroy
    flash[:success] = '削除が完了しました'
    redirect_to match_schedule_results_path
  end

  private

  def schedule_result_params
    params.require(:schedule_result).permit(:match_date_time, :section, :opponent, :match_result, :stadium, :home_and_away)
  end
end
