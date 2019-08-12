class JournalsController < ApplicationController
  def new
    @journal = Journal.new
    @team = Team.find_by(id: params[:team_id])
  end

  def show
    @journal = Journal.find_by(id: params[:id])
  end

  def create
    @journal = Journal.new(journal_params)
    @journal.team_id = params[:team_id]
    @journal.user_id = current_user.id
    if @journal.save
      redirect_to @journal.team
    else
      redirect_to root_url
    end
  end

  private

  def journal_params
    params.require(:journal).permit(:content, :team_id, :user_id)
  end

end
