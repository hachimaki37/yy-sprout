class PlayersController < ApplicationController
  def index
    @players = Player.all.order(position: "ASC")
  end

  def new
    if admin_user?
      @players = Player.new
    else
      flash[:success] = '権限がないためアクセスできません'
      redirect_to players_path
    end
  end

  def create
    @players = Player.create(player_params)
    if @players.save
      flash[:success] = '選手登録が完了しました'
      redirect_to players_path
    else
      render :new
    end
  end


  private
  def player_params
    params.permit(:name, :squad_number, :birthday, :position, :image, :image_cache)
  end
end
