class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "チームを登録しました！"
      current_user.register(@team)
      redirect_to current_user
    else
      render 'new'
    end
  end

  def join
    @team = Team.new
  end

  def register
    team = Team.find_by(team_id: params[:team][:team_id])
    if team && team.authenticate(params[:team][:password])
      if current_user.teams.include?(team)
        flash[:danger] = "すでに参加されています。"
      else
        flash[:success] = "チームに参加しました。"
        current_user.register(team)
      end
      redirect_to current_user
    else
      @team = Team.new
      flash.now[:danger] = "チームが存在しません。"
      render 'join'
    end
  end

  def team_params
    params.require(:team).permit(:name, :team_id, :password, :password_confirmation)
  end
end
