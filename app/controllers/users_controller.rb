class UsersController < ApplicationController
  def index
    @users = User.all

    def show
      @user = User.find(params[:id])
    end
  end
end
