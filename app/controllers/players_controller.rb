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

  def edit
    if admin_user?
      @players = find_player_id
    else
      flash[:success] = '権限がないためアクセスできません'
      redirect_to players_path
    end
  end

  def update
    @players = find_player_id
    if @players.update(require_player_params)
      flash[:success] = '更新が完了しました'
      redirect_to players_path
    else
      render :edit
    end

  end

  def destroy
    player = find_player_id
    player.destroy
    flash[:success] = '削除が完了しました'
    redirect_to players_path
  end

  private
  def find_player_id
    Player.find(params[:id])
  end

  def player_params
    params.permit(:name, :squad_number, :position, :image, :image_cache)
  end

  def require_player_params
    params.require(:player).permit(:name, :squad_number, :position, :image, :image_cache)
  end
end
