class UsersController < ApplicationController
  def index
    @users = User.ordered.page(params[:page])
  end

  def show
    @user = User.includes(:playlists).ordered.find(params[:id])
  end
end
