class HomesController < Match::ScheduleResultsController
  def index
    @schedule_result = public_method(:index).super_method.call.where(match_result: nil).first
  end
  def
    'herrol'
  end

end
