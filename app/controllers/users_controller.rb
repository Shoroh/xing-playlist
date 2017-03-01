class UsersController < ApplicationController
  def index
    @users = User.available
  end

  def show
    @user = User.available.first
  end
end
