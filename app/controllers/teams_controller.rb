class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "チームを登録しました！"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def team_params
    params.require(:team).permit(:name, :team_id, :password, :password_confirmation)
  end
end
