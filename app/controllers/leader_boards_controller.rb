class LeaderBoardsController < ApplicationController
  respond_to :json

  def index
    @users = User.leader_board
  end

end