class UsersController < ApplicationController
  def index
    @users = User.ordered.page(params[:page])
  end

  def show
    @user = User.ordered.find(params[:id])
  end
end
