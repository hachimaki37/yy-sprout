class Match::ScheduleResultsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @schedule_results = ScheduleResult.all.order(section: "ASC")
  end

  def new
    if admin_user?
      @schedule_results = ScheduleResult.new
    else
      flash[:success] = '権限がないためアクセスできません'
      redirect_to match_schedule_results_path
    end
  end

  def create
    @schedule_result = ScheduleResult.create(schedule_result_params)
    @schedule_result.user_id = current_user.id
    if @schedule_result.save
      flash[:success] = '登録が完了しました'
      redirect_to match_schedule_results_path
    else
      flash[:danger] = '登録が失敗しました'
      render :new
    end
  end

  def edit
    if admin_user?
      @schedule_result = find_Schedule_Result_id
    else
      flash[:success] = '権限がないためアクセスできません'
      redirect_to match_schedule_results_path
    end
  end

  def update
    @schedule_result = find_Schedule_Result_id
    if @schedule_result.update(schedule_result_params)
    flash[:success] = '更新が完了しました'
    redirect_to match_schedule_results_path
    else
      render :edit
    end
  end

  def destroy
    schedule_result = find_Schedule_Result_id
    schedule_result.destroy
    flash[:success] = '削除が完了しました'
    redirect_to match_schedule_results_path
  end

  private
  def find_Schedule_Result_id
    ScheduleResult.find(params[:id])
  end

  def schedule_result_params
    params.require(:schedule_result).permit(:match_date_time, :section, :opponent, :match_result, :stadium, :home_and_away)
  end
end
